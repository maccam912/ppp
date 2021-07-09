# Plutus Pioneers Program - Docker Playground



------

**NOTE: This repo was for cohort 1. The pattern can probably continue to be followed. Check `Issues` and `Pull requests` to see if there are changes in case this repo seems to be broken. I will also point out https://github.com/nstankov-bg/ppp as a fork for cohort 2.**

------



The dockerfiles are current for the right plutus commit for Week06 homework. I'll try to keep it up-to-date.



## Build locally

```bash
docker-compose up -d
```

To build for a specific week, the commit-tag, of the [plutus](https://github.com/input-output-hk/plutus) clone command, needs to be changed inside the Dockerfile.

```dockerfile
WORKDIR /opt
### change here
ARG PLUTUS_GIT_COMMIT=ea0ca4e9f9821a9dbfc5255fa0f42b6f2b3887c4
###
RUN git clone https://github.com/input-output-hk/plutus /opt/plutus && \
	cd /opt/plutus && \
	git checkout ${PLUTUS_GIT_COMMIT}
```



## Prebuild images of week X (01 - 08) and cohort Y (1, 2)

Run the prebuild images with

```bash
docker-compose -f docker-compose-week<X>-cohort<Y>.yml up -d
```

Afterwards navigate your browser to [https:localhost:8009](https:localhost:8009)

**NOTE: ** the **s** in http**s**.





### MORE

- Pioneer Wiki - https://docs.plutus-community.com/
