# Frontend and Backend Libraries for Common Print Dialog

This repository contains one of the two components of my Google Summer of Code'17 project with The Linux Foundation, i.e the **CPD libraries** for Frontend and Backend. The other component can be found [here](https://github.com/NilanjanaLodh/OpenPrinting_CUPS_Backend).

These libraries allow the CPD frontend and backends to communicate with each other over the D-Bus. 
The Frontend library also provides some extra functionality to deal with Printers, Settings, etc. in a high level manner.

## Background 

### The Problem

Printing out of desktop applications is managed by many very different dialogs, mostly depending on which GUI toolkit is used for an application. Some applications like even have their own dialogs, which expose different kind of printing options. This is confuses users a lot, having them to do the printing operation in many different ways. In addition, many dialogs are missing important features.

### The solution

The [Common Printing Dialog](https://wiki.ubuntu.com/CommonPrintingDialog) project aims to solve these problems provide a uniform printing experience on Linux Desktop Environments.

### My contributions

I specifically have contributed to the project in the following two ways :

 - Developed backend and frontend libraries which provides allows the frontend and backend to communicate to each other over the D-Bus. The frontend library also provides various abstractions for dealing with Printers , Options, etc, making it easier to develop a dialog. It is hosted in **this repository**.
 - Developed the CUPS Backend for the dialog; Available [here](https://github.com/NilanjanaLodh/OpenPrinting_CUPS_Backend).


## Dependencies

 - [CUPS](https://github.com/apple/cups/releases) : Version >= 2.2 
 
 Installing bleeding edge release from [here](https://github.com/apple/cups/releases). (Preferable!)
 
 OR

`sudo apt install cups libcups2-dev`

 - GLIB 2.0 :
`sudo apt install libglib2.0-dev`

 
## Build and installation


    $ ./autogen
    $ ./configure
    $ make
    $ sudo make install
    $ sudo ldconfig


Use the sample frontend client to check that the library and the installed backends work as expected:

## Testing the library

The project also includes a sample command line frontend that you can use to test whether the installed library and print backends work as expected.

    $ cd demo/
    $ make
    $ ./print_frontend

The list of printers from various printers should start appearing automatically. Type `help` to get the list of available commands. Make sure to stop the frontend using the `stop` command only.

The library also provides support for serializing a printer. Use the `pickle-printer` command to serialize it, and run the `pickle_test` executable after that to deserialize and test it.
    

## Using the frontend and backend libraries in your code

To develop a frontend client you need to use the CPDFrontend library.

It has pkg-config support: `pkg-config --cflags --libs CPDFrontend`.
Include `CPDFrontend.h` in your code.

Similarly, to develop a backend you need to use the CPDBackend library.
It has pkg-config support: `pkg-config --cflags --libs CPDBackend`.
Include `CPDBackend.h` in your code.



