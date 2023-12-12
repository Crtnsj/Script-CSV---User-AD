Import-Module ActiveDirectory

$CSVFile = "C:\Source\Liste-users.csv"
$CSVData = Import-Csv -Path $CSVFile

foreach ($user in $CSVData) {
    $FName = $user."Prenom"
    $LName = $user."Nom"
    $Ounity = $user."Groupe"
    $Pwd = $user."Mdp"
    $Session = $user."Session"
    $DomainName = "domain"

    New-ADUser -Name "$FName $LName" -GivenName "$FName" -Surname "$LName" -SamAccountName "$Session" -UserprincipalName "$Session@$DomainName" -AccountPassword (ConvertTo-SecureString "$Pwd" -AsPlainText -Force) -Path "OU=$Ounity,OU=Utilisateurs,DC=$DomainName,DC=local" -ChangePasswordAtLogon $true -Enabled $true

    Add-ADGroupMember -Identity "$Ounity" -Members "$Session"
}
