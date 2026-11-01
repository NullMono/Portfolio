# Case PHISH-2026-001 — “You Could Be Paying More Than Necessary”

## Executive summary

**Disposition:** Suspicious unsolicited marketing / spam. **Phishing or malware delivery is not proven by the supplied `.eml`.**

The message presents itself as a vehicle-protection/price-saving offer. Its HTML document title is `CarShield`, but the sender is `mail[.]montgomeryvideos[.]com` and the clickable images and remote images are hosted at `bocaratonawnings[.]com`. The message contains unusual sender and recipient formatting, malformed mailing-list metadata, off-topic hidden content, and a `Received` chain with contradictory historical timestamps and unrelated mail systems.

Google's recorded SPF, DKIM, and DMARC checks all pass for `mail[.]montgomeryvideos[.]com`. This is evidence that the sending domain was authorized and aligned for this message; it does **not** establish that the offer is legitimate, that the sender represents CarShield, or that the linked site is safe.

No reliable binary attachment was recoverable from the supplied `.eml`: the parts labelled PDF/XML were empty or contained plain text rather than a valid PDF. The message should still be treated as untrusted and reported as spam. No conclusion about device compromise can be made from the email file alone.

## Case details

| Field | Value |
|---|---|
| Case ID | PHISH-2026-001 |
| Date in message | 2026-10-31 21:57:26 UTC |
| Google receipt time | 2026-10-31 21:59:08 UTC |
| Subject | “You Could Be Paying More Than Necessary” with malformed template/reference tokens |
| From domain | `mail[.]montgomeryvideos[.]com` |
| Return-Path domain | `mail[.]montgomeryvideos[.]com` |
| Reply-To | No Reply-To header observed |
| Message-ID domain | `montgomeryvideos[.]com` |
| Source IP observed by Google | `162[.]35[.]176[.]135` |
| Original `.eml` size | 25,730 bytes |
| Original `.eml` SHA-256 | `b5d4ca1a3cac79940ef13f01d7997f98c446386628acaafa814d05bbad649ee1` |
| Evidence handling | Original retained separately; not included in the public portfolio package because it contains personal and tracking data |

## Evidence and analysis

### 1. Sender identity and message construction

- The `From` display name is a string of date/campaign-like tokens rather than a recognizable sender identity.
- The sender mailbox local part is also unusually constructed; the sending domain is `mail[.]montgomeryvideos[.]com`.
- The `To` and `Bcc` fields are malformed. The `Bcc` header contains a large block of HTML educational content instead of a normal recipient list.
- `List-Id` contains a URL-like value and unresolved template tokens. The subject also contains unresolved `[first_name]`/reference-style tokens.
- Conflicting priority fields are present (`X-Priority` appears more than once, while `Importance` and `Priority` also indicate high/urgent priority).

**Assessment:** These are strong signs of a malformed bulk-mail template, header contamination, or deliberate evasion. They are not, by themselves, proof of a malware payload.

### 2. Authentication results

| Check | Observed result | Interpretation |
|---|---|---|
| SPF | PASS | Google reports `162.35.176.135` is permitted to send for the envelope sender domain. |
| DKIM | PASS | Google reports a valid signature for `mail.montgomeryvideos.com`. |
| DMARC | PASS | The visible From domain aligns with the authenticated domain. The recorded policy is `p=REJECT`. |

**Important:** Authentication validates the relationship between the message and the sending domain. It does not validate the business offer, brand relationship, URL destination, or sender's intent. A spammer can send authenticated mail from a domain they control or have compromised.

### 3. Received-chain review

Google's top-level receipt headers show the message arrived from `mail[.]montgomeryvideos[.]com` at `162[.]35[.]176[.]135` over TLS on 2026-10-31, shortly after the message Date value.

Below those Google-added entries are older `Received` lines referencing unrelated services and recipients, with dates ranging from January 2024 through December 2025. Their order is not chronologically coherent. These entries do not form a trustworthy route for the October 2026 message and may be forged, copied, or injected header material.

**Assessment:** Use the top Google-added receipt information as the reliable observed ingress point. Do not attribute the lower historical entries to the actual route without corroboration from provider logs.

### 4. HTML, branding, and links

