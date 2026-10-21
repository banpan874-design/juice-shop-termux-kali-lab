# Kali tool chooser for a localhost-only Juice Shop lab

This guide is intentionally scoped to **the Juice Shop instance running on the same Kali computer** at `http://127.0.0.1:3000`. It is designed to teach a student which tool fits which task, not to run every tool at once.

## First: enforce the localhost boundary

Start Juice Shop on Kali using the official instructions, then verify it opens locally. In every command in this guide, the target is fixed to loopback:

```sh
curl -I --max-time 5 http://127.0.0.1:3000/
```

If this does not work, fix the local application first. Do not substitute a public domain, a different IP address, or a whole subnet. **A Kali computer's `127.0.0.1` means Kali itself**, not your phone. If Juice Shop is running on your phone, `127.0.0.1` on Kali will not reach it; use the separate phone-to-Kali network guide only when you deliberately want that private-network setup.

## Choose the right tool

| Task | Tool | When to use it | Beginner-safe starting point |
|---|---|---|---|
| Check whether the local app responds | `curl` | Before any other testing | `curl -I --max-time 5 http://127.0.0.1:3000/` |
| Identify the web technology | WhatWeb | Basic fingerprinting | `whatweb http://127.0.0.1:3000/` |
| Check the one local service/port | Nmap | Confirm the local listener | `nmap -n -Pn -sT -sV --version-light -p 3000 127.0.0.1` |
| Understand requests and responses | Burp Suite Community | Manual inspection and controlled request replay | Open Burp's built-in browser and visit the local URL |
| Review passive web alerts | OWASP ZAP Baseline | Low-impact passive review | Use the baseline scan only against the exact local URL |
| Check common web server misconfigurations | Nikto | Optional, after basic HTTP checks | `nikto -host http://127.0.0.1:3000` |
| Find application routes | Burp Site map / browser dev tools | Discover paths through normal app use | Browse the app and review the local history |
| Learn a specific vulnerability | Juice Shop scoreboard + Burp Repeater | Best first choice for students | Select one built-in challenge and follow its hints |
| Automated SQL injection testing | sqlmap | Advanced, only after understanding the exact local challenge endpoint | Prefer manual challenge steps first; see the caution below |
| Capture evidence and write findings | Burp history + notes | Every confirmed issue | Save minimal redacted request/response evidence |

Install only tools you need, from Kali's repositories or their official sources. Package names and options can change; check each tool's local `--help` and official documentation.

## Suggested install commands on Kali

These commands install common tools from configured Kali repositories; you can skip tools you do not need.

```sh
sudo apt update
sudo apt install curl nmap whatweb nikto burpsuite zaproxy
```

Some packages may not be available in every Kali image or repository configuration. Check first with `apt show PACKAGE_NAME`. Burp Suite Community can also be installed from PortSwigger's official website.

## Recommended workflow: one tool at a time

### Stage 1 — Verify

```sh
curl -I --max-time 5 http://127.0.0.1:3000/
```

If the request fails, do not scan. Check that Juice Shop is running and review its startup output.

### Stage 2 — Minimal service discovery

```sh
nmap -n -Pn -sT -sV --version-light -p 3000 127.0.0.1
```

This checks only TCP port 3000 on the local machine. It does not prove that the application is vulnerable.

### Stage 3 — Observe normal behavior

Use Burp's built-in browser to visit the app. Start with **Proxy → HTTP history** and **Target → Site map**. Note the paths, methods, response codes, and content types. Do not share session cookies or tokens.

### Stage 4 — Passive review

Use ZAP Baseline against the exact local URL if you want a second opinion. Read the current ZAP documentation before running a command-line scan. Passive alerts are leads to investigate, not confirmed vulnerabilities.

### Stage 5 — Validate one finding

Pick one built-in Juice Shop challenge. Form a hypothesis, use the minimum test needed, compare expected and actual behavior, and stop once the challenge is demonstrated. Prefer Burp Repeater and the challenge hints over launching multiple automated tools.

### Stage 6 — Optional specialized tools

Use Nikto only if you are learning server misconfiguration checks. Use sqlmap only if a specific Juice Shop challenge and its exact local endpoint call for it, and only after understanding what the request does. Keep any tool target fixed to `127.0.0.1:3000`; do not run automated exploitation against unknown hosts or arbitrary URLs.

For students, automated exploitation is not a shortcut to understanding. First reproduce a challenge manually, explain the root cause, then compare the tool's output and false positives.

## Interpreting results

For each alert, ask:
1. Can I reproduce it on the local app?
2. Is the evidence specific, or is it only a generic scanner warning?
3. What is the realistic impact?
4. What code/configuration change would prevent it?
5. Can I retest the fix?

Record tool name/version, local target, timestamp, minimal redacted evidence, confidence, impact, remediation, and retest result.

## Hard limits

- Target only `127.0.0.1:3000` in this guide.
- Do not change the target to a public IP, domain, LAN subnet, or another device.
- Do not use denial-of-service, persistence, credential theft, or destructive tests.
- Do not upload session tokens, passwords, or private data to this public repository.
- Stop Juice Shop with Ctrl+C when finished.

References:
- [OWASP Juice Shop](https://github.com/juice-shop/juice-shop)
- [OWASP Juice Shop Companion Guide](https://pwning.owasp-juice.shop/)
- [Burp Suite documentation](https://portswigger.net/burp/documentation)
- [OWASP ZAP documentation](https://www.zaproxy.org/docs/)
- [Nmap reference guide](https://nmap.org/book/man.html)
