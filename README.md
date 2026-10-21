# Juice Shop Termux ↔ Kali Legal Security Lab

A beginner-friendly guide for running **OWASP Juice Shop** on an Android phone with Termux and testing it from your own Kali Linux laptop using Firefox and Burp Suite Community Edition.

> **Safety boundary:** Juice Shop is deliberately vulnerable. Use this lab only on devices and networks you own or have explicit permission to test. Keep it on a trusted private Wi-Fi/hotspot. Never port-forward it, expose it to the public internet, or scan unrelated devices.

## Lab layout

- **Android phone:** Termux + Node.js + local Juice Shop server.
- **Kali laptop:** Firefox + Burp Suite Community Edition; connects to the phone's private LAN IP.
- **Target URL:** `http://PHONE_LAN_IP:3000` (replace the placeholder with your phone's private IP).
- **Official project:** [OWASP Juice Shop source](https://github.com/juice-shop/juice-shop)
- **Official companion guide — running it](https://pwning.owasp-juice.shop/companion-guide/latest/part1/running.html)

Termux is not an officially supported Juice Shop deployment platform. Native Node dependencies can fail to build on Android. If installation fails, use the fallback described in [Termux installation](docs/termux-installation.md) and run the target on Kali instead.

## Contents

- [Termux installation](docs/termux-installation.md)
- [Private network setup](docs/private-network-setup.md)
- [Kali and Burp Suite setup](docs/kali-burp-setup.md)
- [Guided practice](docs/guided-practice.md)
- [Reconnaissance and vulnerability scanning](docs/recon-vulnerability-scanning.md)
- [Kali tool chooser](docs/tool-selection-guide.md)
- [Strict localhost-only setup](docs/localhost-only-setup.md)
- [Exploitation workflow (authorized lab only)](docs/exploitation-workflow.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Lab checklist](CHECKLIST.md)
- [Security rules](SECURITY.md)

## Quick start

### 1. Install Juice Shop on the phone

Open Termux and run each command separately:

```sh
pkg update && pkg upgrade -y
pkg install git nodejs-lts -y
node --version
npm --version
git clone --depth 1 https://github.com/juice-shop/juice-shop.git
cd juice-shop
npm install
npm start
```

Keep the Termux session running while using the lab. Open `http://127.0.0.1:3000` in the phone's browser to confirm it starts locally. See [full installation notes](docs/termux-installation.md) before troubleshooting native dependency errors.

### 2. Connect Kali to the phone

1. Put both devices on the same trusted Wi-Fi network, or connect Kali to the phone's personal hotspot.
2. Find the phone's private Wi-Fi/hotspot IP address; instructions are in [private network setup](docs/private-network-setup.md).
3. From Kali, open `http://PHONE_LAN_IP:3000` in Firefox.
4. If it does not load, check that Juice Shop is still running and follow the [troubleshooting guide](docs/troubleshooting.md).

Do not configure router port forwarding or a public tunnel.

### 3. Add Burp Suite

Install/open Burp Suite Community Edition on Kali. Use Burp's built-in browser or configure a dedicated Firefox profile to proxy through `127.0.0.1:8080`. Browse to the phone's target URL through that browser and inspect **Proxy → HTTP history**. Full instructions are in [Kali and Burp setup](docs/kali-burp-setup.md).

### 4. Practice responsibly

For the strictest beginner setup, run Juice Shop on Kali bound to localhost and follow the [localhost-only setup](docs/localhost-only-setup.md). Use the [Kali tool chooser](docs/tool-selection-guide.md) to pick the right tool for each stage, then work through [reconnaissance and vulnerability scanning](docs/recon-vulnerability-scanning.md), [guided practice](docs/guided-practice.md), and the [exploitation workflow](docs/exploitation-workflow.md). The tool chooser uses only `127.0.0.1:3000`; remember that localhost on Kali is not the same as localhost on your phone.

## Stop the lab

In the Termux window running `npm start`, press **Ctrl+C**. If the app is running in the background, use the instructions in [troubleshooting](docs/troubleshooting.md). You can also run the helper script from this repository on a compatible shell; it reports processes but does not kill unrelated services.

## Current compatibility note

Juice Shop's supported Node.js versions change over time. Check the version table in the [official repository README](https://github.com/juice-shop/juice-shop#nodejs-version-compatibility) before debugging a version mismatch. Termux package availability and native compilation can differ from standard Linux.

## License and attribution

This repository contains original learning notes and helper scripts. OWASP Juice Shop is a separate project; its source, branding, and companion guide remain subject to their own licenses. See [LICENSE](LICENSE) and [SECURITY.md](SECURITY.md).
