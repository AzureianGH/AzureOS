#export the variable AZOSBP, contains the current directory. TODO: Make it changeable using parameters.
export AZOSBP=/mnt/e/Downloads/azureos-20240127T032736Z-001/azureos
#get arguments from command line, if one of the args is --no-clean, then dont run rm *.o *.bin *.dis
#if not in dir /mnt/e/Downloads/azureos-20240127T032736Z-001/azureos/ the throw error
if [ "$PWD" != "$AZOSBP" ]; then
    #check if any rguments contain --force-dir:
    for var in "$@"
    do
	    if [[ $var == *"--force-dir:"* ]]; then
		    export FORCE=1
	    fi
    done
	#color red
    #if force is not set, then throw an error
    if [ "$FORCE" != "1" ]; then
	    tput setaf 1
	    echo "Error: not in directory $AZOSBP"
	    #color white
	    tput setaf 7
        echo "You can use (--force-dir:), although not recommended"
	    echo "Add Argument --help for more information"
	    #exit
        exit
    fi
fi

#create list variable of valid arguments
validArgs=(--version --help --clean-all --clean-non-os --no-clean --no-link --no-asm --no-CROSSCOMPILER/bin/x86_64-elf-gcc --run-vm --format:img --format:raw --no-debug --no-reboot --force-dir: --export-gdb)

# if --version
for var in "$@"
do
    if [ "$var" = "--version" ]; then
        echo "AzureOSBT, version 0.0.7-dev (i386 Compiler)"
        echo "Copyright (c) 2024 Hydrix Corporation"
        echo "Licensed under the GNU General Public License v2.0"
        echo ""
        echo "This software is provided as-is, without any warranty."
        echo ""
        echo "Add Argument --help for more information"
        #exit
        exit
    fi
done

# if --help
for var in "$@"
do
    if [ "$var" = "--help" ]; then
        echo "AzureOSBT, version 0.0.7-dev (i386 Compiler)"
        #property of Hydrix Corporation
        echo "Usage: ./main.sh [options]"
        echo ""
        echo "Options:"
        echo "  --version       Display version information and exit"
        echo "  --help          Display this information and exit"
        echo "  --clean-all     Clean all files"
        echo "  --clean-non-os  Clean all files except the OS image"
        echo "  --no-clean      Do not clean files"
        echo "  --no-link       Do not link files"
        echo "  --no-asm        Do not assemble assembly files"
        echo "  --no-CROSSCOMPILER/bin/x86_64-elf-gcc        Do not compile C files"
        echo "  --run-vm        Run the OS in a VM"
        echo "  --format:  (img, raw)    Format the OS to specified format"
        echo "  --no-debug      Do not run with debug output"
        echo "  --no-reboot     Do not reboot after running (Does not reboot if crash occurs)"
        echo "  --force-dir:    Force directory to specified directory"
        echo "  --export-gdb    Export GDB"
        echo ""
        echo "This is free software, but (recipient) is not allowed to redistribute this software."
        echo "This software is provided as-is, without any warranty."
        echo ""
        echo "Add Argument --help for more information"
        #exit
        exit
    fi
done

#if --clean-all
for var in "$@"
do
    if [ "$var" = "--clean-all" ]; then
        echo "Cleaning"
        rm *.o *.dis
        #remove mbr.bin and kernel.bin
        rm ./mbr.bin ./kernel.bin
        #remove azure-os.bin
        rm ./azure-os.bin
        rm ./azure-os.img
        rm ./kernel.elf
        rm ./kernel.sym
        rm *.log
        #exit
        exit
    fi
done

#if --clean-non-os
for var in "$@"
do
    if [ "$var" = "--clean-non-os" ]; then
        echo "Cleaning"
        rm *.o *.dis
        #remove mbr.bin and kernel.bin
        rm ./mbr.bin ./kernel.bin
        #exit
        exit
    fi
done
#if --format:img
for var in "$@"
do
	if [ "$var" = "--format:img" ]; then
		echo "Formatting: IMG"
		
        export ISIMG=1
		#exit
	fi
done

# if --format:raw
for var in "$@"
do
	if [ "$var" = "--format:raw" ]; then
        echo "Formatting: RAW"
		export ISRAW=1
	fi
done

#if there is no --format: argument, then default to --format:raw and warn the user
if [ "$ISIMG" != "1" ]; then
	if [ "$ISRAW" != "1" ]; then
        #color yellow
        tput setaf 3
		echo "WARN: No format argument specified, defaulting to RAW formmating."
    #color white
		tput setaf 7
		export ISRAW=1

	fi
