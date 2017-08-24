#include <stdio.h>
#include <CPDFrontend.h>

int main(int argc , char **argv)
{
    if(argc != 2)
    {
        printf("Usage : %s filepath_to_print\n", argv[0]);
        exit(EXIT_SUCCESS);
    }
    PrinterObj *p = resurrect_printer_from_file("~/.printer-pickle");
    print_file(p, argv[1]);
}