- The HTML document title is `CarShield`, but the From domain is not a CarShield-branded domain and the email does not establish an authorized relationship.
- The visible message content is image-based. The image and click-through URLs use `http://bocaratonawnings.com/...` rather than a sender- or brand-aligned host.
- Three click-through links point to tracking-style paths on `bocaratonawnings[.]com`; remote images use the same host.
- The links use cleartext HTTP, so the message does not provide transport encryption for those link requests.
- The HTML includes a tiny transparent/zero-line-height `noscript` region with unrelated aerospace/orbital-trajectory text. This is unrelated to the purported offer and appears to be hidden content stuffing or template contamination.
- An unsubscribe URL points to `montgomeryvideos[.]com`. Do not click it; interacting with an unsolicited message can confirm that the address is active.

**Assessment:** The mismatch between the purported brand/title, authenticated sender domain, and image/link host is the strongest content-level warning. The final redirect destination and site reputation have not been established because the links were not opened.

### 5. Attachment and MIME review

The supplied message has a malformed MIME structure:

- One `application/pdf` part contains plain text beginning with an aerospace report table, not a PDF file signature (`%PDF-`).
- Another text part contains what looks like an embedded `Content-Type: application/pdf` block and more copied report text.
- The parsed `application/pdf` attachment part and `application/xml` attachment part have zero-byte payloads.
- No usable PDF or XML attachment was recovered for static file analysis.

**Assessment:** Do not claim that this sample delivered a working malicious attachment. The MIME structure is malformed and suspicious, but the available file does not contain an analyzable binary payload.

## Indicators and observables

See [`iocs.csv`](iocs.csv). Domains and URLs are defanged. The click-through path tokens and recipient-specific tracking values are intentionally omitted from this public case report.

| Observable | Value | Status |
|---|---|---|
| Sending domain | `mail[.]montgomeryvideos[.]com` | Observed; reputation unverified |
| Return-Path / unsubscribe domain | `montgomeryvideos[.]com` | Observed; reputation unverified |
| Source IP | `162[.]35[.]176[.]135` | Observed by Google; reputation unverified |
| Click / image host | `bocaratonawnings[.]com` | Observed; off-brand and unverified |

No public reputation conclusion is asserted for these indicators. An absence of a public detection would not prove that an indicator is safe.

## Verdict

| Dimension | Assessment |
|---|---|
| Classification | Suspicious unsolicited marketing / spam |
| Phishing confirmed? | No — malicious credential collection or access intent is not established by this file |
| Malware confirmed? | No — no valid binary attachment was recovered |
| Confidence | High that the message is malformed and unsolicited/suspicious; low that it is a proven credential-phishing or malware email |
| Triage severity | Medium until interaction and destination are clarified |
| Compromise evidence | None in the `.eml`; endpoint, browser, and account telemetry were not supplied |

A link-based phishing ATT&CK mapping should remain **unassigned** until the destination or subsequent activity establishes malicious intent. MITRE ATT&CK describes T1566.002 as Spearphishing Link when an adversary uses a malicious link to gain access; the presence of an unverified link alone is insufficient to assert that technique. Reference: <https://attack.mitre.org/techniques/T1566/002/>.

## Recommended response

1. In Gmail, use **Report spam** (or **Report phishing** if the user-facing classification fits) rather than clicking the unsubscribe link.
2. Do not open the message's links or any purported attachment. Block/report the message and delete it after preserving the original evidence if needed.
3. Check whether any of the three `bocaratonawnings[.]com` links were clicked. If this is a managed environment, review browser history, DNS/proxy logs, and endpoint telemetry around 2026-10-31 21:57–22:05 UTC.
4. If a link was opened, determine the final redirect and whether a file was downloaded. A click alone does not establish compromise.
5. If credentials or payment details were entered, change the affected password from the official site/app, revoke active sessions, enable MFA, and contact the payment provider if card/bank details were submitted.
6. If no link was clicked and no data was entered, the email file alone provides no reason to assume the device or account is compromised.

## Analyst limitations / next evidence needed

- No live URL requests or redirects were followed.
- No DNS, WHOIS/RDAP, VirusTotal, URLhaus, or AbuseIPDB verdict is asserted for the domains/IP.
- No browser history, download history, endpoint logs, Gmail click telemetry, or account sign-in logs were provided.
- The raw email contains personal and tracking data; it is intentionally excluded from the public GitHub case package.

**Next question for the recipient:** Did you click any of the images/links, download a file, or enter personal, payment, or login information after receiving this email?
