#MAIN OU's
$OUSSA = 'OU=Six Sigma Employees,DC=sigma,DC=com'
$OUG100C = 'OU=G100 Companies,DC=sigma,DC=com'
$OUG100N = 'OU=G100 Employees,DC=sigma,DC=com'
$OUTMG = 'OU=The Miles Group,DC=sigma,DC=com'
$OUHLG = 'OU=Highlantern Group Employees,DC=sigma,DC=com'
$OUMentore = 'OU=Mentore,DC=sigma,DC=com'
$OUInternational = 'OU=International Offices,DC=sigma,DC=com'

#SUB OU's
$OUSSAICs = 'OU=Contractors,OU=Six Sigma Employees,DC=sigma,DC=com'
$OUSSAGhosts = 'OU=Shadow Accounts,OU=Six Sigma Employees,DC=sigma,DC=com'
$OUSSAInterns = 'OU=Interns,OU=Six Sigma Employees,DC=sigma,DC=com'
$OUSSAServices = 'OU=Service Accounts,OU=Six Sigma Employees,DC=sigma,DC=com'

$OUG100CGhosts = 'OU=Shadow Accounts,OU=G100 Companies,DC=sigma,DC=com'
$OUG100CInterns = 'OU=Interns,OU=G100 Companies,DC=sigma,DC=com'
$OUG100CServices = 'OU=Service Accounts,OU=G100 Companies,DC=sigma,DC=com'

$OUG100NICs = 'OU=ICs,OU=G100 Employees,DC=sigma,DC=com'
$OUG100NGhosts = 'OU=Shadow Accounts,OU=G100 Employees,DC=sigma,DC=com'
$OUG100NInterns = 'OU=G100 Interns,OU=G100 Employees,DC=sigma,DC=com'
$OUG100NServices = 'OU=G100 Service Accounts,OU=G100 Employees,DC=sigma,DC=com'

$OUTMGInterns = 'OU=Interns,OU=The Miles Group,DC=sigma,DC=com'
$OUTMGServices = 'OU=Service Accounts,OU=The Miles Group,DC=sigma,DC=com'
$OUTMGGhosts = 'OU=Shadow Accounts,OU=The Miles Group,DC=sigma,DC=com'

$OUHLGICs = 'OU=HLG Contractors,OU=Highlantern Group Employees,DC=sigma,DC=com'
$OUHLGInterns =  'OU=Interns,OU=Highlantern Group Employees,DC=sigma,DC=com'
$OUHLGGhosts =  'OU=Shadow Accounts,OU=Highlantern Group Employees,DC=sigma,DC=com'
$OUHLGServices =  'OU=HLG Service Accounts,OU=Highlantern Group Employees,DC=sigma,DC=com'
$OUGCOA =  'OU=GCOA,OU=Highlantern Group Employees,DC=sigma,DC=com'

$OUMentoreServices = 'OU=Service Accounts,OU=Mentore,DC=sigma,DC=com'


#Import AD Module
Import-Module ActiveDirectory
Add-Type -AssemblyName system.web

#Set New User Information
$Username = 'ipatel'
$Password = [system.web.security.membership]::GeneratePassword(12,2)
$FirstName = 'Imtiaz'
$LastName = 'Patel'
$Email = 'ipatel@ssaandco.com'
$Title = 'IC'
$Phone = 'N/A'
$Department = 'N/A'
$Office = 'New York'
$Company = 'SSA And Company'
$OU = $OUSSAICs


if (Get-ADUser -F {SamAccountName -eq $UserName})
{
    Write-Warning "User Account $Username already exists in Active Directory."
}
else
{

    New-ADUser `
    -SamAccountName $Username `
    -Name "$FirstName $LastName" `
    -GivenName $FirstName `
    -Surname $LastName `
    -DisplayName "$FirstName $LastName" `
    -UserPrincipalName $Email `
    -EmailAddress $Email `
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
    $PSEmailServer = 'smtp.office365.com'
    $emailfrom = 'Onepath Admin <admin.onepath@g100companies.com>'
    $emailto = 'Patrick Wilkes <pwilkes@1path.com>'
    $emailbody = 'User',' ',$FirstName,' ',$LastName,' ',$email,' ','created successfully with password ', $Password -join ''
    $emailsubject = 'New User', ' ',$username, ' ','Credentials' -join ''
    $emailuser = 'admin.onepath@g100companies.com'
    $emailpword = ConvertTo-SecureString -String 'Uzh2!2Bh!@R8T' -AsPlainText -Force
    $emailcredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $emailuser, $emailpword
    Send-MailMessage -from $emailfrom -to $emailto -Subject $emailsubject -Body $emailbody -smtpserver $PSEmailServer -credential $emailcredential -usessl

}