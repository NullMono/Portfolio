# Evidence Handling Log — Five Supplied Email Samples

The five original `.eml` files were supplied for local review. Original messages remain outside the public package because they contain recipient identifiers, forwarding metadata, message IDs, or unique tracking values. Only reviewed sanitized copies are included where available.

| Case | Original source SHA-256 (private evidence) | Public evidence derivative |
|---|---|---|
| PHISH-2026-001 | `b5d4ca1a3cac79940ef13f01d7997f98c446386628acaafa814d05bbad649ee1` (25,730 bytes) | No public `.eml` copy; only analysis and IOC notes are included because the original contains recipient/tracking data. |
| PHISH-2026-002 | `32f4f3ea9c74120f73343e5ce592ef034a627bd4ba01b268569b0a10d8eb6ba3` (102,512 bytes) | `cases/PHISH-2026-002/evidence/sanitized_email.eml` (102,123 bytes; SHA-256 `b059d39be790573a5c09c1d33f76be686f285ae7016366aa212de930e31a7efb`) |
| PHISH-2026-003 | `bc714488a716454b25d368323559eb1d18ff0bd1e73acdf6e7f55e913c23953d` (18,275 bytes) | `cases/PHISH-2026-003/evidence/sanitized_email.eml` (17,400 bytes; SHA-256 `098db95e6281f2e29a3335e2dbf36a96ca43251afada6e6fea3e8f9087352f34`) |
| PHISH-2026-004 | `088083980024cdd6f216a67083a33e47695c35f75f9d591d461c48a3fdf48aae` (34,012 bytes) | `cases/PHISH-2026-004/evidence/sanitized_email.eml` (33,469 bytes; SHA-256 `3af3f789fe7fe0be30300984e03171f72b00afa9f0af948e812d6ea1b1a8c938`) |
| PHISH-2026-005 | `67cb963febdbfc5e83e996b51227375ced3a5ef4883c2d0aff240e1a2af58462` (17,412 bytes) | `cases/PHISH-2026-005/evidence/sanitized_email.eml` (16,525 bytes; SHA-256 `92bab3130b72750520727685e1ebccbe3f676c419b4e470a75db44c15034490b`) |

## Handling rules

- Preserve original messages in a private, access-controlled location. Do not overwrite originals with sanitized derivatives.
- Do not click links, reply to senders, enable remote content, or execute attachments.
- Defang URLs and remove recipient-specific tracking values before sharing evidence publicly.
- Do not upload personal email content to public scanning services without authorization.
- Distinguish observed message indicators from confirmed malicious infrastructure.

## Review scope and limitations

Analysis was performed on the supplied message files and their local header/MIME/content data. No URL was fetched, no DNS or reputation query was made, and no external hosting attribution was performed.
