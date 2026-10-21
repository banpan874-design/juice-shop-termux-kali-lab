# Android Termux installation

## Important compatibility note

OWASP Juice Shop is a Node.js application, but Android/Termux is not one of its standard supported deployment targets. Its dependency tree may require native modules or binaries that are unavailable for your phone's Android architecture. Try this only if you are comfortable with a possible install failure. Do not install random unofficial APKs or download prebuilt binaries from untrusted sources.

## A. Prepare Termux

Use a current Termux build from a trusted official distribution source. Open Termux and run these commands one at a time:

```sh
pkg update
pkg upgrade -y
pkg install git nodejs-lts -y
node --version
npm --version
```

Compare your Node.js version with the current supported versions in the [official Juice Shop README](https://github.com/juice-shop/juice-shop#nodejs-version-compatibility). Do not assume a version listed in old tutorials is still supported.

## B. Download the official source

```sh
cd ~
git clone --depth 1 https://github.com/juice-shop/juice-shop.git
cd ~/juice-shop
```

If you already cloned it, use `cd ~/juice-shop && git pull` only if you understand that this updates your working tree.

## C. Install and run

```sh
npm install
npm start
```

The first install may take time and use significant storage and mobile data. Keep the screen awake while installing, if Android is stopping the process. When it starts, open `http://127.0.0.1:3000` in the phone's browser.

To stop it, return to Termux and press **Ctrl+C**.

## D. If installation fails

Capture the final 30–50 lines of the error. Common causes include:
- Node.js version is unsupported by the current Juice Shop release.
- A native dependency has no compatible Android/ARM prebuilt binary.
- Build tools or headers are missing.
- Insufficient storage, memory, or interrupted network access.

Do not randomly downgrade packages or paste unknown root scripts into Termux. Check the official [running guide](https://pwning.owasp-juice.shop/companion-guide/latest/part1/running.html) and [troubleshooting guide](https://pwning.owasp-juice.shop/companion-guide/latest/part4/troubleshooting.html).

## E. Reliable fallback: run the target on Kali

If Termux cannot build the dependencies, run Juice Shop on Kali instead. Kali's package may be available from its repositories:

```sh
sudo apt update
apt show juice-shop
sudo apt install juice-shop
```

Then use the installed package's documented start/stop commands (check `juice-shop-start --help` and `juice-shop-stop --help`). Alternatively, follow the official Juice Shop Docker/source instructions. A local-only Docker binding such as `127.0.0.1:3000:3000` is safer for same-machine testing, but it will not allow the phone to be the remote target. Do not expose a vulnerable service to the internet.

## F. Make it reachable from Kali

For phone-hosted testing, the server must accept connections from the phone's private network interface. Juice Shop versions may differ in host-binding behavior. First confirm local access. Then follow [private network setup](private-network-setup.md). If the server listens only on loopback, do not disable security controls blindly; use the documented configuration for your exact version or run the target on Kali instead.
