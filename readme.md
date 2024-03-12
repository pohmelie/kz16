# Counter-Strike 1.6 kz/kreedz/jump server

## How to use it
It can be used as a standalone server or as a docker container.

### Native
1. Run `bash build.sh` to download, unpack and verify all necessary files.
1. Run `bash start.sh` to start the server (first run will be failed, don't worry).

### Docker
1. Run `docker build -t kz16 .` to build the image.
1. Run `docker run --name kz16 -it --net host kz16` to start the server.

## Add maps
It is pretty simple for native variant. Just unpack map pack to proper directory. For exmaple [this](https://kz-rush.ru/downloads.php?action=download&id=13) pack.

## Technical details
- [`steamcmd`](https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz)
- `hlds`
- [`ReGameDLL_CS`](https://github.com/s1lentq/ReGameDLL_CS)
- [`metamod`](https://www.amxmodx.org/downloads.php)
- [`amxmodx`](https://www.amxmodx.org/downloads.php)
- [`reapi`](https://github.com/s1lentq/reapi)
- [`amxxeasyhttp`](https://github.com/Next21Team/AmxxEasyHttp)
- [`kreedz-amxx`](https://github.com/Theggv/Kreedz)

## Caveats
Some plugins related to database (sqlite, mysql) plugins are not worked, so they are disabled by `overrides` directory content.
