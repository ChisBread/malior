# Environment variables and usage
## envs.sh
```
The configuration file is `${MALIOR_HOME:-$HOME}/.config/malior/envs.sh` , 
malior(and container) will use the environment variables in it
```
## malior
- MALIOR_PREFIX
  - You can use your own fork (default: https://github.com/ChisBread)
- MALIOR_IMAGE
  - The docker image version to use (default: chisbread/rk3588-gaming:base)
- MALIOR_HOME
  - The directory mounted by the container