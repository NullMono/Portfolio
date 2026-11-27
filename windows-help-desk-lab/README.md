# Windows Help Desk Lab

**Ethan Miranda** · Windows 11, Windows Server 2025, Active Directory, DNS, GLPI, VirtualBox

I worked a five-ticket GLPI queue for a fictional dealership. Four tickets involved Windows account or workstation support. The fifth was a Microsoft 365 MFA tabletop exercise that ended with a Tier 2 handoff.

## Featured case · A workstation lost the Dispatch share

I checked the workstation’s network configuration with `ipconfig /all`. W11-01 had its expected IPv4 address, `192.168.77.20`, but its DNS server was set to `192.168.77.99`. The domain controller providing DNS was at `192.168.77.10`. I corrected the DNS setting, and my ticket records that the user regained access. [Read the DNS case and see the original capture](tickets/HD-04-dns.md).

## Ticket queue

| Case | GLPI ID | Work performed | Recorded outcome |
|---|---:|---|---|
| [HD-01 · Windows sign-in](tickets/HD-01-password-reset.md) | 1 | Reset a forgotten AD password and requested a change at next sign-in | Reset marked complete |
| [HD-02 · New employee](tickets/HD-02-onboarding.md) | 2 | Provisioned Noah Williams’s AD account | Signed-in domain identity captured |
| [HD-03 · Dispatch permissions](tickets/HD-03-dispatch-access.md) | 4 | Compared access for two users and identified the missing group membership | Folder access recorded as restored |
| [HD-04 · Workstation DNS](tickets/HD-04-dns.md) | 3 | Diagnosed an incorrect DNS server and restored the workstation setting | File server access recorded as restored |
| [HD-05 · Microsoft 365 MFA](tickets/HD-05-mfa-handoff.md) | 5 | Scoped a simulated second-factor issue and escalated to Tier 2 | Pending at handoff |

## Lab environment

DC01 hosted Active Directory, DNS and the Dispatch file share for `altdesk.test`. W11-01 was the domain-joined client. Both VMs used a VirtualBox internal network named `ATL-Desk`. I used GLPI on the Windows host to document the work. The ticket pages link to six screenshots from the lab.

[Lab configuration and PowerShell helpers](lab/README.md)
