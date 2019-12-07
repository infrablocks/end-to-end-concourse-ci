# End to End Example - Concourse CI

This is an end-to-end deployment of a single infrastructure component, in this
case it's a ConcourseCI instance. We combine several tools to make this work:

* Rake - for task management
* Terraform - for infrastructure provisioning, heavily leaning on InfraBlocks
* Confidante - for configuration management

## Concepts

InfraBlocks modules, and our configuration, contain some terms which need
explanation:

### Component

A collection of infrastructure, which together provides value. For example, a
typical micro-service to serve customer information, with a database and an ECS
Service, would all come under the component `customer-service`. For this 
codebase, we've just used `concourse-example`, but this could easily be 
`ci-server`.

### Role

The individual bits that make up a component. Examples of roles include the 
`database`, `log-group`, and the `service`. You can see how we layer together
roles in the `config/infra/roles` directory.

### Deployment Identifier

A label so you can differentiate between multiple deployments of the same 
component. This could be tied to an environment, e.g. `development` or 
`production`, or something more clever. We've used a mixture of environment and
build flavours, so we could run A/B tests of services, e.g. `production-blue`
and `production-green`.

## Deployment

This code requires terraform 0.12 or greater.

### Setting up your machine (optional)

We use the `go` script to automate pre-install steps like installing Gems. To 
get `go` onto the PATH, we use direnv. If you want to skip this step, use `rake` 
instead of `go` in all the commands below.

```bash
$ brew install direnv
$ direnv allow
```

### Unlocking secrets

It's not recommended, but for this example we keep secrets in the repository.

We keep them locked up using `git-crypt`, but we've provided the key for you to
unlock them.

**If you want to deploy this for real, roll these secrets!**

```bash
$ brew install git-crypt
$ git-crypt unlock ./git-crypt-key
```

### Choose a deployment identifier

Because S3 buckets are global, if you deployed this all as-is you'd likely bump
into others (including us!) for things like S3 buckets. So you need to change
the deployment identifier.

It can be anything you want. :-)

``` bash
$ export DEPLOYMENT_IDENTIFIER=example
```

### Provision the state bucket

We need to store remote terraform state, so the first thing we do is build an S3
bucket to keep it all in.

```bash
$ go "bucket:provision[$DEPLOYMENT_IDENTIFIER]"
```

The state for this bucket is stored in the `state` folder in this repository.

If you want to use this repository as part of a team environment, you need to go
into the `.gitignore` file and delete the following:

```
# State bucket state - remove this
state/*
```

### Provision the DNS zone

In this example, we stand up a public and private zone so we can refer to our
CI by name rather than by IP address.

```bash
$ go "domain:provision[$DEPLOYMENT_IDENTIFIER,example.com]"
```

### Setup a TLS Certificate

You'll also need to go to the _Certificate Manager_ in AWS, and create a TLS
certificate for your domain. If your domain is `example.com`, your certificate
should cover `example.com` and `*.example.com`.

### Provision the network

We need to build a network to put our services into. At the moment it just takes
up `10.0.0.0/16`.

```bash
$ go "network:provision[$DEPLOYMENT_IDENTIFIER]"
```

### Publishing the Docker images

We want to deploy Concourse on ECS, so we need somewhere to put our Concourse
Docker images, and then we need to deploy them.

#### Web Interface

```
$ go "web_image_repository:provision[$DEPLOYMENT_IDENTIFIER]"
$ go "web_image:publish[$DEPLOYMENT_IDENTIFIER]"
```

#### Workers

```
$ go "worker_image_repository:provision[$DEPLOYMENT_IDENTIFIER]"
$ go "worker_image:publish[$DEPLOYMENT_IDENTIFIER]"
```

### Provisioning the Cluster

We need to provision some machines to run our ECS cluster on. In this example
we spin up a single `t2.medium` box per availability zone. In this case, it's
three.

```
$ go "cluster:provision[$DEPLOYMENT_IDENTIFIER]"
```

### Provisioning the Database

Concourse needs some kind of SQL database to store build information in, so we
provision a Postgres instance using RDS.

```
$ go "database:provision[$DEPLOYMENT_IDENTIFIER]"
```

### Provisioning the Services

Once we have everything we need, now we just need to tell ECS to deploy the
services. This will give us some ECS services, as well as a load balancer.

Note: In this example, we've opened up the CI to `0.0.0.0/0`.

```
$ go "services:provision[$DEPLOYMENT_IDENTIFIER]"
```
