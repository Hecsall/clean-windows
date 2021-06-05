
######################################
# Uncomment apps you want to install
# then run the script with powershell
######################################

# Disable install confirmation (y/N)
choco feature enable -n allowGlobalConfirmation

# Usually always needed
#######################
choco install 7zip -y
choco install googlechrome
choco install adobereader
choco install jre8
choco install vlc

# Utility
#########
# choco install discord
# choco install telegram
# choco install hwinfo
# choco install geforce-experience
# choco install obs-studio
# choco install qbittorrent
# choco install msiafterburner
# choco install sharex
# choco install spotify
# choco install gpu-z
# choco install anydesk.portable
# choco install rufus.portable
# choco install adwcleaner
# choco install autoruns
# choco install winscp
# choco install powertoys
# choco install wincdemu

# Development
#############
# choco install git
# choco install vscode
# choco install mysql
# choco install notepadplusplus
# choco install postman
# choco install fluent-terminal
# choco install microsoft-windows-terminal