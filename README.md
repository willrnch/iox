This repository contains the script needed to build the [InfluxDB IOx](https://github.com/influxdata/influxdb_iox) docker images for various platforms and CPUs. 
It contains images for `linux/arm64` and `linux/amd64` (with and without AVX support). 


## Images

### Aug 21, 2023 - [fbb2460](https://github.com/influxdata/influxdb_iox/commit/fbb2460c84f8620b2e980367d897cac658163aff)
| Tag                                                                       | Platform       |
|---------------------------------------------------------------------------|----------------|
| `ghcr.io/willrnch/iox:fbb2460c84f8620b2e980367d897cac658163aff-ivybridge` | `linux/amd64`  |
| `ghcr.io/willrnch/iox:fbb2460c84f8620b2e980367d897cac658163aff`           | `linux/arm64`  |

### Aug 17, 2023 - [3612b1c](https://github.com/influxdata/influxdb_iox/commit/3612b1c48234c74b33865a62a864b07c014b9ba6)

| Tag                                                                  | Platform                    |
|----------------------------------------------------------------------|-----------------------------|
| `ghcr.io/willrnch/iox:3612b1c48234c74b33865a62a864b07c014b9ba6`      | `linux/amd64` `linux/arm64` |
| `ghcr.io/willrnch/iox:3612b1c48234c74b33865a62a864b07c014b9ba6-avx2` | `linux/amd64`               |
