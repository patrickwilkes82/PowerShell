#Import AD Module or nothing will work 
Import-Module ActiveDirectory

#Set Path of CSV
$USERS = Import-CSV "C:\Users\admin.onepath\Desktop\Update AD User Info\AllCompanyUpdate.csv"

ForEach($U in $USERS)
{
    If($null -ne $U.TelephoneNumber) {
        Set-ADUser -Identity $U.SamAccountName -OfficePhone $U.TelephoneNumber
    }
    If($null -ne $U.Mobile) {
        Set-ADUser -Identity $U.SamAccountName -MobilePhone $U.Mobile
    }
    If($null -ne $U.IpPhone) {
        Set-ADUser -Identity $U.SamAccountName -Replace @{IpPhone = $U.IpPhone}
    }
    Set-ADUSer -Identity $U.SamAccountName -OfficePhone $U.TelephoneNumber -MobilePhone $U.Mobile -Company $U.Company -Office $U.Office -Title $U.Title -Replace @{IpPhone = $U.IpPhone}
}



