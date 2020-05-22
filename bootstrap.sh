#!/bin/bash
set -ex

# Hack around k3sup not supporting channels (https://github.com/alexellis/k3sup/issues/237)
export K3S_VERSION="v1.18.2+k3s1"
export USER="pi"
export MASTER="192.168.86.13"
export NODE_1="192.168.86.14"
export NODE_2="192.168.86.15"

k3sup install \
  --ip ${MASTER} \
  --user ${USER} \
  --k3s-version ${K3S_VERSION} \
  --no-extras \
  --context homelab \
  --local-path ~/.kube/config \
  --merge

k3sup join \
  --ip ${NODE_1} \
  --user ${USER} \
  --server-ip ${MASTER} \
  --server-user ${USER} \
  --k3s-version ${K3S_VERSION}

k3sup join \
  --ip ${NODE_2} \
  --user ${USER} \
  --server-ip ${MASTER} \
  --server-user ${USER} \
  --k3s-version ${K3S_VERSION}
