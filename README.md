# System2019

Project resources for System(II) 2019 Spring

Stay tuned

## Assignments

### Warmup exercises

(TBD)

### PintOS

A small and simple operating system that runs on x86 machines and simulators.

### Prerequisites

- GCC with 80x86 cross-compiler
- Perl
- GNU make
- GDB
- QEMU: fast x86 simulation with binary translation, but only supports real-time mode
- Bochs: slower simulation but supports real-time and reproducible mode

To install Bochs, download the Bochs source and run

    ./configure --with-x --with-x11 --with-term --with-nogui --enable-gdb-stub

Then run

    make install

### Usage

First build the pintos utility tools. Under src/utils,

    make
    export PATH=$PATH:`pwd`

The following tools are available:

- pintos: utility for running Pintos in a simulator
- pintos-gdb: launch gdb to debug the kernel
- backtrace: converting raw addresses into symbolic backtraces

For each project directory (threads, userprog, vm, filesys),

to build the project, run

    make

the following files can be found in folder 'build/'

- kernel.o: compiled kernel, used for debugging
- kernel.bin: compiled kernel, stripped
- kernel.asm: decompilation of kernel
- kernel.img: image of boot partition
- loader.bin: compiled bootloader
- loader.asm: decompilation of bootloader

to run simulation (here using Bochs and no VGA), run

    pintos -v --bochs -- -q run <testcase_name>

to debug the kernel, run

    pintos -v --bochs --gdb -- -q run <testcase_name>

in a new terminal under 'build/', run

    pintos-gdb kernel.o

in the gdb prompt, run

    debugpintos

the gdb is now connected to the kernel

### Projects

#### Threads

See [JHU CS 318 Project 1](https://www.cs.jhu.edu/~huang/cs318/fall17/project/project1.html) for details.

- alarm clock
- priority scheduling
- advanced scheduler

Objectives:

- pass all the tests
- write a design document

Your document shall include:

- design of timer_sleep()
- design of the scheduler
- advantage & disadvantages of your design

#### User Programs

(TBD)

#### Virtual Memory

(TBD)

#### File Systems

(TBD)

#### Additional features

### Submission

## References

[JHU CS 318 Pintos Project](https://cs.jhu.edu/~huang/cs318/fall17/project/guide.html)

[Original JHU repository](https://github.com/jhu-cs318/pintos)

[Stanford CS 140 Pintos Project](https://web.stanford.edu/class/cs140/projects/pintos/pintos.html)

## Notes