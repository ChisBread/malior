# Environment variables and usage
## envs.sh
```
The configuration file is `$MALIOR_HOME/.config/malior/envs.sh` , 
malior(and container) will use the environment variables in it
```
## malior
- MALIOR_PREFIX
  - You can use your own fork (default: https://github.com/ChisBread)
- MALIOR_IMAGE
  - The docker image to use (default: chisbread/rk3588-gaming:base)
- MALIOR_HOME
  - The directory mounted by the container (default: $HOME)
# others
- MALI_BLOB
  - Set to 'MALI_BLOB=x11' means to enable the x11 version of the libmali driver (default: None)
  - note. In some games, the blob driver will be more stable