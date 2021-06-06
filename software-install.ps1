#Requires -RunAsAdministrator


# PS-Menu is a required module to run this script
if (!$(Get-Module -ListAvailable PSMenu)) {
    Install-PackageProvider NuGet -Force;
    Set-PSRepository PSGallery -InstallationPolicy Trusted
    Install-Module PSMenu -Repository PSGallery
}


# Check if choco is installed, else install it
if(-not(test-path "C:\ProgramData\chocolatey\choco.exe")){
    Set-ExecutionPolicy Bypass -Scope Process -Force;
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}


# Disable choco install confirmation (y/N)
echo "Checking Choco config"
choco feature enable -n allowGlobalConfirmation


$software_list = [Collections.Generic.List[Object]](@(
    # Usually needed
    ################
    [PSCustomObject]@{ name='7zip';                         chocoName='7zip';}
    [PSCustomObject]@{ name='Google Chrome';                chocoName='googlechrome';}
    [PSCustomObject]@{ name='Adobe Reader';                 chocoName='adobereader';}
    [PSCustomObject]@{ name='JRE11';                        chocoName='jre11';}
    [PSCustomObject]@{ name='VLC';                          chocoName='vlc';}
    # Utility
    #########
    [PSCustomObject]@{ name='Discord';                      chocoName='discord';}
    [PSCustomObject]@{ name='Telegram';                     chocoName='telegram';}
    [PSCustomObject]@{ name='HWInfo';                       chocoName='hwinfo';}
    [PSCustomObject]@{ name='Nvidia Geforce Experience';    chocoName='geforce-experience';}
    [PSCustomObject]@{ name='Nvidia Driver Only (latest)';  chocoName='nvidia-display-driver';}
    [PSCustomObject]@{ name='OBS Studio';                   chocoName='obs-studio';}
    [PSCustomObject]@{ name='QBitTorrent';                  chocoName='qbittorrent';}
    [PSCustomObject]@{ name='MSI Afterburner';              chocoName='msiafterburner';}
    [PSCustomObject]@{ name='ShareX';                       chocoName='sharex';}
    [PSCustomObject]@{ name='Spotify';                      chocoName='spotify';}
    [PSCustomObject]@{ name='GPU-Z';                        chocoName='gpu-z';}
    [PSCustomObject]@{ name='Anydesk (Portable)';           chocoName='anydesk.portable';}
    [PSCustomObject]@{ name='Rufus (Portable)';             chocoName='rufus.portable';}
    [PSCustomObject]@{ name='Adw Cleaner';                  chocoName='adwcleaner';}
    [PSCustomObject]@{ name='Autoruns';                     chocoName='autoruns';}
    [PSCustomObject]@{ name='WinSCP';                       chocoName='winscp';}
    [PSCustomObject]@{ name='Powertoys';                    chocoName='powertoys';}
    [PSCustomObject]@{ name='WinCDEmu';                     chocoName='wincdemu';}
    # Development
    #############
    [PSCustomObject]@{ name='Git';                          chocoName='git';}
    [PSCustomObject]@{ name='Visual Studio Code';           chocoName='vscode';}
    [PSCustomObject]@{ name='MySQL';                        chocoName='mysql';}
    [PSCustomObject]@{ name='Notepad++';                    chocoName='notepadplusplus';}
    [PSCustomObject]@{ name='Postman';                      chocoName='postman';}
    [PSCustomObject]@{ name='Fluent Terminal';              chocoName='fluent-terminal';}
    [PSCustomObject]@{ name='Microsoft Windows Terminal';   chocoName='microsoft-windows-terminal';}
)) | Sort-Object -Property name


function runSoftwareSelection() {
    echo ""
    echo "Select the software you want to install, or press ESC to exit"
    echo "(Move with ARROW KEYS, select with SPACEBAR, continue with ENTER)"
    echo ""

    $selected = menu $software_list.name -Multiselect -ReturnIndex

    foreach ($software_index in $selected) {
        $software_chocoName = $software_list[$software_index].chocoName
        iex "choco install $software_chocoName"
    }
}


runSoftwareSelection
