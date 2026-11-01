# Evidence handling — PHISH-2026-002

- **Source:** User-supplied `.eml`; original filename omitted from the public project to avoid exposing recipient information.
- **Original size:** 102,512 bytes.
- **Original SHA-256:** `32f4f3ea9c74120f73343e5ce592ef034a627bd4ba01b268569b0a10d8eb6ba3` (hash calculated before sanitization; original is not included in this package).
- **Sanitized copy:** `sanitized_email.eml`.
- **Sanitized copy SHA-256:** `b059d39be790573a5c09c1d33f76be686f285ae7016366aa212de930e31a7efb`.
- **Processing:** Local parsing only. Personal email identity strings were redacted; opaque account-specific forwarding data was removed; URL schemes were defanged and tracking query/fragment values removed.
- **Network access:** None. URLs were not opened, DNS was not queried, and redirects were not followed.
- **Attachments:** No file attachment was detected by the local MIME parser.

The sanitized file is a derivative for safe portfolio sharing; it is not byte-identical to the original evidence. 