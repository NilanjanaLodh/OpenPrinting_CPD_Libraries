#include <stdio.h>
#include <CPDFrontend.h>

int main(int argc, char **argv)
{
    if (argc != 2)
    {
        printf("Usage : %s filepath_to_print\n", argv[0]);
        exit(EXIT_SUCCESS);
    }
    PrinterObj *p = resurrect_printer_from_file("/tmp/.printer-pickle");
    if (p == NULL)
    {
        printf("No serialized printer found. "
               "You must first 'pickle' a printer using the "
               "'pickle-printer' command inside print_frontend\n");
        exit(EXIT_FAILURE);
    }
    print_file(p, argv[1]);
}