fi

#check if the user has passed in the --no-clean argument, any of the args passed are checked for --no-clean
for var in "$@"
do
    if [ "$var" = "--no-clean" ]; then
        echo "Cleaning disabled"
        export NOCLEAN=1
    fi
done

# if --no-link
for var in "$@"
do
    if [ "$var" = "--no-link" ]; then
        echo "Linking disabled"
        export NOLINK=1
    fi
done

#if --export-gdb
for var in "$@"
do
	if [ "$var" = "--export-gdb" ]; then
		echo "Exporting GDB"
		export EXPORTGDB=1
	fi
done

#if --no-asm
for var in "$@"
do
    if [ "$var" = "--no-asm" ]; then
        echo "Assembly Assembling disabled"
        export NOASM=1
    fi
done

#if --no-CROSSCOMPILER/bin/x86_64-elf-gcc
for var in "$@"
do
    if [ "$var" = "--no-gcc" ]; then
        echo "GCC Compilation disabled"
        export NOGCC=1
    fi
done

#if --run-vm
for var in "$@"
do
    if [ "$var" = "--run-vm" ]; then
        echo "Running VM Enabled"
        export RUNVM=1
    fi
done

#if --no-debug
for var in "$@"
do
	if [ "$var" = "--no-debug" ]; then
		echo "Debug output disabled"
		export NODEBUG=1
	fi
done

#if --no-reboot
for var in "$@"
do
	if [ "$var" = "--no-reboot" ]; then
		echo "Reboot disabled"
		export NOREBOOT=1
	fi
done

#if an invalid argument is passed, then exit, and display an error
for var in "$@"
do
    if [[ ! " ${validArgs[@]} " =~ " ${var} " ]]; then
        #check if the argument contains --force-dir:
if [[ $var == *"--force-dir:"* ]]; then
			#remove --force-dir:
			var=${var/--force-dir:/}
			#check if the argument is a valid directory
			if [ -d "$var" ]; then
				#change directory to the specified directory
				cd $var
                #goto compile
                echo "Forcing directory: $var"
                goto compile
			fi
			#if the directory is not valid, then throw an error
			if [ ! -d "$var" ]; then
				#color red
				tput setaf 1
				echo "Error: Invalid Directory: $var"
				#color white
				tput setaf 7
				echo "Add Argument --help for more information"
				#exit
				exit
			fi
		fi
        tput setaf 1
        echo "Error: Invalid Argument: $var"
#color white
		tput setaf 7
        echo "Add Argument --help for more information"
        #exit
        exit
    fi
done

# Compile OS
#start compiletimer
compilestart=$(date +%s)
#if --no-asm is set, then dont assemble the assembly files
if [ "$NOASM" != "1" ]; then
    nasm ./Assembly/kernel-entry.asm -f elf -o ./kernel-entry.o
    nasm ./Assembly/mbr.asm -f bin -o ./mbr.bin
fi
if [ "$NOGCC" != "1" ]; then
    #start timer
    start=$(date +%s)
    echo "Compiling C files..."
    CROSSCOMPILER/bin/x86_64-elf-gcc -m32 -g -ffreestanding -Wall  -Wno-unused-variable -c ./kernel.c -o ./kernel.o
    CROSSCOMPILER/bin/x86_64-elf-gcc -m32 -g -ffreestanding -Wall  -Wno-unused-variable -c ./standard/display/display.c -o ./display.o
    CROSSCOMPILER/bin/x86_64-elf-gcc -m32 -g -ffreestanding -Wall  -Wno-unused-variable -c ./standard/memory/memory.c -o ./memory.o
    CROSSCOMPILER/bin/x86_64-elf-gcc -m32 -g -ffreestanding -Wall  -Wno-unused-variable -c ./standard/basic/types/types.c -o ./types.o
    CROSSCOMPILER/bin/x86_64-elf-gcc -m32 -g -ffreestanding -Wall  -Wno-unused-variable -c ./standard/basic/string/string.c -o ./string.o
    CROSSCOMPILER/bin/x86_64-elf-gcc -m32 -g -ffreestanding -Wall  -Wno-unused-variable -c ./standard/keyboard/keyboard.c -o ./keyboard.o
    CROSSCOMPILER/bin/x86_64-elf-gcc -m32 -g -ffreestanding -Wall  -Wno-unused-variable -c ./standard/basic/ports/ports.c -o ./ports.o
    CROSSCOMPILER/bin/x86_64-elf-gcc -m32 -g -ffreestanding -Wall  -Wno-unused-variable -c ./standard/basic/basic.c -o ./basic.o
    CROSSCOMPILER/bin/x86_64-elf-gcc -m32 -g -ffreestanding -Wall  -Wno-unused-variable -c ./standard/basic/CPU/int/idt.c -o ./idt.o
    #end timer
	end=$(date +%s)
    #calculate time taken
	runtime=$((end-start))
	echo "C files compiled in $runtime seconds"
