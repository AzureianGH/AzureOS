# AzureOS Readme

## Introduction

Welcome to AzureOS, an operating system created by Azureian. This readme provides an overview of the project and instructions on how to work with the source code.

## Building AzureOS

To build AzureOS, follow these steps:

1. Set the `AZOSBP` environment variable to the directory containing the AzureOS source code.

   ```bash
   export AZOSBP=/path/to/azureos
   ```
   
Run the build script azosbt.sh:
```./azosbt.sh```
Explore script options such as --version, --help, --clean-all, --run-vm, and more. Refer to the script's help message for detailed information on available options.

Interrupt Descriptor Table (IDT)

The IDT is a crucial part of the x86 architecture, responsible for handling interrupts and exceptions. The current state of the AzureOS source code does not include the implementation of the IDT. Implementing the IDT involves setting up interrupt service routines (ISRs) and configuring the IDT descriptors. This functionality is yet to be developed in the project.
Script Options

The azosbt.sh script supports various options to customize the build process. Here are some key options:

    --version: Display version information.
    --help: Display script usage information.
    --clean-all: Clean all files.
    --run-vm: Run the OS in a virtual machine.
    --format:img or --format:raw: Format the OS image in the specified format.
    --no-debug: Disable debug output.
    --no-reboot: Do not reboot after running (useful for debugging).

Please feel free to make an issue ticket or a pull request if you have a fix for something.
I've been trying to get the `IDT` to work but I can't. It keeps triple faulting.
Please do help if possible, thanks.

Refer to the script's help message for more details on available options.
License

AzureOS is licensed under the GNU General Public License v2.0. For more information, please refer to the license file in the source code.
