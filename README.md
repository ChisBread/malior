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
    malior [command] <game-application> <args>
    e.g. 
        'malior install xonotic' for start xonotic
        'malior xonotic' for start xonotic
        'malior update' for update malior image
Command:
    help             This usage guide
    update           Update malior image
    recreate         Recreate malior runtime container
    destroy          Stop and remove malior runtime container
    pause            Pause(docker stop) malior runtime container
    resume           Resume(docker start) malior runtime container
    install|update   Install or update game
    remove           Remove game
```
- X11 test
```bash
malior glmark2
malior glmark2-es2
```  
- Wayland test
```bash
malior glmark2-wayland
malior glmark2-es2-wayland
``` 
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
| steam(box86)                  | ✅        | 
| L4D2                          | ❌(bootable but not playable) |

## HW Compatibility-List

| Board                         | playable  |
| ----------------------------- | --------- |
| Orange Pi 5                   | ✅        | 