fi
# Linking
if [ "$NOLINK" != "1" ]; then
    #if no asm, dont link
    if [ "$NOASM" != "1" ]; then
        linktimer=$(date +%s)
        CROSSCOMPILER/bin/x86_64-elf-ld -m elf_i386 -o ./kernel.elf -Ttext 0x1000 ./kernel-entry.o ./kernel.o ./display.o ./memory.o ./types.o ./string.o ./keyboard.o ./ports.o ./basic.o ./idt.o
        CROSSCOMPILER/bin/x86_64-elf-ld -m elf_i386  -o ./kernel.bin -Ttext 0x1000 ./kernel-entry.o ./kernel.o ./display.o ./memory.o ./types.o ./string.o ./keyboard.o ./ports.o ./basic.o ./idt.o --oformat binary
        endlinkertime=$(date +%s)
        linkertime=$((endlinkertime-linktimer))
        echo "Linked in $linkertime seconds"
    fi
    
    #if asm is enabled, then link the mbr.bin file
    if [ "$NOASM" != "1" ]; then
        cat ./mbr.bin ./kernel.bin > ./azure-os.bin
        #if no-clean is disabled
        if [ "$NOCLEAN" != "1" ]; then
            rm *.o *.dis

            #if format is raw, remove azure-os.img
            if [ "$ISRAW" = "1" ]; then
				rm ./azure-os.img
			fi

            #remove mbr.bin and kernel.bin
            rm ./mbr.bin ./kernel.bin
        fi
    fi
fi
if [ "$ISIMG" = "1" ]; then
    startddtimer=$(date +%s)
	dd if=./azure-os.bin of=./azure-os.img bs=512 count=2880
    endddtimer=$(date +%s)
	ddtime=$((endddtimer-startddtimer))
	echo "IMG formatted in $ddtime seconds"
fi

#export gdb
if [ "$EXPORTGDB" = "1" ]; then
    starttimerobjcopy= $(date +%s)
    objcopy --only-keep-debug ./kernel.elf ./kernel.sym
    endtimerobjcopy= $(date +%s)
	runtimeobjcopy=$((endtimerobjcopy-starttimerobjcopy))
	echo "GDB exported in $runtimeobjcopy seconds"
fi
#end compiletimer
compileend=$(date +%s)
#calculate time taken
compilertime=$((compileend-compilestart))
echo "OS Compiled in $compilertime seconds"
# Run VM
if [ "$RUNVM" = "1" ]; then
    #if --format:img is set, then format to .img
    if [ "$ISIMG" = "1" ]; then
        
        #if --no-debug is false, then run with debug output
        if [ "$NODEBUG" != "1" ]; then
			qemu-system-i386  -no-reboot -d int -s -S -fda ./azure-os.img 2>&1 | tee -a ./azure-os-img.log
		fi
        #else , run w
        if [ "$NODEBUG" = "1" ]; then
			qemu-system-i386  -no-reboot -fda ./azure-os.img
		fi
	fi
    # if --format:raw is set, then format to .raw
    if [ "$ISRAW" = "1" ]; then
            #if --no-debug is false, then run with debug output
        if [ "$NODEBUG" != "1" ]; then
            #if -- no-reboot is false, then reboot after running
            if [ "$NOREBOOT" != "1" ]; then
				qemu-system-i386  -d int -s -S -fda ./azure-os.bin 2>&1 | tee -a ./azure-os-raw.log
			fi
            #if --no-reboot is true, then dont reboot after running
            if [ "$NOREBOOT" = "1" ]; then
			    qemu-system-i386  -no-reboot -d int -s -S -fda ./azure-os.bin 2>&1 | tee -a ./azure-os-raw.log
            fi
        fi
		#else , run without debug output
		if [ "$NODEBUG" = "1" ]; then
            #if --no-reboot is false, then reboot after running
			if [ "$NOREBOOT" != "1" ]; then
                qemu-system-i386  -fda ./azure-os.bin
            fi
            #if --no-reboot is true, then dont reboot after running
			if [ "$NOREBOOT" = "1" ]; then
				qemu-system-i386  -no-reboot -fda ./azure-os.bin
			fi
        fi
    fi
fi