# Search for all mailboxes a user has access to 
# Ken Warnimont / Source One Technology / 7-8-2022
# It's ugly, but it works.

# Gather login username for Exchange Online connection
$logonUser = Read-Host -prompt 'Enter your email address for the Exchange Online connection'

# Connect to Exchange Online using that user account
connect-exchangeonline -UserPrincipalName $logonUser

#Prompt for user to Search for

$SearchUser = Read-Host -prompt 'Input the email address to search for delegated permissions on (i.e. deto@goodfoods.com)'

write-Host 'Listing permissions for user ' $SearchUser

# Loop through all mailboxes in the organization, get the recipient permissions, and dump out all lines where the listed user is in the ACL
get-mailbox -ErrorAction 'silentlycontinue' | get-mailboxpermission -ErrorAction 'silentlycontinue'  | where-object {$_.User -eq $SearchUser} 

Disconnect-ExchangeOnline -
