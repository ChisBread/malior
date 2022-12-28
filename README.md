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
wget -O - https://github.com/ChisBread/malior/raw/main/rk3588-enhance/deploy.sh | sudo bash
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
| glmark2                       | ✅         | 
