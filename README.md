# Assemblyline
## Ruby
Based on `quay.io/assemblyline/buildpack_deps`, this image should include everything needed to run a ruby appication on docker.

### Automated Build
This image is built automaticly on [quay.io](https://quay.io/repository/assemblyline/ruby). And as it is based on `quay.io/assemblyline/buildpack_deps` should automaticly get any package updates that are needed.

### Suported Versions

* Current stable - 2.2.2
`docker pull quay.io/assemblyline/ruby:2.2.1`
* Previous stable - 2.1.6
`docker pull quay.io/assemblyline/ruby:2.1.5`
* Old stable (2.0.0 series)
`docker pull quay.io/assemblyline/ruby:2.0.0-p645`

Other tags are avalible in the repository but are unsupported may not recive security updates.
