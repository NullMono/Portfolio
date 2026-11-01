# PHISH-2026-002 — iCloud / Cloud storage renewal and deletion lure

**Classification:** High-confidence phishing / fraudulent subscription-renewal lure  
**Triage severity:** Medium triage priority; potentially high if payment or account information was submitted  
**Analyst confidence:** High  
**Interaction status:** Not assessed for this email. The recipient previously confirmed no interaction with PHISH-2026-001 only.  
**Evidence handling:** The original user-supplied message is retained outside this public project. This folder contains a sanitized, defanged copy only.

## Executive summary

The account-blocking/data-deletion pressure, payment-update CTA, unrelated sender identity, cloud-hosted HTML destination, and highly contaminated message body support a high-confidence phishing/fraudulent renewal classification. The message alone does not prove the linked page collected credentials or payment data.

## Message details

| Field | Observed value |
|---|---|
| Date | 2026-10-31 06:06:04 UTC |
| Subject | We've blocked your account; photos and videos will be deleted on 10-31-2026; renew for free |
| From | `[redacted recipient identity] <ciyabjq@kogiacvk.aacf.profitlabs.me>` |
| From domain | `kogiacvk[.]aacf[.]profitlabs[.]me` |
| Return-Path domain | `aacf[.]profitlabs[.]me` |
| Google-observed source IP | `104[.]247[.]173[.]252` |
| Peer hostname in Google-added ingress header | `www[.]smartads[.]clarin[.]com` |
| Original file size | 102,512 bytes |
| Original SHA-256 | `32f4f3ea9c74120f73343e5ce592ef034a627bd4ba01b268569b0a10d8eb6ba3` |
| Sanitized evidence SHA-256 | `b059d39be790573a5c09c1d33f76be686f285ae7016366aa212de930e31a7efb` |

## Authentication results

| Check | Result in supplied headers | Analyst interpretation |
|---|---|---|
| SPF | PASS |
| DKIM | PASS |
| DMARC | Not present in supplied Authentication-Results |

Authentication checks apply to the domains used by the sender. A PASS does not prove the message represents a claimed brand, that a link is safe, or that the content is legitimate. A missing DMARC result is recorded as missing, not as a failure.

## Content and header findings

1. The visible sender domain is unrelated to Apple/iCloud branding. The From display-name field contains the recipient identity string (redacted in this public package), rather than an identifiable service identity.
2. The Return-Path uses the parent domain aacf.profitlabs.me while the From/DKIM identity uses kogiacvk.aacf.profitlabs.me. SPF and DKIM pass for infrastructure-controlled domains, but no DMARC result is present in the supplied Authentication-Results.
3. The Google-added ingress line records source IP 104.247.173.252 and peer name www.smartads.clarin.com, while the SMTP name is aacf.profitlabs.me. This name mismatch is an observable, not proof of malicious ownership.
4. The CTA links to an HTML object hosted under storage.googleapis.com. Google Cloud Storage is a legitimate hosting service; the specific object was not fetched and its safety is unknown.
5. The HTML body is unusually large (about 97.7 KB) and contains extensive unrelated newsletter/forum fragments in multiple languages. This is consistent with content stuffing or poor bulk-mail template contamination.
6. The MIME structure is multipart/digest with one HTML part using the nonstandard Content-Transfer-Encoding value "amazonses". No file attachment part was present in the parsed message.
7. A List-Unsubscribe URL is present on the sender domain. It was not opened; do not click it because that may confirm the address is active.

## URL and domain observations

| Host | Role in message | Interpretation |
|---|---|---|
| `storage[.]googleapis[.]com` | Click-through object host; object path uniqueswse/erkermcsdasda.html | Shared cloud-storage host; hosting untrusted content does not establish Google involvement |
| `aacf[.]profitlabs[.]me` | List-Unsubscribe host | Unverified; do not use the unsubscribe link |

Additional observed hostnames:
- `www[.]smartads[.]clarin[.]com` — Peer hostname shown in Google-added Received header; ownership/reputation not checked.

URLs were not opened, redirects were not followed, and tracking query/fragment values have been removed from the public evidence. `storage.googleapis.com` is a legitimate Google Cloud Storage hostname; its presence does not imply Google authored or endorsed the hosted HTML. The object path is unverified.

## Indicators of compromise / observables

| Type | Defanged indicator | Context | Confidence | Status | Notes |
|---|---|---|---|---|---|
| domain | `kogiacvk[.]aacf[.]profitlabs[.]me` | From and DKIM domain | High | observed | Unverified sender domain; authentication pass does not prove brand legitimacy |
| domain | `aacf[.]profitlabs[.]me` | Return-Path and List-Unsubscribe domain | High | observed | Unverified; unsubscribe URL not opened |
| ipv4 | `104[.]247[.]173[.]252` | Google-observed SMTP source IP | High | observed | Reputation not checked |
| domain | `www[.]smartads[.]clarin[.]com` | Peer hostname reported in Google-added Received header | Medium | observed | Hostname/IP relationship is recorded as supplied; reputation not checked |
| domain | `storage[.]googleapis[.]com` | HTML click-through host | High | observed | Legitimate shared hosting domain; exact object not fetched; do not block the entire service based on this sample |

The IOC list contains observed indicators, not confirmed malicious infrastructure. Reputation and ownership were not checked.

## Verdict

**High-confidence phishing / fraudulent subscription-renewal lure — confidence: High.** The account-blocking/data-deletion pressure, payment-update CTA, unrelated sender identity, cloud-hosted HTML destination, and highly contaminated message body support a high-confidence phishing/fraudulent renewal classification. The message alone does not prove the linked page collected credentials or payment data.

No malware delivery, credential capture, payment capture, account compromise, or data access is proven by the supplied `.eml` file alone.

## Recommended response

1. Report the message using Gmail's **Report phishing** or **Report spam** option; do not use the message's unsubscribe link.
2. Do not open any link, image, attachment, or QR code in the message.
3. If a link was clicked, review browser history, downloads, DNS/proxy telemetry, and endpoint alerts around the message date. A click alone does not prove compromise.
4. If login details were entered, change the affected password by navigating directly to the official service, revoke active sessions, review MFA methods, and check for suspicious account changes.
5. If card or bank details were submitted, contact the payment provider using a known official number or website and monitor for unauthorized activity.
6. Preserve the original `.eml` privately for any further investigation; use only the sanitized copy in the public portfolio.

## Limitations

No URLs were opened; no DNS/reputation lookups, browser telemetry, payment activity, endpoint logs, or account sign-in data were provided. SPF/DKIM pass only for the sender-controlled domains and no DMARC result appears in the supplied headers.

No ATT&CK technique is asserted as confirmed at this stage. A phishing-link technique can be mapped as a hypothesis only after the linked content or subsequent activity establishes the malicious action.
