# PHISH-2026-004 — Walmart $500 Thanksgiving gift-card reward lure

**Classification:** High-confidence phishing / fraudulent prize or reward lure  
**Triage severity:** Medium triage priority; potentially high if personal, payment, or login details were submitted  
**Analyst confidence:** High  
**Interaction status:** Not assessed for this email.  
**Evidence handling:** The original user-supplied message is retained outside this public project. This folder contains a sanitized, defanged copy only.

## Executive summary

The Walmart brand claim conflicts with the sender domain, the prize is unsolicited and time-pressured, and the user is sent to an unverified hosted page and shortened URL. These facts support a high-confidence prize/reward phishing classification. The precise data-collection behavior of the destination is unknown.

## Message details

| Field | Observed value |
|---|---|
| Date | 2026-10-25 21:41:11 UTC |
| Subject | [redacted recipient identity], You Have Won a $500 Walmart Thanksgiving Gift Card #3308743069 |
| From | `Walmart <thekwlb@fpwczucb.google.xelvoranavigate.com.tr>` |
| From domain | `fpwczucb[.]google[.]xelvoranavigate[.]com[.]tr` |
| Return-Path domain | `google[.]xelvoranavigate[.]com[.]tr` |
| Google-observed source IP | `185[.]227[.]136[.]149` |
| Peer hostname in Google-added ingress header | `agentevirtual[.]ticket[.]com[.]br` |
| Original file size | 34,012 bytes |
| Original SHA-256 | `088083980024cdd6f216a67083a33e47695c35f75f9d591d461c48a3fdf48aae` |
| Sanitized evidence SHA-256 | `3af3f789fe7fe0be30300984e03171f72b00afa9f0af948e812d6ea1b1a8c938` |

## Authentication results

| Check | Result in supplied headers | Analyst interpretation |
|---|---|---|
| SPF | PASS |
| DKIM | PASS |
| DMARC | Not present in supplied Authentication-Results |

Authentication checks apply to the domains used by the sender. A PASS does not prove the message represents a claimed brand, that a link is safe, or that the content is legitimate. A missing DMARC result is recorded as missing, not as a failure.

## Content and header findings

1. The From display name claims Walmart, but the address is under fpwczucb.google.xelvoranavigate.com.tr, not a Walmart-controlled-looking domain. The Return-Path uses google.xelvoranavigate.com.tr.
2. SPF and DKIM pass for the sender domains. This demonstrates authorization/signature for those domains only; it does not establish Walmart affiliation. No DMARC result appears in the supplied Authentication-Results.
3. Google records source IP 185.227.136.149 with peer hostname agentevirtual.ticket.com.br, while the SMTP host and visible sender use unrelated domains.
4. The subject and preheader use a personalized prize claim, a $500 value, and time pressure ("could be gone in minutes"). The body asks the recipient to participate in a free loyalty program.
5. The primary CTA is hosted under storage.googleapis.com; a separate TinyURL link is present with a recipient-specific email query parameter in the original. Query and fragment tracking tokens are removed from the public sanitized evidence.
6. The HTML includes a large unrelated citrus/gardening newsletter fragment after the reward message, consistent with content stuffing or a contaminated bulk-mail template.
7. The message is a single HTML part with no attachment. The list-unsubscribe link points to the sending domain and was not opened.

## URL and domain observations

| Host | Role in message | Interpretation |
|---|---|---|
| `storage[.]googleapis[.]com` | Main click-through object host; object path bobalomaniaz/bazonamolapa.html | Shared cloud-storage host; object not fetched |
| `tinyurl[.]com` | Additional shortened URL; path UNSBprokl | Shortened destination unknown; not expanded |
| `google[.]xelvoranavigate[.]com[.]tr` | List-Unsubscribe host | Unverified domain; not opened |

Additional observed hostnames:
- `agentevirtual[.]ticket[.]com[.]br` — Peer hostname shown in Google-added Received header.

URLs were not opened, redirects were not followed, and tracking query/fragment values have been removed from the public evidence. `storage.googleapis.com` is a legitimate Google Cloud Storage hostname; its presence does not imply Google authored or endorsed the hosted HTML. The object path is unverified.

## Indicators of compromise / observables

| Type | Defanged indicator | Context | Confidence | Status | Notes |
|---|---|---|---|---|---|
| domain | `fpwczucb[.]google[.]xelvoranavigate[.]com[.]tr` | Visible From, Sender, and DKIM domain | High | observed | Unverified domain; authentication does not establish Walmart affiliation |
| domain | `google[.]xelvoranavigate[.]com[.]tr` | Return-Path and List-Unsubscribe domain | High | observed | Unverified sender/list domain |
| ipv4 | `185[.]227[.]136[.]149` | Google-observed SMTP source IP | High | observed | Reputation not checked |
| domain | `agentevirtual[.]ticket[.]com[.]br` | Peer hostname in Google-added Received header | Medium | observed | Reputation not checked |
| domain | `storage[.]googleapis[.]com` | Main HTML click-through host | High | observed | Legitimate shared hosting domain; exact object not fetched |
| domain | `tinyurl[.]com` | Shortened URL host embedded in HTML | High | observed | Destination not expanded; exact token redacted |

The IOC list contains observed indicators, not confirmed malicious infrastructure. Reputation and ownership were not checked.

## Verdict

**High-confidence phishing / fraudulent prize or reward lure — confidence: High.** The Walmart brand claim conflicts with the sender domain, the prize is unsolicited and time-pressured, and the user is sent to an unverified hosted page and shortened URL. These facts support a high-confidence prize/reward phishing classification. The precise data-collection behavior of the destination is unknown.

No malware delivery, credential capture, payment capture, account compromise, or data access is proven by the supplied `.eml` file alone.

## Recommended response

1. Report the message using Gmail's **Report phishing** or **Report spam** option; do not use the message's unsubscribe link.
2. Do not open any link, image, attachment, or QR code in the message.
3. If a link was clicked, review browser history, downloads, DNS/proxy telemetry, and endpoint alerts around the message date. A click alone does not prove compromise.
4. If login details were entered, change the affected password by navigating directly to the official service, revoke active sessions, review MFA methods, and check for suspicious account changes.
5. If card or bank details were submitted, contact the payment provider using a known official number or website and monitor for unauthorized activity.
6. Preserve the original `.eml` privately for any further investigation; use only the sanitized copy in the public portfolio.

## Limitations

The storage object was not fetched and the TinyURL was not expanded. No independent domain/IP reputation, DNS, WHOIS, browser, endpoint, or account telemetry was checked. Authentication passed only for the non-Walmart sender domains.

No ATT&CK technique is asserted as confirmed at this stage. A phishing-link technique can be mapped as a hypothesis only after the linked content or subsequent activity establishes the malicious action.
