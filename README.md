# End to End Example - Concourse CI

This is an end-to-end deployment of a single infrastructure component, in this
case it's a ConcourseCI instance. We combine several tools to make this work:

* Rake - for task management
* Terraform - for infrastructure provisioning, heavily leaning on Infrablocks
* Confidante - for configuration management

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
$ go "database:provision[$DEPLOYMENT_IDENTIFIER]"
$ go "service:provision[$DEPLOYMENT_IDENTIFIER]"
```
