# Private network setup: Android phone ↔ Kali laptop

## Choose a trusted network

Use one of these:
1. Both devices on your own trusted home Wi-Fi; or
2. Enable the phone's personal hotspot and connect the Kali laptop to it.

Do not use a public/shared Wi-Fi network. If possible, turn off other devices' access to the hotspot during the exercise. Keep the lab closed to anyone who has not agreed to participate.

**Never** configure router port forwarding, a public tunnel, or cloud hosting for this intentionally vulnerable application.

## Find the phone's private IP

On Android, open Wi-Fi or Hotspot settings and inspect the connected network details. The IP might look like `192.168.x.x`, `10.x.x.x`, or `172.16.x.x`–`172.31.x.x`; the actual range depends on the network.

In Termux, you can try:

```sh
pkg install iproute2 -y
ip addr
ip route
```

If `ip` is unavailable, try:

```sh
pkg install net-tools -y
ifconfig
```

Use the address belonging to the Wi-Fi/hotspot interface, not `127.0.0.1`. Do not share your public IP; the lab should use a private address.

## Test from Kali

Replace `PHONE_LAN_IP` with the phone's private address:

```sh
ping -c 3 PHONE_LAN_IP
curl -I --max-time 5 http://PHONE_LAN_IP:3000
```

Some Android networks block ping, so a failed ping alone does not prove the service is unreachable. The HTTP test is more relevant.

Then open this in Kali Firefox:

```text
http://PHONE_LAN_IP:3000
```

## If the page does not load

1. Confirm `npm start` is still running in Termux.
2. Confirm the phone itself can open `http://127.0.0.1:3000`.
3. Verify both devices are on the same private network.
4. Re-check the phone's current IP; hotspot addresses can change.
5. Check whether Juice Shop listens on a LAN interface rather than only loopback. Do not use a public tunnel as a workaround.
6. Check Android battery/background restrictions and any firewall on Kali.

Some guest Wi-Fi networks enable client isolation, which prevents devices from reaching each other. Switch to your own hotspot/private network rather than trying to bypass a network administrator's restrictions.

## Keep the exposure limited

- Start Juice Shop only when you are practicing.
- Do not port-forward TCP 3000 on a router.
- Do not bind the service to a public interface or publish its address online.
- Stop the process with Ctrl+C when finished.
- If the phone is using a shared network you do not control, stop and move the lab to a private network.
