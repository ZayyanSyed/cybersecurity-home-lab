# Incident Report: Brute-Force Attack Against Domain Account j.smith

## Summary

On 16 November 2026, a simulated brute-force attack was launched from an 
attacker-controlled host against a domain user account (`j.smith`) on the 
corp.local domain controller (DC01), using RDP as the target service. The 
attack was detected via centralized logging in Splunk, and a correlation 
search was built and saved as a scheduled alert to detect this pattern in 
future.

## Environment

| Role | Hostname | IP | OS |
|---|---|---|---|
| Domain Controller | DC01 | 192.168.111.10 | Windows Server 2022 |
| Attacker | Kali | 192.168.111.129 | Kali Linux |
| SIEM | SPLUNK | 192.168.111.12 | Ubuntu Server 22.04, Splunk Enterprise |

All hosts sit on an isolated host-only network (VMnet1, 192.168.111.0/24).

## Attack Timeline

| Time (UTC+11) | Event |
|---|---|
| 12:13:53 | Failed logon attempt 1 (password: `Password1!`) |
| 12:13:54 | Failed logon attempt 2 (password: `Welcome123`) |
| 12:13:55 | Failed logon attempt 3 (password: `Summer2024!`) |
| 12:13:56 | Failed logon attempt 4 (password: `Qwerty123!`) |
| 12:13:57 | Hydra confirms valid credentials (password: `Welcome1!`) |
| 12:14:08 | Interactive RDP session established (Logon Type 10) |

**Tool used:** THC-Hydra v9.5, targeting the RDP service with a 5-entry 
password wordlist against the known username `j.smith`.
