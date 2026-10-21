# Lab checklist

## Before starting

- [ ] I own or have permission to use both devices.
- [ ] Phone and Kali are on a trusted private Wi-Fi/hotspot.
- [ ] No router port forwarding, public tunnel, or public deployment is configured.
- [ ] Termux, Node.js, and npm versions are noted.
- [ ] Juice Shop starts and loads locally on the phone.
- [ ] I know the phone's current private IP address.
- [ ] Kali can open `http://PHONE_LAN_IP:3000`.

## During practice

- [ ] Burp scope is limited to the lab target.
- [ ] I only use lab-created accounts and data.
- [ ] I do not scan or attack unrelated hosts.
- [ ] I redact cookies, tokens, and secrets from evidence.
- [ ] I record expected behavior, actual behavior, impact, and remediation.

## After practice

- [ ] Stop Juice Shop with Ctrl+C.
- [ ] Close Burp and the test browser.
- [ ] Do not publish credentials, cookies, or private IP/network details unnecessarily.
- [ ] Keep notes focused on the lab and defensive learning.
