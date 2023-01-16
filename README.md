# Malior [🎮]
- Containerized game packaging for mali gpu under Linux.
  - Full audio, graphics support.
  - Linux native games, box86/64 simulation games, etc.
  - Support systemd, etc.
- In early development and assume SOC is RK3588(S)
- Test environment: 
  - Linux Distribution: Ubuntu 22.04(Jammy)
  - Desktop: Gnome with Wayland
  - SOC: RK3588S

## Quick Start
- Install Docker (required)
- Install the 'malior' command
```bash
wget -O - https://github.com/ChisBread/malior/raw/main/install.sh > /tmp/malior-install.sh && bash /tmp/malior-install.sh  && rm /tmp/malior-install.sh 
```
- malior help
```
Usage: 
    malior [command] <game|application> <args>
    e.g. 
        'malior install xonotic' for install xonotic
        'malior xonotic' for start xonotic
        'malior update (malior, xonotic, etc...)' for update something
        'malior update' for update malior image
Command:
    help                   This usage guide
    update <game|app>      Update malior image
    recreate               Recreate malior runtime container
    destroy                Stop and remove malior runtime container
    pause|stop             Pause(docker stop) malior runtime container
    resume|start           Resume(docker start) malior runtime container
    remove                 Remove game
```
- malior-sudo
```bash
malior-sudo 'echo $USER'
```
## Settings
- [Settings document](./SETTINGS.md)
## Tips
- Already have xonotic installed locally?
```
# game dir
mv ${LOCAL_XONOTIC_DIR} $HOME/.local/malior/xonotic
# config dir
mv $HOME/.xonotic $HOME/.config/malior/.xonotic
# ln -s $HOME/.local/malior/xonotic ${LOCAL_XONOTIC_DIR}
# ln -s $HOME/.config/malior/.xonotic $HOME/.xonotic
malior install xonotic # Will not re-download all content
```
## Application(Game) Compatibility-List
| Application                   | playable  |
| ----------------------------- | --------- |
| glmark2(gl,es2,x11,wayland)   | ✅        | 
| xonotic(sdl)                  | ✅        | 
| openmw                        | ✅(not fully tested) | 
| Warcraft III(box86+wine)      | ✅(perfect!)        |
| steam(box86)                  | ✅        | 
| L4D2                          | ❌(bootable but not playable) |

## HW Compatibility-List

| Board                         | playable  |
| ----------------------------- | --------- |
| Orange Pi 5                   | ✅        | 

# Thanks to the following projects:
- [box86](https://github.com/ptitSeb/box86), [box64](https://github.com/ptitSeb/box64)
- [panfork](https://gitlab.com/panfork/mesa)

# Malior Redroid
- malior install malior-redroid
- malior-redroid help
```
Usage:
    malior-droid [command] <game|application> <args>
    note. kernel config PSI ASHMEM ANDROID_BINDERFS etc... is required
    warning. zygisk is not supported, will mess up the container when enabled
    e.g.
        'malior-droid whoami' is same as 'adb shell whoami' (root user)
        'adb connect localhost:5555' for adb
        'scrcpy -s localhost:5555' view redroid screen
Command:
    help                   This usage guide
    update                 Update malior redroid image
    recreate               Recreate malior redroid container
    destroy                Stop and remove malior redroid container
    pause|stop             Pause(docker stop) malior redroid container
    resume|start           Resume(docker start) malior redroid container
    restart                Restart malior redroid container
    resize                 Resize redroid window e.g. malior-droid resize 1920x1080
    install-overlay        Overlays
```
- Manual part
    - Fixup Magisk installation and reboot (Maybe it takes two times, maybe the host will restart)
    - (Optional) Install Riru-v25.4.4 LSPosed-v1.8.5 (tested version)
    - (Optional) Register [GSF ID](https://www.google.com/android/uncertified/?pli=1), let Google framework work
        - Use the device id app to get the GSF ID
- Backup: data partition `~/.local/malior/redroid`.
- Restore: `malior-droid destroy` and restore data partition from backup.

