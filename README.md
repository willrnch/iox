This repository contains the script needed to build the [InfluxDB IOx](https://github.com/influxdata/influxdb_iox) docker images for various platforms and CPUs. 
It contains images for `linux/arm64` and `linux/amd64` (with and without AVX2 support). 


## Images

### Aug 17, 2023 - [3612b1](https://github.com/influxdata/influxdb_iox/commit/3612b1c48234c74b33865a62a864b07c014b9ba6)

| Tag                                                                  | Platform                    |
|----------------------------------------------------------------------|-----------------------------|
| `ghcr.io/willrnch/iox:3612b1c48234c74b33865a62a864b07c014b9ba6`      | `linux/amd64` `linux/arm64` |
| `ghcr.io/willrnch/iox:3612b1c48234c74b33865a62a864b07c014b9ba6-avx2` | `linux/amd64`               |