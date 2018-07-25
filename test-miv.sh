#!/bin/bash

echo "-------------------------------------------------------------------------"
echo "This script assumes that you are running it in the directory with Renode."
echo "Please provide path to zephyr-sdk as a first argument."
echo "-------------------------------------------------------------------------"

SAMPLE=samples/subsys/shell/shell_module
ROOT_PATH=$PWD
TEST=$ROOT_PATH/

if [ ! -d zephyr ]; then
  git clone https://github.com/zephyrproject-rtos/zephyr.git
fi
cd zephyr
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
export ZEPHYR_SDK_INSTALL_DIR=$1
export BOARD=m2gl025_miv
source zephyr-env.sh
cd $SAMPLE
mkdir -p build && cd build
cmake .. && make -j$(nproc)
cp zephyr/zephyr.elf $TEST/shell.elf
cd $TEST
echo "Running failing test"
robot miv.robot
cp shell_* shell.elf
echo "Running passing test"
robot miv.robot
