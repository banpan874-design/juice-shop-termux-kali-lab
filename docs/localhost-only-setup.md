# Strict localhost-only setup

Use this mode when you want every practice command to target only the same Kali machine. It is the simplest option for a student lab.

## Start the target locally

Follow the official [OWASP Juice Shop running guide](https://pwning.owasp-juice.shop/companion-guide/latest/part1/running.html). If you use Docker, bind the service to loopback only rather than all network interfaces. Example, when using the official Juice Shop container image:

```sh
docker run --rm -p 127.0.0.1:3000:3000 bkimminich/juice-shop
```

This publishes port 3000 only on Kali's loopback interface. Keep that terminal open while practicing. If you already installed Juice Shop from source, start it according to the official instructions and verify it is reachable at `http://127.0.0.1:3000`.

## Verify local-only access

```sh
curl -I --max-time 5 http://127.0.0.1:3000/
```

If Docker is used, inspect the published port:

```sh
docker ps
```

A mapping that begins with `127.0.0.1:3000->` indicates a loopback-only published port. Avoid mappings such as `0.0.0.0:3000->` for this strict local-only mode.

## What localhost means

- `127.0.0.1` on Kali points back to Kali.
- `127.0.0.1` on Android points back to Android.
- These addresses are not interchangeable between devices.

For this strict mode, do not use your phone's LAN IP as a target. If you want to practice the original phone-to-Kali setup later, use the private-network instructions intentionally and only on your own trusted network.

## Cleanup

Stop the container with Ctrl+C or stop the specific container you started. Do not kill unrelated processes. Verify the lab is no longer responding:

```sh
curl -I --max-time 3 http://127.0.0.1:3000/
```

A failed request after shutdown is expected.
