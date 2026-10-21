# Troubleshooting

## `pkg install nodejs-lts` fails

- Run `pkg update && pkg upgrade -y` and retry.
- Confirm you are using a current Termux distribution.
- If the package name is unavailable, inspect available packages with `pkg search nodejs`; do not install untrusted binaries.
- Record `node --version` and `npm --version`.

## `npm install` fails in Termux

Termux is not a standard supported Juice Shop host, and native dependencies may not compile for Android. Save the last 30–50 lines of the error and compare your Node.js version with the official project README. Do not assume every build failure can be fixed by installing random packages. Use the Kali-hosted fallback in [Termux installation](termux-installation.md#e-reliable-fallback-run-the-target-on-kali).

## `npm start` says port 3000 is already in use

A prior process may still be running. Inspect processes first:

```sh
ps -A | grep -i '[j]uice-shop\|[n]ode'
```

Stop only the process you started for this lab, preferably with Ctrl+C in its original terminal. Do not blindly kill every Node process; another app may depend on it.

## Phone can open the app, but Kali cannot

1. Check the app is running and the phone can open `http://127.0.0.1:3000`.
2. Verify the phone and Kali are on the same private Wi-Fi/hotspot.
3. Re-check the phone's private IP.
4. Run from Kali: `curl -I --max-time 5 http://PHONE_LAN_IP:3000`.
5. Guest Wi-Fi client isolation may block devices from reaching each other.
6. The server may be listening only on loopback. Confirm the correct host-binding behavior for your Juice Shop version; do not expose the service publicly as a workaround.

## `curl` works but Firefox does not

- Try the exact URL including `:3000`.
- Temporarily disable the browser proxy unless intentionally using Burp.
- If using Burp, open **Proxy → HTTP history** and confirm the request appears.
- With Burp Intercept on, requests can pause until you forward them; switch Intercept off to browse normally.

## Burp shows no traffic

- Use Burp's built-in browser first.
- Verify Burp's local proxy listener is running on `127.0.0.1:8080`.
- If using Firefox, confirm its proxy settings point to the Kali loopback address, not the phone IP.
- Ensure the browser is visiting the lab URL and not a different tab/profile.

## Blank page or slow startup

- Wait for the startup log to finish.
- Check available storage and memory.
- Review the terminal for dependency or runtime errors.
- Restart with Ctrl+C, then `npm start` again.
- Consult the [official troubleshooting guide](https://pwning.owasp-juice.shop/companion-guide/latest/part4/troubleshooting.html).

## Stop and cleanup

- In the terminal running Juice Shop, press Ctrl+C.
- Close Burp when finished.
- Do not save secrets, cookies, or credentials in screenshots or public issue reports.
- If you installed dependencies only for this lab and want to remove the cloned source, first stop the server, then carefully remove only the folder you created (for example `rm -rf ~/juice-shop`). Check the path before running a destructive command.
