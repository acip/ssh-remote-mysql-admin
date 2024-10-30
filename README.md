# Remote MySQL DB Management Script

This is a simple PowerShell script for easier remote MySQL database management on Windows.

## Requirements

- PHP installed locally.
- SSH access to the remote host.

## How to Use

1. To run the script:
   ```powershell
   .\padmin.ps1 <hostname>
   ```

2. (Optional) Add the folder containing `padmin.ps1` to your system's PATH. Then you can run:
   ```powershell
   padmin <hostname>
   ```

## How It Works

1. Establishes an SSH tunnel on port 3306 to the given host.
2. Starts a PHP server on port 8000 with [AdminerEvo](https://docs.adminerevo.org/), a lightweight database management tool.

## Script Details

The script takes one parameter:

- `<hostname>`: The hostname or IP address of the remote server to connect to.

### Example

```powershell
.\padmin.ps1 my.remote.host
```

## Notes

- The SSH tunnel allows access to the MySQL server on the remote host.
- The PHP server uses `AdminerEvo` to provide an easy-to-use interface for managing the MySQL database.
