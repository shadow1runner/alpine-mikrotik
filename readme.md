
# alpine-mikrotik

A rudimentary alpine-based `linux/arm/v7` docker image which allows for easier debugging on the RouterOS container engine;
heavily inspired by the great [tailscale Mikrotik container](https://github.com/Fluent-networks/tailscale-mikrotik)

## Installation

1. Create a `veth` port for the container.

    ```shell
    /interface/bridge add name=bridge_containers1
    /interface/veth add name=veth_alpine address=192.168.3.5/24 gateway=192.168.3.1
    ```

2. add said `veth` port to the already existing containers bridge

    ```shell
    /interface/bridge/port add bridge=bridge_containers1 interface=veth_alpine
    ```

3. Add environment variables

    ```shell
    /container/envs
    # access via `ssh root@192.168.3.5` and specifying this password
    add name="alpine" key="SSH_PASSWORD" value="TODO:yourPasswordHere!"
    ```

4. Create the container

    ```shell
    /container/config set registry-url=https://ghcr.io tmpdir=usb1/mikrotik/containers/pull
    /container add remote-image=shadow1runner/alpine-mikrotik:main interface=veth_alpine envlist=alpine root-dir=usb1/mikrotik/containers/alpine start-on-boot=no logging=yes hostname=alpine dns=45.90.28.224,45.90.30.224
    ```

5. Start the container and `ssh root@192.168.3.5` into it using the afore-configured `SSH-PASSWORD`
