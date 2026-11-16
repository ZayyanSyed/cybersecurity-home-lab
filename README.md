# Cybersecurity Home Lab: AD Monitoring & Brute-Force Detection

A self-built lab simulating a small company network, instrumented for security 
monitoring, used to demonstrate log analysis and incident detection skills.

## Goal

Build an isolated Active Directory network, monitor it with Sysmon and Splunk, 
simulate a brute-force attack, detect it, and document the investigation.

## Architecture

| Machine | Role | OS |
|---|---|---|
| DC01 | Domain Controller (corp.local) | Windows Server 2022 |
| WIN11-CLIENT | Employee workstation | Windows 11 Pro |
| SPLUNK | SIEM / log server | Ubuntu Server 22.04 |
| Kali | Attacker machine | Kali Linux |

All machines run on an isolated host-only network (VMnet1, 192.168.111.0/24), 
with no route to the internet from the lab subnet itself.

## What's built so far

- Active Directory domain `corp.local` with OU structure (IT, Finance, Sales) 
  and 36 user accounts
- Sysmon deployed on DC01 and WIN11-CLIENT using the SwiftOnSecurity baseline config
- Splunk Enterprise deployed as a dedicated SIEM, receiving forwarded logs 
  from both Windows hosts
- Verified log ingestion: Security Event Log and Sysmon Operational log, 
  both hosts, both indexes

## Next steps

- [ ] Simulate a brute-force attack against a domain account using Hydra
- [ ] Detect the attack via a Splunk search
- [ ] Build a correlation search / alert
- [ ] Write up the incident as a short investigation report

## Notes

Lab credentials are placeholders throughout and not included in this repo.
