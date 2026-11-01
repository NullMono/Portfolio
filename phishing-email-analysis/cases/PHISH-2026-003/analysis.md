# PHISH-2026-003 — Cloud storage payment failure and imminent deletion lure

**Classification:** High-confidence phishing / fraudulent cloud-storage payment lure  
**Triage severity:** Medium triage priority; potentially high if payment or account information was submitted  
**Analyst confidence:** High  
**Interaction status:** Not assessed for this email.  
**Evidence handling:** The original user-supplied message is retained outside this public project. This folder contains a sanitized, defanged copy only.

## Executive summary

The unrelated identity domains, DKIM failure, data-deletion/payment pressure, cloud-hosted CTA, separate list-management domain, and unrelated body content support a high-confidence phishing classification. Credential or payment theft is a plausible objective, but successful collection is not demonstrated.

## Message details

| Field | Observed value |
|---|---|
| Date | 2026-10-31 01:48:59 UTC (header Date: 02:48:59 +0100) |
| Subject | We've Blocked Your Account! Your photos and videos will be deleted on 31-10-2026 |
| From | `[redacted recipient identity] <alert-164-232081@ewhzt.vkb>` |
| From domain | `ewhzt[.]vkb` |
| Return-Path domain | `one[.]ass0031[.]behinddesert[.]biz[.]ua` |
| Google-observed source IP | `212[.]83[.]161[.]56` |
| Peer hostname in Google-added ingress header | `dfusion[.]toms[.]com` |
| Original file size | 18,275 bytes |
| Original SHA-256 | `bc714488a716454b25d368323559eb1d18ff0bd1e73acdf6e7f55e913c23953d` |
| Sanitized evidence SHA-256 | `098db95e6281f2e29a3335e2dbf36a96ca43251afada6e6fea3e8f9087352f34` |

## Authentication results

| Check | Result in supplied headers | Analyst interpretation |
|---|---|---|
| SPF | PASS |
| DKIM | FAIL |
| DMARC | Not present in supplied Authentication-Results |

Authentication checks apply to the domains used by the sender. A PASS does not prove the message represents a claimed brand, that a link is safe, or that the content is legitimate. A missing DMARC result is recorded as missing, not as a failure.

## Content and header findings

1. The displayed sender name is the recipient identity string (redacted in this public package), while the actual From address uses the unrelated domain ewhzt.vkb. The Sender and Return-Path use a different domain under behinddesert.biz.ua.
2. SPF passes for the envelope sender domain, but DKIM fails. No DMARC result appears in the supplied Authentication-Results. A passing SPF result does not make the claimed Cloud service legitimate.
3. Google records source IP 212.83.161.56 and peer name dfusion.toms.com, while the SMTP host is one.ass0031.behinddesert.biz.ua.
4. The body claims a generic "Cloud Services" identity and asks for a payment update under a deletion threat. The body also contains the literal statement that it was sent from a trusted sender; this is ordinary message text, not an authenticated Gmail security verdict.
5. The main CTA is hosted as an HTML object on storage.googleapis.com. A separate list-management domain, odrsjml.com, appears in List-Unsubscribe/List-Archive. Neither destination was visited.
6. The MIME Content-Transfer-Encoding value "xogjiwRFiQ" is nonstandard. The multipart/digest contains an empty HTML part, a substantive HTML part, and another HTML part with unrelated story/travel/health newsletter text.
7. No file attachment was detected. The extraneous text and inconsistent headers suggest template contamination, spam content stuffing, or a malformed bulk-mail campaign.

## URL and domain observations

| Host | Role in message | Interpretation |
|---|---|---|
| `storage[.]googleapis[.]com` | Click-through object host; object path strow/strw-v1-cl1.html | Shared cloud-storage host; object not fetched |
| `odrsjml[.]com` | List-Unsubscribe and List-Archive host | Unverified tracking/list domain; neither URL was opened |

Additional observed hostnames:
- `one[.]ass0031[.]behinddesert[.]biz[.]ua` — SMTP host / Return-Path domain.
- `ewhzt[.]vkb` — Visible From domain.
- `dfusion[.]toms[.]com` — Peer hostname shown in Google-added Received header.

URLs were not opened, redirects were not followed, and tracking query/fragment values have been removed from the public evidence. `storage.googleapis.com` is a legitimate Google Cloud Storage hostname; its presence does not imply Google authored or endorsed the hosted HTML. The object path is unverified.

## Indicators of compromise / observables

| Type | Defanged indicator | Context | Confidence | Status | Notes |
|---|---|---|---|---|---|
| domain | `ewhzt[.]vkb` | Visible From domain | High | observed | Unverified sender domain; DKIM failed |
| domain | `one[.]ass0031[.]behinddesert[.]biz[.]ua` | Sender and Return-Path domain | High | observed | Unverified infrastructure domain |
| ipv4 | `212[.]83[.]161[.]56` | Google-observed SMTP source IP | High | observed | Reputation not checked |
| domain | `dfusion[.]toms[.]com` | Peer hostname in Google-added Received header | Medium | observed | Reputation not checked |
| domain | `storage[.]googleapis[.]com` | HTML click-through host | High | observed | Legitimate shared hosting domain; exact object not fetched |
| domain | `odrsjml[.]com` | List-Unsubscribe and List-Archive host | High | observed | Unverified; not opened |

The IOC list contains observed indicators, not confirmed malicious infrastructure. Reputation and ownership were not checked.

## Verdict

**High-confidence phishing / fraudulent cloud-storage payment lure — confidence: High.** The unrelated identity domains, DKIM failure, data-deletion/payment pressure, cloud-hosted CTA, separate list-management domain, and unrelated body content support a high-confidence phishing classification. Credential or payment theft is a plausible objective, but successful collection is not demonstrated.

No malware delivery, credential capture, payment capture, account compromise, or data access is proven by the supplied `.eml` file alone.

## Recommended response

1. Report the message using Gmail's **Report phishing** or **Report spam** option; do not use the message's unsubscribe link.
2. Do not open any link, image, attachment, or QR code in the message.
3. If a link was clicked, review browser history, downloads, DNS/proxy telemetry, and endpoint alerts around the message date. A click alone does not prove compromise.
4. If login details were entered, change the affected password by navigating directly to the official service, revoke active sessions, review MFA methods, and check for suspicious account changes.
5. If card or bank details were submitted, contact the payment provider using a known official number or website and monitor for unauthorized activity.
6. Preserve the original `.eml` privately for any further investigation; use only the sanitized copy in the public portfolio.

## Limitations

Lower Received entries mentioning Substack/Twitter occur below the Google-added ingress information and were not independently validated; they must not be treated as trusted route evidence. No URL, DNS, reputation, browser, endpoint, or identity telemetry was checked.

No ATT&CK technique is asserted as confirmed at this stage. A phishing-link technique can be mapped as a hypothesis only after the linked content or subsequent activity establishes the malicious action.
