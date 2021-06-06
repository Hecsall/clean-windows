#Requires -RunAsAdministrator


# Ask for elevated permissions if required
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	Exit
}


# PSMenu is a required module to run this script
if (!$(Get-Module -ListAvailable PSMenu)) {
    Install-PackageProvider NuGet -Force;
    Set-PSRepository PSGallery -InstallationPolicy Trusted
    Install-Module PSMenu -Repository PSGallery
}


$enhancements_list = [Collections.Generic.List[Object]](@(
    ########
    # Audio
    ########
    [PSCustomObject]@{
        name='Set Communications Audio Ducking to Do Nothing';
        script='
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Multimedia\Audio" -Name "UserDuckingPreference" -Type DWord -Value 3;
        '
    }
    ########
    # Mouse
    ########
    [PSCustomObject]@{
        name='Set mouse speed to 1:1 value';
        script='
            Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSensitivity" -Type String -Value "10"
        '
    }
    [PSCustomObject]@{
        name='Disabling Enhance pointer precision';
        script='
            Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Type String -Value "0"
        '
    }
    ##########################
    # General Personalization
    ##########################
    [PSCustomObject]@{
        name='Hide Recently added apps';
        script='
            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer")) {
                New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" | Out-Null
            }
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Type DWord -Value 1
        '
    }
    [PSCustomObject]@{
        name='Disabling Show suggestions occasionally in Start';
        script='
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
        '
    }
    [PSCustomObject]@{
        name='Disabling Show recently opened files in Jump Lists';
        script='
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Type DWord -Value 0
        '
    }
))


function runEnhancementsSelection() {
    echo ""
    echo "Select the enhancements you want to apply, or press ESC to exit"
    echo "(Move with ARROW KEYS, select with SPACEBAR, continue with ENTER)"
    echo ""

    $selected = Show-Menu $enhancements_list.name -Multiselect -ReturnIndex

    foreach ($enhancement_index in $selected) {
        $enhancement = $enhancements_list[$enhancement_index]
        echo "Running: $($enhancement.name)"
        iex $enhancement.script
    }
}


runEnhancementsSelection
