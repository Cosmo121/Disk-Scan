# Disk-Scan

Does what it do. Scans remote servers/workstations for disk space statistics and exports to a CSV file. Will scan all attached drives


## Usage

Always grab the latest version from: [github.com/Cosmo121/Disk-Scan](https://github.com/Cosmo121/Disk-Scan)

Set the parameter $TxtFilePath to where your text file is that contains the devices you want to scan, or use the default path below
```PowerShell
$TxtFilePath = 'C:\temp\diskspacereports\servers.txt
```
By default, the CSV will be saved in C:\temp\diskspacereports as well. This can also be changed, with

```PowerShell
Export-Csv -path "C:\temp\diskspacereports\DiskReport\DiskReport_$logDate.csv" 
```
and
```PowerShell
Invoke-Item C:\Temp\DiskSpaceReports\DiskReport\DiskReport_$logDate.csv
```

## Contributing
Pull requests can be made via GitHub: [Disk-Scan](https://github.com/Cosmo121/Disk-Scan)
