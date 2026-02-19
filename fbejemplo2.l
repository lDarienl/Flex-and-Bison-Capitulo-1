%{
#include <stdio.h>
%}

%option noyywrap

%%
"dog"      { printf("perro"); }
"cat"      { printf("gato"); }
"computer" { printf("computador"); }
"bird"     { printf("pajaro"); }
\n         { printf("\n"); }
. { printf("%s", yytext); }
%%

int main (void) {
    yylex();
    return 0;
}
