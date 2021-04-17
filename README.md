# ARM-STM32-RIOT-Docker
Docker container for RIOT OS

RIOT OS Github: https://github.com/RIOT-OS/RIOT

Container:

docker pull jjveldscholten/arm_riot_toolchain:latest 				                            # Get my docker
docker run --name riot_toolchain -itd jjveldscholten/arm_riot_toolchain:latest	        # Run my docker container
docker cp . riot_toolchain:/RIOT/projects                                               # Copy your code to projects
docker exec -i riot_toolchain bash -c "cd /RIOT/projects/ && make BOARD=nucleo-l452re"  # Compile for example nucleo-l452re
docker cp riot_toolchain:/RIOT/projects/bin .                                           # Copy Bin back to Host
