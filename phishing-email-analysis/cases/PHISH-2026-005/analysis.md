# PHISH-2026-005 — Gmail Support impersonation / Cloud+ payment-failure lure

**Classification:** High-confidence phishing / account and payment-data lure  
**Triage severity:** Medium triage priority; potentially high if payment or account information was submitted  
**Analyst confidence:** High  
**Interaction status:** Not assessed for this email.  
**Evidence handling:** The original user-supplied message is retained outside this public project. This folder contains a sanitized, defanged copy only.

## Executive summary

The Gmail support impersonation, unrelated From/Sender/Return-Path/DKIM domains, urgent payment-update and deletion threat, cloud-hosted CTA, and contaminated MIME body support a high-confidence phishing classification. The message does not prove that any account or data was accessed.

## Message details

| Field | Observed value |
|---|---|
| Date | 2026-10-22 08:53:57 UTC (header Date: 09:53:57 +0100) |
| Subject | WARNING: Failure Notice 22-10-2026 |
| From | `GmailSupportTeam <alert-164-232081@bfjww.svg>` |
| From domain | `bfjww[.]svg` |
| Return-Path domain | `one[.]bss0021[.]pepsilululemon[.]biz[.]ua` |
| Google-observed source IP | `212[.]83[.]137[.]128` |
| Peer hostname in Google-added ingress header | `blog[.]capodarte[.]com[.]br` |
| Original file size | 17,412 bytes |
| Original SHA-256 | `67cb963febdbfc5e83e996b51227375ced3a5ef4883c2d0aff240e1a2af58462` |
| Sanitized evidence SHA-256 | `92bab3130b72750520727685e1ebccbe3f676c419b4e470a75db44c15034490b` |

## Authentication results

| Check | Result in supplied headers | Analyst interpretation |
|---|---|---|
| SPF | PASS |
| DKIM | PASS |
| DMARC | Not present in supplied Authentication-Results |

Authentication checks apply to the domains used by the sender. A PASS does not prove the message represents a claimed brand, that a link is safe, or that the content is legitimate. A missing DMARC result is recorded as missing, not as a failure.

## Content and header findings

1. The visible sender name claims Gmail Support, but the From address is on bfjww.svg. The Sender/Return-Path and DKIM identities use unrelated domains under one.bss0021.pepsilululemon.biz.ua.
2. SPF and DKIM pass for the supplied sender infrastructure, but they do not authenticate a Google/Gmail relationship. The From domain does not align with the sender and DKIM domains; no DMARC result is included in the supplied Authentication-Results.
3. Google records source IP 212.83.137.128 and peer hostname blog.capodarte.com.br, while the SMTP host is one.bss0021.pepsilululemon.biz.ua.
4. The body uses urgent data-loss language and a payment-update CTA. It falsely claims the recipient is about to lose a wide range of personal data and device backups.
5. The CTA is an HTML object hosted under storage.googleapis.com. The list-unsubscribe and list-archive host is qvxmsui.com. Neither was opened.
6. The body contains unrelated story, travel, and health-related newsletter fragments. The MIME multipart/digest has an empty HTML part, a substantive HTML part with the nonstandard transfer encoding "7TbtCXnkBu", and a further unrelated HTML part.
7. No file attachment was detected. The phrase "This message was sent from a trusted sender" appears inside the HTML body; it is sender-authored text, not a trustworthy security indicator.

## URL and domain observations

| Host | Role in message | Interpretation |
|---|---|---|
| `storage[.]googleapis[.]com` | Main click-through object host; object path hmdbox/hmd-v1-cl3.html | Shared cloud-storage host; object not fetched |
| `qvxmsui[.]com` | List-Unsubscribe and List-Archive host | Unverified tracking/list domain; not opened |

Additional observed hostnames:
- `bfjww[.]svg` — Visible From domain.
- `164[.]232081[.]7k8d[.]one[.]bss0021[.]pepsilululemon[.]biz[.]ua` — DKIM signing identity.
- `blog[.]capodarte[.]com[.]br` — Peer hostname shown in Google-added Received header.

URLs were not opened, redirects were not followed, and tracking query/fragment values have been removed from the public evidence. `storage.googleapis.com` is a legitimate Google Cloud Storage hostname; its presence does not imply Google authored or endorsed the hosted HTML. The object path is unverified.

## Indicators of compromise / observables

| Type | Defanged indicator | Context | Confidence | Status | Notes |
|---|---|---|---|---|---|
| domain | `bfjww[.]svg` | Visible From domain | High | observed | Unverified domain; displayed identity claims Gmail Support |
| domain | `one[.]bss0021[.]pepsilululemon[.]biz[.]ua` | Sender and Return-Path domain | High | observed | Unverified sender infrastructure |
| domain | `164[.]232081[.]7k8d[.]one[.]bss0021[.]pepsilululemon[.]biz[.]ua` | DKIM signing identity | Medium | observed | Signature passes for this identity; brand legitimacy not established |
| ipv4 | `212[.]83[.]137[.]128` | Google-observed SMTP source IP | High | observed | Reputation not checked |
| domain | `blog[.]capodarte[.]com[.]br` | Peer hostname in Google-added Received header | Medium | observed | Reputation not checked |
| domain | `storage[.]googleapis[.]com` | Main HTML click-through host | High | observed | Legitimate shared hosting domain; exact object not fetched |
| domain | `qvxmsui[.]com` | List-Unsubscribe and List-Archive host | High | observed | Unverified; not opened |

The IOC list contains observed indicators, not confirmed malicious infrastructure. Reputation and ownership were not checked.

## Verdict

**High-confidence phishing / account and payment-data lure — confidence: High.** The Gmail support impersonation, unrelated From/Sender/Return-Path/DKIM domains, urgent payment-update and deletion threat, cloud-hosted CTA, and contaminated MIME body support a high-confidence phishing classification. The message does not prove that any account or data was accessed.

No malware delivery, credential capture, payment capture, account compromise, or data access is proven by the supplied `.eml` file alone.

## Recommended response

1. Report the message using Gmail's **Report phishing** or **Report spam** option; do not use the message's unsubscribe link.
2. Do not open any link, image, attachment, or QR code in the message.
3. If a link was clicked, review browser history, downloads, DNS/proxy telemetry, and endpoint alerts around the message date. A click alone does not prove compromise.
4. If login details were entered, change the affected password by navigating directly to the official service, revoke active sessions, review MFA methods, and check for suspicious account changes.
5. If card or bank details were submitted, contact the payment provider using a known official number or website and monitor for unauthorized activity.
6. Preserve the original `.eml` privately for any further investigation; use only the sanitized copy in the public portfolio.

## Limitations

No URL was opened; no DNS/reputation, browser, endpoint, payment, or account telemetry was checked. Lower Received entries mentioning Substack/Twitter are not treated as authoritative because they appear below the Google-added ingress line and were not corroborated.

No ATT&CK technique is asserted as confirmed at this stage. A phishing-link technique can be mapped as a hypothesis only after the linked content or subsequent activity establishes the malicious action.
