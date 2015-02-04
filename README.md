# Assemblyline
## Ruby
Based on `assemblyline/buildpack_deps`, this image should include everything needed to run a ruby appication on docker.

### Automated Build
This image is built automaticly on docker hub. And as it is based on `assemblyline/buildpack_deps` should automaticly get any package updates that are needed.

### Suported Versions

* Current stable - 2.2.0
`docker pull assemblyline/ruby:2.2.0`
* Previous stable - 2.1.5
`docker pull assemblyline/ruby:2.1.5`
* Old stable (2.0.0 series)
`docker pull assemblyline/ruby:2.0.0-p598`
* Old stable (1.9.3 series)
`docker pull assemblyline/ruby:1.9.3-p551`