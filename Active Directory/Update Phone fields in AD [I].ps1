#Import AD Module or nothing will work 
Import-Module ActiveDirectory

#Set Path of CSV
$USERS = Import-CSV "C:\Users\admin.onepath\Desktop\Update AD User Info\UpdateAD_Addresses.csv"

ForEach($U in $USERS)
{
    If($null -ne $U.StreetAddress) {
        Set-ADUser -Identity $U.SamAccountName -StreetAddress $U.StreetAddress
    }
    If($null -ne $U.City) {
        Set-ADUser -Identity $U.SamAccountName -MobilePhone $U.City
    }
    If($null -ne $U.State) {
        Set-ADUser -Identity $U.SamAccountName -State $U.State
    }
    If($null -ne $U.PostalCode) {
        Set-ADUser -Identity $U.SamAccountName -PostalCode $U.PostalCode
    }
    Set-ADUSer -Identity $U.SamAccountName -StreetAddress $U.StreetAddress -City $U.City -State $U.State -PostalCode $U.PostalCode
}



