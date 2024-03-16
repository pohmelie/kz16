# Counter-Strike 1.6 kz/kreedz/jump server

Main goal of this project is to provide a simple way to run a Counter-Strike 1.6 server with kreedz mod **locally**.

## Prerequisites
- `docker`
- Map pack (for exmaple [this](https://kz-rush.ru/downloads.php?action=download&id=13))

## Quick start
- Unpack map pack to `cstrike_downloads` directory. This should mimic `cstrike` directory, so the `maps` directory should be in `cstrike_downloads/maps` directory.
- Edit `overrides/addons/amxmodx/configs/users.ini` to set admin users (this can be done at any time with restart server after).
- `docker compose up kz16` to start the server. Or `docker compose up -d kz16` to start it in background.
- Wait a little so the server establish connection to mysql database and start the game server.

## Under the hood

### HLDS server
It is a Counter-Strike 1.6 server with some plugins:
- [`steamcmd`](https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz)
- `hlds`
- [`ReGameDLL_CS`](https://github.com/s1lentq/ReGameDLL_CS)
- [`metamod`](https://www.amxmodx.org/downloads.php)
- [`amxmodx`](https://www.amxmodx.org/downloads.php)
- [`reapi`](https://github.com/s1lentq/reapi)
- [`amxxeasyhttp`](https://github.com/Next21Team/AmxxEasyHttp)
- [`kreedz-amxx`](https://github.com/Theggv/Kreedz)

### Web server
This need to allow fast client resouce downloads. It shares only `cstrike_downloads` directory, so your secrets are safe.

### MySQL
It is used to store server data like players, records, settings, etc.

---

## `native` directory
Holds the simple routines without containerization for fast server testing.
