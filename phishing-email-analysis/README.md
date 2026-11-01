# User-Supplied Phishing Email Investigations

A collection of five investigations based exclusively on email samples supplied for review. The repository demonstrates a repeatable SOC email-triage workflow: preserve evidence, inspect headers and authentication results, inspect URLs without visiting them, document indicators, assess potential impact, and recommend response actions.

> **Evidence safety:** The public repository contains sanitized derivatives and analyst notes only. Original messages remain private. URLs are defanged; do not visit them. No embedded links, remote images, or attachments were opened. No DNS, WHOIS/RDAP, threat-reputation, redirect, browser, endpoint, identity, or payment-provider checks were performed unless explicitly stated in an individual case.

## Case overview

| Case | Supplied email | Assessment |
|---|---|---|
| PHISH-2026-001 | “You Could Be Paying More Than Necessary” (CarShield-branded presentation) | Suspicious unsolicited marketing / spam; phishing not established |
| PHISH-2026-002 | Account blocked / photos and videos scheduled for deletion | High-confidence phishing / cloud-storage renewal lure |
| PHISH-2026-003 | Account blocked / photos and videos scheduled for deletion | High-confidence phishing / cloud-storage payment lure |
| PHISH-2026-004 | $500 Walmart Thanksgiving gift-card offer | High-confidence phishing / fraudulent prize lure |
| PHISH-2026-005 | Gmail Support failure notice / Cloud+ payment lure | High-confidence phishing / account and payment-data lure |

The consolidated report is [`reports/incident-report.md`](reports/incident-report.md). Individual case analyses are in `cases/`, and cross-case observations are in [`reports/case-index-and-correlation.md`](reports/case-index-and-correlation.md).

## Repository structure

```text
phishing-email-analysis/
├── README.md
├── analysis/
│   └── analysis-template.md
├── cases/
│   ├── PHISH-2026-001/
│   ├── PHISH-2026-002/
│   ├── PHISH-2026-003/
│   ├── PHISH-2026-004/
│   └── PHISH-2026-005/
├── evidence/
│   └── evidence-log.md
├── iocs/
│   └── iocs.csv
├── reports/
    ├── README.md
    └── Phishing Investigation Incident Report.pdf

```


## Investigation standards and limitations

- Treat SPF, DKIM, and DMARC as evidence about sender-domain authorization/alignment—not proof that a claimed brand is legitimate.
- Distinguish observed indicators from indicators confirmed malicious by independent intelligence. The domains, IP addresses, and hosts in these cases are recorded as observed; their reputation and ownership were not independently verified.
- Shared hosting domains such as `storage[.]googleapis[.]com` are not inherently malicious. The specific hosted objects in the supplied messages were not fetched.
- A displayed sender name or phrase such as “trusted sender” is not an authentication result.
- The first supplied email was confirmed not clicked by the recipient. Interaction status for the other four samples has not been established in this repository.
- An email file alone cannot establish credential capture, payment capture, malware execution, account compromise, or data access. Corroborating mail, browser, endpoint, identity, and payment telemetry would be required.

## Privacy and evidence handling

The recipient's personal email identity and unique tracking values are not included in this public repository. The raw source messages are not packaged. Keep originals in a private, access-controlled location and share only reviewed, sanitized copies. See [`evidence/evidence-log.md`](evidence/evidence-log.md) for source and derivative hashes.
