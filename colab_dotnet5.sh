#!/usr/bin/env bash
# Adds Jupyter kernels for F# and C# to a Google Colab session
# Atilim Gunes Baydin (gunes@robots.ox.ac.uk), April 2021
# Usage: upload an F# or C# notebook to Colab, open the notebook, then execute the following single line in a new cell before running anything else:
# !bash <(curl -Ls https://raw.githubusercontent.com/gbaydin/scripts/main/colab_dotnet5.sh)
echo -n "Installing dotnet-sdk-5.0 and dotnet interactive for F# and C#..."
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb > /dev/null
apt-get update > /dev/null
apt-get install dotnet-sdk-5.0 > /dev/null
dotnet tool install -g --add-source "https://pkgs.dev.azure.com/dnceng/public/_packaging/dotnet-tools/nuget/v3/index.json" Microsoft.dotnet-interactive > /dev/null
export PATH=$PATH:$HOME/.dotnet/tools
dotnet interactive jupyter install > /dev/null
echo "{\"argv\": [\"$HOME/.dotnet/tools/dotnet-interactive\", \"jupyter\", \"--default-kernel\", \"fsharp\", \"--http-port-range\", \"1000-3000\", \"{connection_file}\"], \"display_name\": \".NET (F#)\", \"language\": \"F#\"}" > /root/.local/share/jupyter/kernels/.net-fsharp/kernel.json
echo "{\"argv\": [\"$HOME/.dotnet/tools/dotnet-interactive\", \"jupyter\", \"--default-kernel\", \"csharp\", \"--http-port-range\", \"1000-3000\", \"{connection_file}\"], \"display_name\": \".NET (C#)\", \"language\": \"C#\"}" > /root/.local/share/jupyter/kernels/.net-csharp/kernel.json
echo " Done."
echo "Select \"Runtime\" -> \"Change Runtime Type\" and click \"Save\" to activate for this notebook"
