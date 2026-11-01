# Evidence handling — PHISH-2026-003

- **Source:** User-supplied `.eml`; original filename omitted from the public project to avoid exposing recipient information.
- **Original size:** 18,275 bytes.
- **Original SHA-256:** `bc714488a716454b25d368323559eb1d18ff0bd1e73acdf6e7f55e913c23953d` (hash calculated before sanitization; original is not included in this package).
- **Sanitized copy:** `sanitized_email.eml`.
- **Sanitized copy SHA-256:** `098db95e6281f2e29a3335e2dbf36a96ca43251afada6e6fea3e8f9087352f34`.
- **Processing:** Local parsing only. Personal email identity strings were redacted; opaque account-specific forwarding data was removed; URL schemes were defanged and tracking query/fragment values removed.
- **Network access:** None. URLs were not opened, DNS was not queried, and redirects were not followed.
- **Attachments:** No file attachment was detected by the local MIME parser.

The sanitized file is a derivative for safe portfolio sharing; it is not byte-identical to the original evidence.
