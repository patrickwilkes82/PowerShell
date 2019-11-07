##Load Required Assemblies##
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")  
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
[void] [System.Windows.Forms.Application]::EnableVisualStyles()

##Create Form##
$Form = New-Object System.Windows.Forms.Form
$Form.Size = New-Object System.Drawing.Size(500,400)
$Form.MaximizeBox = $false
$Form.MinimizeBox = $false
$Form.StartPosition = 'CenterScreen'
$Form.FormBorderStyle = 'Fixed3D'
$Form.Text = 'Test AD App'

#Labels
$userNameLabel = New-Object System.Windows.Forms.Label
$firstNameLabel = New-Object System.Windows.Forms.Label
$lastNameLabel = New-Object System.Windows.Forms.Label
$companyLabel = New-Object System.Windows.Forms.Label
$titleLabel = New-Object System.Windows.Forms.Label
$officeLabel = New-Object System.Windows.Forms.Label
$emailLabel = New-Object System.Windows.Forms.Label
$phoneLabel = New-Object System.Windows.Forms.Label
$extensionLabel = New-Object System.Windows.Forms.Label
$ouLabel = New-Object System.Windows.Forms.Label

#Text & Combo Boxes
$userNameBox = New-Object System.Windows.Forms.TextBox
$firstNameBox = New-Object System.Windows.Forms.TextBox
$lastNameBox = New-Object System.Windows.Forms.TextBox
$titleBox = New-Object System.Windows.Forms.TextBox
$phoneBox = New-Object System.Windows.Forms.TextBox
$extensionBox = New-Object System.Windows.Forms.TextBox
$emailBox = New-Object System.Windows.Forms.ComboBox
$officeBox = New-Object System.Windows.Forms.ComboBox
$companyBox = New-Object System.Windows.Forms.ComboBox
$ouBox = New-Object System.Windows.Forms.ComboBox

#Buttons
$okButton = New-Object System.Windows.Forms.Button

#Text of Controls
$userNameLabel.text = 'Username:'
$firstNameLabel.text = 'First Name:'
$lastNameLabel.text = 'Last Name:'
$companyLabel.text = 'Company:'
$titleLabel.text = 'Title:'
$officeLabel.text = 'Office:'
$emailLabel.text = 'Email:'
$phoneLabel.text = 'Phone:'
$extensionLabel.Text = 'Extension:'
$ouLabel.text = 'OU:'
$okButton.text = 'OK'

#Size of Controls
$userNameBox.Size = New-Object System.Drawing.Size(225,20)
$firstNameBox.Size = New-Object System.Drawing.Size(225,20)
$lastNameBox.Size = New-Object System.Drawing.Size(225,20)
$companyBox.Size = New-Object System.Drawing.Size(225,20)
$titleBox.Size = New-Object System.Drawing.Size(225,20)
$officeBox.Size = New-Object System.Drawing.Size(225,20)
$emailBox.Size = New-Object System.Drawing.Size(225,20)
$phoneBox.Size = New-Object System.Drawing.Size(225,20)
$extensionBox.Size = New-Object System.Drawing.Size(225,20)
$ouBox.Size = New-Object System.Drawing.Size(225,20)
$okButton.Size = New-Object System.Drawing.Size(100,50)

#Locations of Controls
$userNameLabel.Location = New-Object System.Drawing.Point(25,25)
$firstNameLabel.Location = New-Object System.Drawing.Point(25,50)
$lastNameLabel.Location = New-Object System.Drawing.Point(25,75)
$companyLabel.Location = New-Object System.Drawing.Point(25,100)
$titleLabel.Location = New-Object System.Drawing.Point(25,125)
$officeLabel.Location = New-Object System.Drawing.Point(25,150)
$emailLabel.Location = New-Object System.Drawing.Point(25,175)
$phoneLabel.Location = New-Object System.Drawing.Point(25,200)
$extensionLabel.Location = New-Object System.Drawing.Point(25,225)
$ouLabel.Location = New-Object System.Drawing.Point(25,250)
$userNameBox.Location = New-Object System.Drawing.Point(150,25)
$firstNameBox.Location = New-Object System.Drawing.Point(150,50)
$lastNameBox.Location = New-Object System.Drawing.Point(150,75)
$companyBox.Location = New-Object System.Drawing.Point(150,100)
$titleBox.Location = New-Object System.Drawing.Point(150,125)
$officeBox.Location = New-Object System.Drawing.Point(150,150)
$emailBox.Location = New-Object System.Drawing.Point(150,175)
$phoneBox.Location = New-Object System.Drawing.Point(150,200)
$extensionBox.Location = New-Object System.Drawing.Point(150,225)
$ouBox.Location = New-Object System.Drawing.Point(150,250)
$okButton.Location = New-Object System.Drawing.Point(150,300)

