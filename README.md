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

## License
MIT License

Copyright (c) 2020 Mike Hartman

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
