# End to End Example - Concourse CI

This is an end-to-end deployment of a single infrastructure component, in this
case it's a ConcourseCI instance. We combine several tools to make this work:

* Rake - for task management
* Terraform - for infrastructure provisioning, heavily leaning on Infrablocks
* Confidante - for configuration management

## Concepts

Infrablocks modules, and our configuration, contain some terms which need
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

## Quick Deploy

```bash
$ direnv allow
$ git-crypt unlock ./git-crypt-key

$ DEPLOYMENT_IDENTIFIER=example

$ go "bucket:provision[$DEPLOYMENT_IDENTIFIER]"
$ go "domain:provision[$DEPLOYMENT_IDENTIFIER]"
$ go "network:provision[$DEPLOYMENT_IDENTIFIER]"
$ go "web_image_repository:provision[$DEPLOYMENT_IDENTIFIER]"
$ go "worker_image_repository:provision[$DEPLOYMENT_IDENTIFIER]"
$ go "web_image:publish[$DEPLOYMENT_IDENTIFIER]"
$ go "worker_image:publish[$DEPLOYMENT_IDENTIFIER]"
$ go "cluster:provision[$DEPLOYMENT_IDENTIFIER]"
$ go "database:provision[$DEPLOYMENT_IDENTIFIER]"
$ go "service:provision[$DEPLOYMENT_IDENTIFIER]"
```
