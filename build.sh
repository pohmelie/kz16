download_if_not_exists() {
    if [ ! -f "$2" ]; then
        wget -O "$2" "$1"
    fi
}

ensure_empty_directory() {
    rm -rf "$1"
    mkdir -p "$1"
}

mkdir -p downloads

echo "Installing steamcmd"
URL=https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
download_if_not_exists ${URL} downloads/steamcmd.tar.gz
if [ ! -d "downloads/steamcmd" ]; then
    ensure_empty_directory downloads/steamcmd
    tar -xzf downloads/steamcmd.tar.gz -C downloads/steamcmd
fi

echo "Installing Counter-Strike 1.6"
until downloads/steamcmd/steamcmd.sh \
    +force_install_dir kz16 \
    +login anonymous \
    +app_set_config 90 mod cstrike \
    +app_update 90 -beta steam_legacy validate \
    +quit; \
    do sleep 1;
done
ensure_empty_directory kz16
cp -rf downloads/steamcmd/kz16/* kz16

echo "Installing ReGameDLL_CS"
REGAMEDLL_CS_VERSION="5.26.0.668"
URL="https://github.com/s1lentq/ReGameDLL_CS/releases/download/${REGAMEDLL_CS_VERSION}/regamedll-bin-${REGAMEDLL_CS_VERSION}.zip"
download_if_not_exists ${URL} downloads/regamedll.zip
ensure_empty_directory downloads/regamedll
unzip -o downloads/regamedll.zip -d downloads/regamedll
cp -rf downloads/regamedll/bin/linux32/* kz16

echo "Installing metamod"
METAMOD_VERSION="1.21.1-am"
URL="https://www.amxmodx.org/release/metamod-${METAMOD_VERSION}.zip"
download_if_not_exists ${URL} downloads/metamod.zip
ensure_empty_directory downloads/metamod
unzip -o downloads/metamod.zip -d downloads/metamod
cp -rf downloads/metamod/addons kz16/cstrike
echo 'gamedll_linux "addons/metamod/dlls/metamod.so"' >> kz16/cstrike/liblist.gam

echo "Installing amxmodx"
AMXMODX_VERSION="1.9.0-git5294"
URL="https://www.amxmodx.org/amxxdrop/1.9/amxmodx-${AMXMODX_VERSION}-base-linux.tar.gz"
download_if_not_exists ${URL} downloads/amxmodx-base.tar.gz
ensure_empty_directory downloads/amxmodx-base
tar -xzf downloads/amxmodx-base.tar.gz -C downloads/amxmodx-base
cp -rf downloads/amxmodx-base/addons kz16/cstrike
URL="https://www.amxmodx.org/amxxdrop/1.9/amxmodx-${AMXMODX_VERSION}-cstrike-linux.tar.gz"
download_if_not_exists ${URL} downloads/amxmodx-cstrike.tar.gz
ensure_empty_directory downloads/amxmodx-cstrike
tar -xzf downloads/amxmodx-cstrike.tar.gz -C downloads/amxmodx-cstrike
cp -rf downloads/amxmodx-cstrike/addons kz16/cstrike
echo 'linux addons/amxmodx/dlls/amxmodx_mm_i386.so' > kz16/cstrike/addons/metamod/plugins.ini

echo "Installing reapi"
REAPI_VERSION="5.24.0.300"
URL="https://github.com/s1lentq/reapi/releases/download/${REAPI_VERSION}/reapi-bin-${REAPI_VERSION}.zip"
download_if_not_exists ${URL} downloads/reapi.zip
ensure_empty_directory downloads/reapi
unzip -o downloads/reapi.zip -d downloads/reapi
cp -rf downloads/reapi/addons kz16/cstrike

echo "Installing amxxeasyhttp"
AMXXEASYHTTP_VERSION="1.3.0"
URL="https://github.com/Next21Team/AmxxEasyHttp/releases/download/${AMXXEASYHTTP_VERSION}/release_linux_v${AMXXEASYHTTP_VERSION}.zip"
download_if_not_exists ${URL} downloads/amxxeasyhttp.zip
ensure_empty_directory downloads/amxxeasyhttp
unzip -o downloads/amxxeasyhttp.zip -d downloads/amxxeasyhttp
cp -rf downloads/amxxeasyhttp/release_linux_v${AMXXEASYHTTP_VERSION}/addons kz16/cstrike

echo "Installing kreedz-amxx"
KREEDZ_AMXX_VERSION=130
URL="https://github.com/Theggv/Kreedz/releases/download/kreedz-amxx-${KREEDZ_AMXX_VERSION}/kreedz-amxx-${KREEDZ_AMXX_VERSION}-addons.zip"
download_if_not_exists ${URL} downloads/kreedz-amxx-addons.zip
ensure_empty_directory downloads/kreedz-amxx-addons
unzip -o downloads/kreedz-amxx-addons.zip -d downloads/kreedz-amxx-addons
cp -rf downloads/kreedz-amxx-addons/addons kz16/cstrike

# overrides
cp -rf overrides/* kz16
