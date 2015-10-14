# Assemblyline
## Ruby
Based on `quay.io/assemblyline/buildpack_deps`, this image should include everything needed to run a ruby appication on docker.

### Automated Build
This image is built automaticly on [quay.io](https://quay.io/repository/assemblyline/ruby). And as it is based on `quay.io/assemblyline/buildpack_deps` should automaticly get any package updates that are needed.

### Suported Versions

* Current stable - 2.2.3
`docker pull quay.io/assemblyline/ruby:2.2.3`
* Previous stable - 2.1.7
`docker pull quay.io/assemblyline/ruby:2.1.7`
* Old stable (2.0.0 series)
`docker pull quay.io/assemblyline/ruby:2.0.0-p647`

Other tags are avalible in the repository with older versions but are only 
intended to be used as a stopgap until you can upgrade your application
to the latest point release. These images should not be used in production
as they contain various security issues.
