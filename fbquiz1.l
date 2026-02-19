/* Quiz1 Identificador de numeros Complejos */
%{
#include <stdio.h>

int acepta = 0;
int error = 0;
%}

%option noyywrap

REAL [+-]?([0-9]+(\.[0-9]*)?|\.[0-9]+)([eE][+-]?[0-9]+)?

IMAG [iIjJ]

%%

{REAL}[ \t]*[+-][ \t]*{REAL}[ \t]*{IMAG} {
    if (!error) acepta = 1;
}

{REAL}[ \t]*{IMAG} {
    if (!error) acepta = 1;
}

[ \t\n\r]+    { /* ignorar */ }

.    {
    error = 1;
    acepta = 0;
}

<<EOF>> {
    return 0;
}

%%

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Uso: %s archivo.txt\n", argv[0]);
        return 1;
    }

    FILE *f = fopen(argv[1], "r");
    if (!f) {
        fprintf(stderr, "Error: no se pudo abrir %s\n", argv[1]);
        return 1;
    }

    yyin = f;
    yylex();
    fclose(f);

    if (acepta && !error) {
        printf("ACEPTA\n");
    } else {
        printf("NO ACEPTA\n");
    }

    return 0;
}
