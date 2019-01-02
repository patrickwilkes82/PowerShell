# ***VARIABLES***
$user = 'pwilkes'
$fields = 'Department' #Can be comma separated [Department, Manager, etc...]

# ***EXECUTION***
Set-ADUser $user -clear $fields