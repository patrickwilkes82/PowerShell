##Get Elevated Privileges (Run As Admin)##
param([switch]$Elevated)

function Test-Admin 
{
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)
{
    if ($elevated) 
    {
        # tried to elevate, did not work, aborting
    } 
    else 
    {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
exit
}

Write-Host 'Running with Elevated Privileges' -ForegroundColor Green -BackgroundColor Black

##Load Required Assemblies##
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")  
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
[void] [System.Windows.Forms.Application]::EnableVisualStyles() 

##Create Form##
$Form = New-Object system.Windows.Forms.Form

##Form Custom Properties##
$Form.Size = New-Object System.Drawing.Size(400,200)
$Form.MaximizeBox = $false
$Form.MinimizeBox = $false
$Form.StartPosition = 'CenterScreen'
$Form.FormBorderStyle = 'Fixed3D'
$Form.Text = 'Test App'

##ComboBox with Company Names##
$companyNames = @('G100 Companies','G100 Network','Six Sigma Academy & Co','The Miles Group','High Lantern Group','Mentore')
$testComboBox = New-Object System.Windows.Forms.ComboBox
$testComboBox.Location = New-Object System.Drawing.Point(100,25)
$testComboBox.Size = New-Object System.Drawing.Size(150,25)
foreach($company in $companyNames)
{
    [void]$testComboBox.Items.Add($company)
}
$Form.Controls.Add($testComboBox)

##Test Button & Function of Click##
$TestButton = New-Object System.Windows.Forms.Button
$TestButton.Location = New-Object System.Drawing.Point(150,50)
$TestButton.Size = New-Object System.Drawing.Size(100,50)
$TestButton.Text = 'Close'
$Form.Controls.Add($TestButton)

function services
{
    #Get-Process | select ProcessName, Handles, Location | Out-GridView
    Get-BitlockerVolume | Out-GridView
}

$TestButton.Add_Click({services})

##TextBox##
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Size(100,10)
$textBox.Size = New-Object System.Drawing.Size(100,20)
$textBox.Enabled = $true
$form.Controls.add($textBox)


##Open Form##
Write-Host 'Opening Windows Form' -ForegroundColor Yellow
[void]$Form.ShowDialog()
exit
''