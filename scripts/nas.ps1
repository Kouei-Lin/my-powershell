New-PSDrive -Name "A" -PSProvider "FileSystem" -Root "\\192.168.xxx.xxx\xxx" -Credential (Get-Credential) -Persist
#Remove-PSDrive -Name 'A'
