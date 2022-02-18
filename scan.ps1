# Setup requirements
New-Item -Path "c:\temp\diskspacereports" -Name "DiskReport" -ItemType "directory" -ErrorAction SilentlyContinue

Function Get-ServerFile ($defaultDirectory)
{
    [system.reflection.assembly]::LoadWithPartialName("System.windows.forms") | Out-Null

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.InitialDirectory = $defaultDirectory
    $openFileDialog.Filter = "TXT (*.txt) | *.txt"
    $openFileDialog.ShowDialog() | Out-Null
    $openFileDialog.FileName
}

Write-Host (
    "
     __________________________
    |                          |
    |                          |
    | Starting Disk Space Scan |
    |                          |
    |__________________________|
    
    "
)

$inputFile = Get-ServerFile "C:\temp\diskspacereports"

<# old code, before openfiledialog implementation

Start-Sleep -Seconds 4
if ( -not (Test-Path 'C:\temp\diskspacereports\Servers.txt' -PathType Leaf))
{
    # the servers.txt file wasn't found, write error and exit
    "No server text file found. Please create a Servers.txt at c:\temp\diskspacereports\ or edit script to look at desired path."
    exit
}
    else {
        # servers.txt exists, try to grab it
        try {
            $File = Get-Content -Path C:\temp\diskspacereports\servers.txt
            Write-Host (
                "
     __________________________
    |                          |
    |                          |
    |  Retrieving contents of  |
    |     servers.txt          |
    |                          |
    |__________________________|
                "
            )
        }
        catch {
            "Error occured grabbing Servers from text file :("
        }
    }

function Get-Servers {
    $Servers = Get-Content C:\temp\diskspacereports\servers.txt
    $ServerCount = $Servers.count
    Write-Host "Found " $ServerCount "server(s) in text file"
    Start-Sleep -Seconds 4  
}
Get-Servers

#>

try {
    $File = Get-Content $inputFile
    Write-Host (
        "
         __________________________
        |                          |
        |                          |
        |  Retrieving contents of  |
        |     servers.txt          |
        |                          |
        |__________________________|
        "
    )
}
catch {
    "Error occured while trying to read from text file"
}

$File = Get-Content $inputFile

$servers = Get-Content $inputFile
$serverCount = $servers.count

Write-Host "Found " $ServerCount "server(s) in text file"

Start-Sleep -Seconds 2

Write-Host (
    "
     __________________________
    |                          |
    |                          |
    |    Getting Credentials   |
    |                          |
    |__________________________|
    
    "
)

$RunAccount = Get-Credential -Message "Enter admin account username and password"
$LogDate = get-date -f yyyy_MM_dd_hhmm
$DiskReport = ForEach ($Servernames in ($File))


{Get-WmiObject win32_logicaldisk -Credential $RunAccount `
-ComputerName $Servernames -Filter "Drivetype=3" `
-ErrorAction SilentlyContinue }

#create reports
$DiskReport | 
Select-Object @{Label = "Server Name";Expression = {$_.SystemName}},
@{Label = "Drive Letter";Expression = {$_.DeviceID}},
@{Label = "Total Capacity (GB)";Expression = {"{0:N1}" -f( $_.Size / 1gb)}},
@{Label = "Free Space (GB)";Expression = {"{0:N1}" -f( $_.Freespace / 1gb ) }},
@{Label = 'Free Space (%)'; Expression = {"{0:P0}" -f ($_.freespace/$_.size)}} |

#Export report to CSV file (Disk Report)
Export-Csv -path "C:\temp\diskspacereports\DiskReport\DiskReport_$logDate.csv" -NoTypeInformation

Write-Host (
    "
     __________________________
    |                          |
    |                          |
    |   Opening CSV file and   |
    |    exiting script        |
    |                          |
    |__________________________|
    
    "
)

#Open csv file
Invoke-Item C:\Temp\DiskSpaceReports\DiskReport\DiskReport_$logDate.csv
