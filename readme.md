
# alpine-mikrotik

A rudimentary alpine-based `linux/arm/v7` docker image which allows for easier debugging on the RouterOS container engine;
heavily inspired by the great [tailscale Mikrotik container](https://github.com/Fluent-networks/tailscale-mikrotik)

## Installation

1. Create a `veth` port for the container.

    ```shell
    # Note the `gateway` parameter: it points to the tailscale container, not the actual default gateway in bridge_containers: this keeps us from manually adding a `ip route add 100.64.0.0/10 via 172.18.0.2` shell command in the smahub dockerfile/shell script.
    /interface/veth add name=veth_alpine address=172.18.0.5/16 gateway=172.18.0.1
    ```

2. add said `veth` port to the already existing containers bridge

    ```shell
    /interface/bridge/port add bridge=bridge_containers1 interface=veth_alpine
    ```

3. Optional: Add environment variables

    ```shell
    /container/envs
    add name="alpine" key="SSH_PASSWORD" value="yourPasswordHere!" # access via `ssh root@172.18.0.5` and specifying this password
    ```

4. Create the container

    ```shell
    /container/config set registry-url=https://ghcr.io tmpdir=usb1/mikrotik/containers/pull
    /container add remote-image=shadow1runner/mikrotik-alpine:3 interface=veth_alpine envlist=alpine root-dir=usb1/mikrotik/containers/alpine start-on-boot=no logging=yes hostname=alpine dns=45.90.28.224,45.90.30.224
    ```

5. Start the container and `ssh root@172.18.0.5` into it using the afore-configured `SSH-PASSWORD`
