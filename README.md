# ARM STM32 RIOT OS Toolchain Docker Container

This container is created to compile RIOT OS for STM32 Processors

## Installation

See the docker on:  [docker hub](https://hub.docker.com/r/jjveldscholten/arm_riot_toolchain)

```bash
docker pull jjveldscholten/arm_riot_toolchain:latest 
```

## Usage

```bash
docker run --name riot_toolchain -itd jjveldscholten/arm_riot_toolchain:latest	        # Run my docker container
docker cp . riot_toolchain:/RIOT/projects                                               # Copy your code to projects
docker exec -i riot_toolchain bash -c "cd /RIOT/projects/ && make BOARD=nucleo-l452re"  # Compile for example nucleo-l452re
docker cp riot_toolchain:/RIOT/projects/bin .                                           # Copy Bin back to Host

```

## Usage
RIOT OS : [RIOT OS Github](https://github.com/RIOT-OS/RIOT/)

## License
[MIT](https://choosealicense.com/licenses/mit/)
