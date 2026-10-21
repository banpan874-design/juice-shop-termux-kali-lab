# Kali Linux + Burp Suite Community Edition

This guide assumes Kali is your testing laptop and the phone is the lab target. Install tools only from their official sources or Kali's repositories.

## 1. Verify the target first

From Kali, open Firefox and visit:

```text
http://PHONE_LAN_IP:3000
```

Replace `PHONE_LAN_IP` with the phone's private address. If it does not load, fix network access first using [private network setup](private-network-setup.md).

## 2. Install/open Burp Suite Community Edition

If available in your Kali repositories:

```sh
sudo apt update
apt show burpsuite
sudo apt install burpsuite
```

Open Burp Suite Community Edition from the application menu. Use the default temporary project unless you have a reason to save a project file.

## 3. Start with Burp's built-in browser (recommended)

1. In Burp, open **Proxy → Intercept** and ensure interception is off while first loading pages, if the browser appears stuck.
2. Open **Proxy → Open browser** (wording can vary by version).
3. In Burp's built-in browser, visit `http://PHONE_LAN_IP:3000`.
4. In Burp, open **Proxy → HTTP history**. Select a request to inspect its method, path, headers, parameters, status code, and response.

The built-in browser is simplest because it is already configured to use Burp.

## 4. Optional: dedicated Firefox profile

If you prefer Firefox, configure a separate test profile so ordinary browsing is not proxied.

1. In Firefox network settings, select manual proxy configuration.
2. Set HTTP proxy to `127.0.0.1`, port `8080`; enable the option to use this proxy for HTTPS only if needed. Burp's default local proxy listener is commonly port 8080.
3. Confirm Burp's **Proxy → Proxy settings/listeners** shows a listener on Kali loopback `127.0.0.1:8080`.
4. Visit the phone target URL and check **HTTP history**.

Do not expose Burp's proxy listener to the LAN or the internet. It only needs to accept local browser connections on Kali.

## 5. HTTPS and certificate note

The default lab URL is HTTP, so a Burp CA certificate is normally unnecessary. If you intentionally configure HTTPS for a lab, use a dedicated test browser profile and follow PortSwigger's official instructions to trust Burp's CA only in that profile. Never install a testing CA certificate system-wide or in your everyday browser without understanding the risk.

## 6. Practice safely

- Keep the target host set to the phone's private IP and port 3000.
- Use HTTP history and Repeater to inspect/replay requests only against Juice Shop.
- Use scope controls to keep the target limited to the lab host.
- Do not run automated active scans against anything outside the lab.
- Turn Intercept off when you want pages to load normally; turn it on only when deliberately inspecting a specific request.
- Stop Juice Shop when done.
