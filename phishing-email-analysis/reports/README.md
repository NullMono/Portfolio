# Case Index and Cross-Case Observations

This repository contains five analyses of email samples supplied for review. The public package contains sanitized, defanged derivatives and analyst documentation; original messages and recipient-specific tracking data are excluded.

## Case index

| Case | Theme | Classification | Authentication snapshot |
|---|---|---|---|
| PHISH-2026-001 | CarShield-branded vehicle-protection marketing sample | Suspicious unsolicited marketing / spam; phishing not proven | SPF/DKIM/DMARC pass for sender domain |
| PHISH-2026-002 | Cloud-storage account block and photo/video deletion threat | High-confidence phishing / renewal lure | SPF pass; DKIM pass; DMARC not reported |
| PHISH-2026-003 | Cloud-storage payment failure and data-deletion threat | High-confidence phishing / payment lure | SPF pass; DKIM fail; DMARC not reported |
| PHISH-2026-004 | $500 Walmart Thanksgiving gift-card reward | High-confidence phishing / prize lure | SPF pass; DKIM pass; DMARC not reported |
| PHISH-2026-005 | Gmail Support impersonation and Cloud+ payment failure | High-confidence phishing / account and payment-data lure | SPF pass; DKIM pass; DMARC not reported |

## Cross-case observations

1. **Authentication is not brand verification.** SPF/DKIM passes apply to the domains used by the senders. They do not establish a relationship with the brand shown in the email. PHISH-2026-003 reports DKIM failure.
2. **Cloud-hosted URLs recur.** Several samples use `storage[.]googleapis[.]com` as a click-through host. This is a legitimate shared hosting service; the specific objects were not fetched and their content/ownership is unverified.
3. **Urgency and loss framing recur.** Messages threaten loss of photos, videos, backups, or account access, or promise a time-limited reward.
4. **Bulk-mail and template artifacts recur.** Multiple messages contain unrelated newsletter or filler text, unusual list-management metadata, malformed headers, or nonstandard content-transfer encodings.
5. **Possible shared template family:** PHISH-2026-003 and PHISH-2026-005 share Cloud subscription language, Mailgun-style metadata, similar list-management headers, hosted CTA objects, and unrelated content fragments. This does not establish common ownership or operator attribution.
6. **No attribution is made.** Source IPs, peer hostnames, domains, and object hosts are recorded as observed. No independent DNS, WHOIS/RDAP, passive DNS, or reputation checks were performed.

## Interaction and impact status

- The recipient confirmed no interaction with PHISH-2026-001.
- Interaction status for PHISH-2026-002 through PHISH-2026-005 has not been provided.
- No URLs were visited, redirects followed, or attachments executed during this review.
- No malware delivery, credential submission, payment submission, account compromise, or data access is confirmed by the email files alone.

See [`incident-report.md`](incident-report.md) for the consolidated incident report and recommended follow-up actions.