#Add Items to Dropdown Combo Boxes
$companyNames = @('G100 Companies','G100 Network','Six Sigma Academy & Co','The Miles Group','High Lantern Group','Mentore')
foreach($company in $companyNames)
{
    [void]$companyBox.Items.Add($company)
}
$officeSpaces = @('New York','Phoenix','Wayne','Washington DC','Pasadena','Asheville','Los Angeles','Oakland','London (UK)','Remote','Remote (EU)')
foreach($office in $officeSpaces)
{
    [void]$officeBox.Items.Add($office)
}
$emailDomains = @('g100companies.com','g100.com','ssaandco.com','miles-group.com','highlanterngroup.com','mentore.co.uk')
foreach($email in $emailDomains)
{
    [void]$emailBox.Items.Add($email)
}
$companyOUs = ('OU=G100 Companies,DC=sigma,DC=com',
               'OU=G100 Employees,DC=sigma,DC=com',
               'OU=Six Sigma Employees,DC=sigma,DC=com',
               'OU=The Miles Group,DC=sigma,DC=com',
               'OU=Highlantern Group Employees,DC=sigma,DC=com',
               'OU=Mentore,DC=sigma,DC=com')
foreach($ou in $companyOUs)
{
    [void]$ouBox.Items.Add($ou)
}

#Add Controls to Form
$form.Controls.Add($userNameLabel)
$form.Controls.Add($firstNameLabel)
$form.Controls.Add($lastNameLabel)
$form.Controls.Add($companyLabel)
$form.Controls.Add($titleLabel)
$form.Controls.Add($officeLabel)
$form.Controls.Add($emailLabel)
$form.Controls.Add($phoneLabel)
$form.Controls.Add($extensionLabel)
$form.Controls.Add($ouLabel)
$Form.Controls.Add($userNameBox)
$Form.Controls.Add($firstNameBox)
$Form.Controls.Add($lastNameBox)
$Form.Controls.Add($companyBox)
$Form.Controls.Add($titleBox)
$Form.Controls.Add($officeBox)
$Form.Controls.Add($emailBox)
$Form.Controls.Add($phoneBox)
$Form.Controls.Add($extensionBox)
$Form.Controls.Add($ouBox)
$form.Controls.Add($okButton)


function createNewUser
{
    #Import AD Module
    Import-Module ActiveDirectory
    Add-Type -AssemblyName system.web

    #Set New User Information
    $Username = $userNameBox.text
    $Password = [system.web.security.membership]::GeneratePassword(12,2)
    $FirstName = $firstNameBox.text
    $LastName = $lastNameBox.text
    $Email = $userNameBox.text,'@',$emailBox.text -join ""
    $Title = $titleBox.text
    $Phone = $phoneBox.text
    $Department = $extensionBox.text
    $Office = $officeBox.text
    $Company = $companyBox.text
    $OU = $ouBox.text


    if (Get-ADUser -F {SamAccountName -eq $UserName})
{
    Write-Warning "User Account $Username already exists in Active Directory."
}
    else
{
   Try { 
    New-ADUser `
    -SamAccountName $Username `
    -Name "$FirstName $LastName" `
    -GivenName $FirstName `
    -Surname $LastName `
    -DisplayName "$FirstName $LastName" `
    -UserPrincipalName $Email `
    -EmailAddress $Email.ToString() `
    -OfficePhone $Phone `
    -Title $Title `
    -Description $Title `
    -Office $Office `
    -Department $Department `
    -Company $Company `
    -PasswordNeverExpires $true `
    -Enabled $true `
    -Path $OU `
    -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force)
    Write-Host 'User',$FirstName,$LastName,'created successfully with password', $Password -ForegroundColor Green

    #SMTP Settings
    $PSEmailServer = 'smtp-mail.outlook.com'
    $emailfrom = 'Patrick Wilkes <patrick_wilkes@outlook.com>'
    $emailto = 'Patrick Wilkes <pwilkes@1path.com>'
    $emailbody = 'User',' ',$FirstName,' ',$LastName,' ',$email,' ','created successfully with password ', $Password -join ''
    $emailsubject = 'New User', ' ',$username, ' ','Credentials' -join ''
    $emailuser = 'patrick_wilkes@outlook.com'
    $emailpword = ConvertTo-SecureString -String 'P@tr1ck99' -AsPlainText -Force
    $emailcredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $emailuser, $emailpword
    Send-MailMessage -from $emailfrom -to $emailto -Subject $emailsubject -Body $emailbody -smtpserver $PSEmailServer -credential $emailcredential -usessl
    }
    catch {
    Write-Host 'Shit broken' -ForegroundColor Red
    } 
}
}
$okbutton.Add_Click({createnewuser})

[void]$form.ShowDialog()