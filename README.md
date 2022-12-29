# Malior [🎮]
- Containerized game packaging for mali gpu under Linux.
- In early development and assume SOC is RK3588(S)
- Test environment: 
  - Linux Distribution: Ubuntu 22.04(Jammy)
  - SOC: RK3588S

## Quick Start
- Install Docker (required)
- Install the 'malior' command
```bash
wget -O - https://github.com/ChisBread/malior/raw/main/install.sh | bash
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
    distroy          Stop and remove malior runtime container
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

## Tested
| Application                   | playable  |
| ----------------------------- | --------- |
| glmark2                       | ✅        | 
| xonotic                       | ✅        | 
