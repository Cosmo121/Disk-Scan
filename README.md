
# Disk-Scan

  

Scans remote servers/workstations for disk space statistics and exports to a CSV file. Will scan all attached drives.

  
  

## Usage

  

Always grab the latest version from: [github.com/Cosmo121/Disk-Scan](https://github.com/Cosmo121/Disk-Scan)

  

Will create the following file path:

```PowerShell

C:\temp\diskspacereports\DiskReport

```

Prompts you for a list of servers you want to scan, from a .txt file. The text file should be in the format of one hostname per line:

```PowerShell

serverName1
serverName2
serverName3

```

  

By default, the CSV will be saved in C:\temp\diskspacereports as well. This can also be changed, with

  

```PowerShell

Export-Csv  -path "C:\temp\diskspacereports\DiskReport\DiskReport_$logDate.csv"

```

and

```PowerShell

Invoke-Item C:\Temp\DiskSpaceReports\DiskReport\DiskReport_$logDate.csv

```

## Functions
After running the script, File Explorer will prompt for your server txt file
![file_expolorer_prompt](/docs/file_expolorer_prompt.png "Prompt for txt file")

Optional: You get prompted to enter your credentials to access the servers/workstations you specified. This is helpful if you run the script with different credentials than you would use to authenticate to the servers/workstations you are scanning. To enable this feature, you must uncomment the $RunAccount line.
![cred_prompt](/docs/cred_prompt.png "Prompt for credentials")

And finally, the CSV will open with the results
![csv_export](/docs/csv_export.png "CSV results")
  

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