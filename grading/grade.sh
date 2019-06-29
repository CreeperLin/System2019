#!/bin/bash

# read repository url
if [ ! -n "$1" ]; then
    echo "Usage ./grade.sh repository_url"
    exit 1
fi
repo_url=$1

dir=$(cd `dirname $0`; pwd)
#echo $dir

# check simulator
(command -v bochs >/dev/null 2>&1) || {
    echo "Error: Bochs not found"
    exit 1
}

(command -v qemu-system-i386 >/dev/null 2>&1) || {
    echo "Error: qemu not found"
    exit 1
}

# check compiler
(objdump -i 2>&1 | grep 'elf32-i386' > /dev/null 2>&1) ||
    (i386-elf-objdump -i 2>&1 | grep 'elf32-i386' > /dev/null 2>&1) || {
    echo "Error: no i386 compiler toolchain found"
    exit 1
}

# clone original repo
if [ ! -d ./origin ]; then
    git clone https://github.com/CreeperLin/pintos.git "$dir/origin"
fi
ori_path="$dir/origin/src"

# check utilities
make -C "$ori_path/utils" > /dev/null

command -v pintos >/dev/null 2>&1 || {
    export PATH="$PATH:$ori_path/utils"
}

command -v pintos >/dev/null 2>&1 || {
    echo "Error: no pintos script found"
    exit 1
}

# clone test subject
rm -rf "$dir/subject"
mkdir "$dir/subject"
git clone $repo_url --recursive "$dir/subject"
sbj_path=`find "$dir/subject" -name "src"`
if [ -z "$sbj_path" ]; then
    echo "Error: src dir not found"
    exit 1
fi
#echo $sbj_path

# replace test file
rm -rf "${sbj_path}/tests"
cp -r "${ori_path}/tests" "$sbj_path"

# begin grading
make -C "${sbj_path}" clean > /dev/null 

subdirs=("threads" "userprog" "vm" "filesys")

# grading
rm -rf "$dir/results"
mkdir "$dir/results"
for subdir in ${subdirs[@]}; do
    echo "grading $subdir"
    make -C "${sbj_path}/${subdir}" check > "$dir/results/${subdir}.out" 2>&1 && echo "PASSED"
    cp "${sbj_path}/${subdir}/build/results" "$dir/results/${subdir}.results"
done
