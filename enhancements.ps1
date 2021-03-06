# Ask for elevated permissions if required
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}


########
# Audio
########

# Set Communications Audio Ducking to "Do Nothing"
Write-Host "Set Communications Audio Ducking to Do Nothing..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Multimedia\Audio" -Name "UserDuckingPreference" -Type DWord -Value 3


########
# Mouse
########

# Set Mouse to 1:1
Write-Host "Set mouse speed to 1:1 value..."
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSensitivity" -Type String -Value "10"

# Disable Mouse "Enhance pointer precision"
Write-Host "Disabling Enhance pointer precision..."
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Type String -Value "0"


##########################
# General Personalization
##########################

# Hide "Recently added apps" from start menu
Write-Host "Hide Recently added apps..."
If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Type DWord -Value 1

# Disable "Show suggestions occasionally in Start"
Write-Host "Disabling Show suggestions occasionally in Start..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0

# Disable "Show recently opened files in Jump Lists"
Write-Host "Disabling Show recently opened files in Jump Lists..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Type DWord -Value 0