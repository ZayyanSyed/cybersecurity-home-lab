<#
.SYNOPSIS
    Bulk-creates domain users across IT, Finance, and Sales OUs for the 
    cybersecurity home lab (corp.local).

.DESCRIPTION
    Creates 12 users per OU (36 total) with a standard lab password policy.
    The j.smith account (IT OU) uses a deliberately weak, policy-compliant 
    password for the brute-force detection exercise - see incident-report.md.
#>

$DefaultPassword = ConvertTo-SecureString "LabPass2026!" -AsPlainText -Force
$Domain = "corp.local"

$Users = @{
    "IT" = @(
        "Aisha.Patel","Daniyal.Ahmed","Emma.Davies","John.Smith","Kevin.Brown",
        "Liam.Nguyen","Mustafa.Hanif","Noah.Kaur","Pat.Cummins","Sarah.Khan",
        "Syed.Zayyan","Talha.Rehmani"
    )
    "Finance" = @(
        "Ava.Murphy","Beia.Dianne","Caleb.Allen","Ethan.Ali","Hassan.Abrar",
        "Kevin.Jose","Leah.Murphy","Lexy.Allen","Lucas.Walsh","Olivia.Parker",
        "Ruby.Walsh","Rufus.Jason"
    )
    "Sales" = @(
        "Alex.Grace","Ally.Quinn","Brenda.Chau","Ella.Quinn","Emma.Watson",
        "Grace.Doyle","Henry.Fox","James.Byrne","Marwa.Zainab","Mia.Reilly",
        "Naveen.Kumar","Tanveer.Hussain"
    )
}

foreach ($OU in $Users.Keys) {
    $OUPath = "OU=$OU,OU=Corp,DC=corp,DC=local"

    foreach ($FullName in $Users[$OU]) {
        $Parts = $FullName -split '\.'
        $FirstName = $Parts[0]
        $LastName  = $Parts[1]
        $SamAccountName = "$($FirstName.ToLower().Substring(0,1)).$($LastName.ToLower())"

        # j.smith gets a deliberately weak (but policy-compliant) password
        # for the brute-force detection exercise.
        $UserPassword = if ($SamAccountName -eq "j.smith") {
            ConvertTo-SecureString "Welcome1!" -AsPlainText -Force
        } else {
            $DefaultPassword
        }

        New-ADUser `
            -Name "$FirstName $LastName" `
            -GivenName $FirstName `
            -Surname $LastName `
            -SamAccountName $SamAccountName `
            -UserPrincipalName "$SamAccountName@$Domain" `
            -Path $OUPath `
            -AccountPassword $UserPassword `
            -Enabled $true `
            -ChangePasswordAtLogon $false

        Write-Host "Created user: $SamAccountName ($OU)"
    }
}