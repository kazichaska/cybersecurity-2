## 🧠 What is MITRE ATT\&CK?

MITRE ATT\&CK is a **knowledge base of adversary tactics, techniques, and procedures (TTPs)** observed in the real world. It's organized into **Tactics** (the attacker's objectives) and **Techniques** (how they achieve those objectives).

---

## 📘 Using MITRE ATT\&CK in an IR Playbook

Below is a **mapping between the traditional IR phases** and how MITRE ATT\&CK fits into each:

### 🛡️ 1. **Preparation**

* Use MITRE to identify **common techniques attackers use** against your environment.
* Map your existing controls (EDR, SIEM, firewalls) to **detect/alert on MITRE techniques**.
* Run **purple team exercises** using ATT\&CK as the adversary model.

### 🔍 2. **Detection & Analysis**

* Investigate suspicious activity using **MITRE technique IDs** (e.g., T1059 for Command Line Execution).
* Example:

  ```spl
  process_name = "powershell.exe" | map to T1059
  ```
* Use **ATT\&CK Navigator** to visualize affected tactics/techniques in real time.

### 🧯 3. **Containment, Eradication, Recovery**

* Contain threats based on the **techniques in use**:

  * If attacker uses lateral movement (`T1021`), isolate machines or reset credentials.
* Develop targeted response actions per technique.

### 📝 4. **Post-Incident Activity**

* Document **techniques used in the breach**.
* Update threat models, SIEM rules, and detection content to better detect the **same ATT\&CK techniques** next time.
* Add findings to ATT\&CK Navigator to **track detection/coverage gaps**.

---

## 🛠️ Example: MITRE-based IR Playbook Snippet

| IR Phase        | MITRE Tactic      | Technique (ID)                | Response Action                                      |
| --------------- | ----------------- | ----------------------------- | ---------------------------------------------------- |
| Detection       | Execution         | T1059 (Command Line)          | Log parent-child process, alert if parent is unusual |
| Detection       | Credential Access | T1003 (LSASS Dumping)         | Alert on `procdump.exe` or memory access to lsass    |
| Containment     | Lateral Movement  | T1021.001 (RDP)               | Block RDP at firewall, reset user credentials        |
| Recovery        | Persistence       | T1547.001 (Registry Run Keys) | Remove autorun keys from registry                    |
| Lessons Learned | Multiple          | Aggregate Techniques          | Update playbooks and detection rules                 |

---

## 🧰 Tools to Use

* **ATT\&CK Navigator** ([https://attack.mitre.org/navigator/](https://attack.mitre.org/navigator/))
* **Sigma Rules** to detect MITRE techniques
* **Threat intelligence feeds** that map to ATT\&CK (e.g., MISP)
* **Atomic Red Team** for testing defenses



# MITRE ATT\&CK-Based Incident Response Playbook

## Overview

This playbook integrates the MITRE ATT\&CK framework into each phase of the incident response lifecycle. It is designed to help security analysts detect, analyze, contain, eradicate, and recover from cyber threats using standardized attacker behavior patterns.

---

## Preparation

| Task            | Description                                                                  |
| --------------- | ---------------------------------------------------------------------------- |
| Threat Modeling | Map your environment's high-risk assets to relevant ATT\&CK techniques.      |
| Tool Mapping    | Align your EDR, SIEM, firewall, etc., to detect specific ATT\&CK techniques. |
| Team Training   | Conduct purple team exercises using known adversary TTPs from ATT\&CK.       |

---

## Detection & Analysis

| Tactic               | Technique ID | Technique Name                        | Response Action                                                                       |
| -------------------- | ------------ | ------------------------------------- | ------------------------------------------------------------------------------------- |
| Execution            | T1059        | Command and Scripting Interpreter     | Alert on unusual parent-child process relationships (e.g., Word spawning PowerShell). |
| Credential Access    | T1003        | OS Credential Dumping                 | Monitor LSASS memory access; flag use of tools like mimikatz or procdump.             |
| Persistence          | T1547.001    | Registry Run Keys/Startup Folder      | Monitor registry changes to autorun keys.                                             |
| Privilege Escalation | T1068        | Exploitation for Privilege Escalation | Alert on access to vulnerable local exploits.                                         |
| Lateral Movement     | T1021.001    | Remote Desktop Protocol (RDP)         | Monitor internal RDP connections; trigger on unusual RDP source IPs.                  |

---

## Containment

| Indicator                      | Technique ID | Action                                                   |
| ------------------------------ | ------------ | -------------------------------------------------------- |
| Lateral Movement via RDP       | T1021.001    | Disable RDP on target machine; isolate affected systems. |
| Persistence via Scheduled Task | T1053.005    | Delete malicious task; disable user account.             |

---

## Eradication

| Indicator               | Technique ID | Action                                                               |
| ----------------------- | ------------ | -------------------------------------------------------------------- |
| Credential Dumping      | T1003        | Reset passwords for affected accounts; rotate secrets.               |
| Malicious Registry Keys | T1547.001    | Remove registry entries; verify integrity with known-good baselines. |

---

## Recovery

| Task               | Description                                |
| ------------------ | ------------------------------------------ |
| System Rebuild     | Restore from clean backups or gold images. |
| Patch Management   | Apply updates to prevent re-exploitation.  |
| Credential Hygiene | Enforce password resets and implement MFA. |

---

## Lessons Learned / Post-Incident

| Task                  | Description                                               |
| --------------------- | --------------------------------------------------------- |
| MITRE Mapping         | Document all techniques used by adversaries.              |
| Gap Analysis          | Use ATT\&CK Navigator to identify detection blind spots.  |
| Detection Engineering | Develop Sigma rules or SIEM alerts for missed techniques. |

---

## Supporting Tools

* ATT\&CK Navigator: [https://attack.mitre.org/navigator/](https://attack.mitre.org/navigator/)
* Atomic Red Team: [https://github.com/redcanaryco/atomic-red-team](https://github.com/redcanaryco/atomic-red-team)
* Sigma Rules: [https://github.com/SigmaHQ/sigma](https://github.com/SigmaHQ/sigma)
* Threat Intelligence Platforms: MISP, OpenCTI

---

## Contact and Roles

| Role             | Responsibility                                            |
| ---------------- | --------------------------------------------------------- |
| SOC Analyst      | Monitor and triage alerts mapped to ATT\&CK techniques.   |
| Incident Handler | Lead the containment and eradication efforts.             |
| Threat Hunter    | Identify stealthy attacks by simulating MITRE techniques. |
| IR Lead          | Oversee playbook execution and reporting.                 |

---

> This playbook should be updated regularly based on new threat intelligence and evolving attacker behaviors.
