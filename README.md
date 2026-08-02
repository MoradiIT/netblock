# Netblock

A lightweight script that scans a folder (recursively) and blocks outbound
internet access for every executable it finds. Useful for isolating every executable file of an untrusted or offline-only
applications.

 <br>
 
## What it does

- Recursively scans a folder you specify
- Finds all real executables (`.exe`, `.scr`, `.com`)
- Creates a Windows Firewall outbound **block** rule for each one, covering
  Domain, Private, and Public network profiles
- Also detects script files (`.bat`, `.cmd`, `.ps1`, `.vbs`, `.js`) in the
  folder and lists them separately, since firewall rules cannot target
  scripts directly

<br>
 
## Important limitation

Windows Firewall can only bind a rule to an actual process (a PE binary).
It **cannot** block a specific `.bat`, `.ps1`, `.vbs`, or `.js` file, because
these run through an interpreter (`cmd.exe`, `powershell.exe`, `wscript.exe`).
A firewall rule targeting the interpreter would block *all* scripts run by
that interpreter, not just one.

This tool blocks true executables only. Script files found in the scanned
folder are reported but not blocked.

<br>
 
## Requirements

- Windows 10/11
- Administrator privileges (required to create firewall rules)

<br>

## Usage

1. Clone or download this repo.
2. Open the script (`netblock.bat`) and edit the folder path at the top: `set "FolderPath=C:\`, then save the changes.
3. Assign a name for rules in line 38. replace `NAME` with a desired name.
4. Save the changes you made.
5. Run it **as Administrator**

<br>

## Removing the rules

Rules created by this script are named same as you defined in line 38. You can remove them from `wf.msc` in `Outbound` section. Delete or Disable them based on your need.

<br>

## Disclaimer

This tool modifies Windows Firewall rules on your system. Review the folder
path carefully before running — it will create a rule for every executable
found, recursively, with no confirmation prompt per file. Use at your own
risk. Not affiliated with Microsoft.
