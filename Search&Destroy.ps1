# The following section will establish a powershell session from your onprem exchange server and give you access to exchange powershell commands. 
$UserCredential = Get-Credential -Message "Please enter your Exchange Server Credentials"
$authType = 'Kerberos'
$exchangeURL = 'http://<YOUREXCHANGESERVERNAME>/PowerShell/'
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $exchangeURL -Authentication $authType -Credential $UserCredential -AllowRedirection
Import-PSSession $Session -DisableNameChecking -AllowClobber


# Creates and object with all the members for the below specified group
$users = Get-distributiongroupmember -identity “marketing team”

# For every member of the users object execute the below command
foreach ($u in $users){
    # This command will go through the users mailbox and search for the email that matches the below criteria, it will then copy the contents and result of the search to the ADMIN mailbox and finally delete the email from the users mailbox
    Search-Mailbox -identity "$($u.Name)" -SearchQuery {Subject:'<subject of email to be found>' AND From:'chance@company.com' Received:01/01/2020} -TargetMailbox "ADMIN" -TargetFolder "SearchResults" -logonly -loglevel full -deletecontent
}