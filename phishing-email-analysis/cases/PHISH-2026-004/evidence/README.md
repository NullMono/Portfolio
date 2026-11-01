# Evidence handling — PHISH-2026-004

- **Source:** User-supplied `.eml`; original filename omitted from the public project to avoid exposing recipient information.
- **Original size:** 34,012 bytes.
- **Original SHA-256:** `088083980024cdd6f216a67083a33e47695c35f75f9d591d461c48a3fdf48aae` (hash calculated before sanitization; original is not included in this package).
- **Sanitized copy:** `sanitized_email.eml`.
- **Sanitized copy SHA-256:** `3af3f789fe7fe0be30300984e03171f72b00afa9f0af948e812d6ea1b1a8c938`.
- **Processing:** Local parsing only. Personal email identity strings were redacted; opaque account-specific forwarding data was removed; URL schemes were defanged and tracking query/fragment values removed.
- **Network access:** None. URLs were not opened, DNS was not queried, and redirects were not followed.
- **Attachments:** No file attachment was detected by the local MIME parser.

The sanitized file is a derivative for safe portfolio sharing; it is not byte-identical to the original evidence.
