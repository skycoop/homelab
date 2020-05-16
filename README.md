# homelab
My homelab is built on a [Pico 3 Raspberry Pi 4 cluster](https://www.picocluster.com/collections/raspberry-pi4/products/pico-3-raspberry-pi4) 
running Raspbian Buster Lite and k3s

## Bootstrapping k8s
I'm using k3s to run k8s, and using [k3sup](https://github.com/alexellis/k3sup) to bootsrap k3s on the cluster. After
installing `k3sup` and ensuring that the cluster hosts trust your SSH key, you can run the script to bring up the
cluster and have it configure your 
```bash
./bootstrap.sh
```

## Installing applications
Applications are managed with helm and helmfile
```
sops -d secrets/gcp.enc.json >! secrets/gcp.json
kubectl create ns inlets
kubectl create secret generic --namespace inlets inlets-access-key --from-file=inlets-access-key=secrets/gcp.json
helmfile apply
```
