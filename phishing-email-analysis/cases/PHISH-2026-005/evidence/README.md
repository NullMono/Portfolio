# Evidence handling — PHISH-2026-005

- **Source:** User-supplied `.eml`; original filename omitted from the public project to avoid exposing recipient information.
- **Original size:** 17,412 bytes.
- **Original SHA-256:** `67cb963febdbfc5e83e996b51227375ced3a5ef4883c2d0aff240e1a2af58462` (hash calculated before sanitization; original is not included in this package).
- **Sanitized copy:** `sanitized_email.eml`.
- **Sanitized copy SHA-256:** `92bab3130b72750520727685e1ebccbe3f676c419b4e470a75db44c15034490b`.
- **Processing:** Local parsing only. Personal email identity strings were redacted; opaque account-specific forwarding data was removed; URL schemes were defanged and tracking query/fragment values removed.
- **Network access:** None. URLs were not opened, DNS was not queried, and redirects were not followed.
- **Attachments:** No file attachment was detected by the local MIME parser.

The sanitized file is a derivative for safe portfolio sharing; it is not byte-identical to the original evidence.
