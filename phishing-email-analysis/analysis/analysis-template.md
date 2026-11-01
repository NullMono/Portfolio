# Phishing Email Analysis Worksheet

## 1. Case details
- Case ID:
- Analyst:
- Date/time received (include timezone):
- Reported by / source:
- Original message preserved at:
- SHA-256 of original `.eml` (if collected):

## 2. Initial triage
- Subject:
- Display name:
- From address:
- Reply-To:
- Return-Path:
- Requested user action:
- Attachments present (name/type/size):
- Initial assessment:

## 3. Header and authentication review
| Evidence | Observed value | Assessment |
|---|---|---|
| SPF | | |
| DKIM | | |
| DMARC | | |
| Received chain | | |
| Message-ID domain | | |
| Sender / Return-Path alignment | | |
| Sender / Reply-To alignment | | |

## 4. URL and attachment review
| Artifact | Defanged value | Observations |
|---|---|---|
| URL 1 | | |
| URL 2 | | |
| Attachment | | |

Do not visit suspicious URLs or execute attachments. Record the original value only in a controlled evidence location; use defanged values in reports and GitHub.

## 5. Social-engineering indicators
- Urgency / deadline:
- Authority or brand impersonation:
- Unexpected file, payment, password, or MFA request:
- Grammar / formatting / context anomalies:

## 6. Indicators of compromise (IOCs)
List only observable indicators. Label indicators as observed, unverified, or independently confirmed as appropriate.

## 7. Verdict
- Classification: Benign / Spam / Phishing / Malware / Credential harvesting / Other
- Severity:
- Confidence:
- Evidence supporting verdict:
- Alternative explanations considered:

## 8. Recommended response
- Email containment:
- Tenant-wide / mailbox scoping:
- User guidance:
- Credential and session response (if interaction occurred):
- Monitoring and follow-up:

## 9. MITRE ATT&CK mapping (optional)
- Technique ID and name:
- Evidence supporting the mapping:

## 10. Analyst notes and limitations
Separate facts directly observed in the email from assumptions or conclusions. Record any telemetry that was unavailable.
