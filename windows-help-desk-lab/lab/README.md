# Lab configuration

| Component | Role |
|---|---|
| DC01 · Windows Server 2025 | Domain controller and DNS at `192.168.77.10`. Hosts the Dispatch training share. |
| W11-01 · Windows 11 | Domain-joined workstation at `192.168.77.20`, with DC01 as its preferred DNS server. |
| ATL-Desk | VirtualBox internal network for the two guests. The domain name is `altdesk.test`. |
| GLPI and MySQL | Ticket queue on the Docker host. Compose publishes the web interface on `127.0.0.1:8080`. |

## Files used in the lab

- [Initialize-DeskLab.ps1](Initialize-DeskLab.ps1) is the supplied setup helper for DC01. It expects an existing `altdesk.test` domain and creates the practice users, OUs, reader group and Dispatch share. It prompts for passwords at runtime.
- [Test-DeskClient.ps1](Test-DeskClient.ps1) is the supplied read-only baseline check for W11-01. After the domain join it checks the DC address, directory DNS record, SMB connectivity and secure channel.
- [compose.yaml](compose.yaml) defines the two local GLPI services. To start a fresh instance, copy [.env.example](.env.example) to `.env` beside the Compose file, fill in two separate passwords, and run `docker compose up -d` from this directory on the Docker host. The account records in GLPI are separate from the Windows accounts.

The case evidence is in the [ticket queue](../README.md).
