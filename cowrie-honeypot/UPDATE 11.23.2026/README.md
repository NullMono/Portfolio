# Cowrie Honeypot Activity Update — SSH Authentication Analysis

> **Project:** Cowrie Honeypot SOC Lab  
> **Data source:** Splunk-exported CSV aggregations from the Cowrie honeypot  
> **Analysis type:** SSH authentication failure analysis  
> **Reporting period:** Not specified in the supplied exports

## Executive summary

The supplied Splunk exports show sustained SSH authentication-failure activity against the Cowrie honeypot. The source-IP aggregation contains **71,654 failed attempts from 193 unique source IP addresses**. The username aggregation contains **71,640 attempts across 1,657 distinct usernames**.

The activity is highly concentrated:

- The `root` username accounts for **67,636 attempts**, or approximately **94.4%** of the username-attempt total.
- The five most active source IPs account for **59,092 attempts**, approximately **82.5%** of the source-IP total.
- **164 of 193 source IPs** appear with exactly one failed attempt in the supplied IP aggregation.

These findings are consistent with automated SSH password-guessing or credential-scanning activity. The CSV exports alone do not establish the identity, location, motivation, or ownership of the source systems.

## Key findings

### 1. Failed authentication attempts by source IP

| Metric | Result |
|---|---:|
| Failed attempts in source-IP export | 71,654 |
| Unique source IPs | 193 |
| Top source IP | `43.108.14.37` |
| Attempts from top source IP | 26,421 |
| Share from top source IP | 36.9% |
| Attempts from top 3 source IPs | 51,760 (72.2%) |
| Attempts from top 5 source IPs | 59,092 (82.5%) |
| Source IPs with one failed attempt | 164 (85.0%) |

**Top 10 source IPs in the supplied export**

| Source IP | Failed attempts |
|---|---:|
| `43.108.14.37` | 26,421 |
| `43.100.80.224` | 13,711 |
| `182.92.236.135` | 11,628 |
| `167.86.117.69` | 3,666 |
| `20.74.143.67` | 3,666 |
| `43.99.247.37` | 3,666 |
| `15.235.169.211` | 3,253 |
| `195.178.110.218` | 1,702 |
| `47.251.120.60` | 1,207 |
| `120.27.141.87` | 839 |

The distribution is strongly skewed: a small number of sources account for most failed attempts, while many sources appear only once in this export. This may reflect a combination of high-volume automated activity and lower-volume scanning. The data does not by itself show whether the sources are independent actors or part of shared infrastructure.

### 2. Targeted usernames

| Metric | Result |
|---|---:|
| Attempts in username export | 71,640 |
| Distinct usernames | 1,657 |
| Attempts targeting `root` | 67,636 |
| `root` share of username attempts | 94.4% |

**Top 10 targeted usernames in the supplied export**

| Username | Attempts |
|---|---:|
| `root` | 67,636 |
| `ubuntu` | 336 |
| `admin` | 204 |
| `user` | 120 |
| `test` | 46 |
| `postgres` | 38 |
| `bitrix` | 33 |
| `guest` | 30 |
| `oracle` | 27 |
| `deploy` | 20 |

The strong preference for `root`, followed by common administrative and default-style account names, is consistent with automated SSH credential guessing against commonly anticipated usernames.

## Data-quality note

The two supplied CSV exports do **not** have identical totals:

- Source-IP export: **71,654** failed attempts.
- Username export: **71,640** attempts.
- Difference: **14 attempts**.

These are separate aggregations. The supplied files do not explain the 14-event difference, so this report preserves both totals rather than assuming one is correct. Before presenting them as a single reconciled event count, rerun both searches over the same index, time range, and event filters and compare their underlying event populations.


## Detection and investigation value

This dataset demonstrates several practical SOC analysis tasks:

1. **Aggregation and prioritization:** ranking source IPs by failed-attempt volume to identify high-volume sources for further review.
2. **Account-target analysis:** identifying the usernames most frequently targeted by authentication attempts.
3. **Behavioral interpretation:** distinguishing concentrated high-volume activity from the long tail of low-volume source addresses.
4. **Evidence handling:** documenting data limitations and avoiding attribution or compromise claims unsupported by the available telemetry.

A high count from one IP is an investigation lead, not proof that a particular person or organization conducted the activity. IP addresses can represent cloud hosts, proxies, compromised systems, shared gateways, or other infrastructure.

## Suggested Splunk searches

Use the same time picker and filters for both searches when validating the totals.

**Failed attempts by source IP**

```spl
index=cowrie
| search eventid="cowrie.login.failed"
| stats count AS failed_attempts BY src_ip
| sort - failed_attempts
```

**Targeted usernames**

```spl
index=cowrie
| search eventid="cowrie.login.failed"
| stats count AS attempts BY username
| sort - attempts
```

**Top source IPs**

```spl
index=cowrie
| search eventid="cowrie.login.failed"
| stats count AS failed_attempts BY src_ip
| sort - failed_attempts
| head 10
```

**Top targeted usernames**

```spl
index=cowrie
| search eventid="cowrie.login.failed"
| stats count AS attempts BY username
| sort - attempts
| head 10
```

> Validate the event ID and field names against the actual Cowrie events in this Splunk deployment before relying on these searches. If the exported searches used additional filters, preserve those filters when reproducing the report.

## Recommended next steps

- Correlate the highest-volume source IPs with session timestamps and Cowrie session IDs, where available.
- Preserve the original CSV exports alongside the report so the analysis can be reproduced.

---

*This report summarizes the two CSV files supplied for this update. Counts and rankings are calculated from those exports; interpretation is limited to what those fields support.*
