%{
#include "fbejercicio3.tab.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
%}

%option noyywrap

%%
"//".*                  { /* ignore comment */ }

"abs"                   { return ABSF; }
"("                     { return LPAREN; }
")"                     { return RPAREN; }

"0x"[0-9a-fA-F]+         { yylval = (int)strtol(yytext, NULL, 16); return NUMBER; }
[0-9]+                   { yylval = (int)strtol(yytext, NULL, 10); return NUMBER; }

"+"                      { return ADD; }
"-"                      { return SUB; }
"*"                      { return MUL; }
"/"                      { return DIV; }
"|"                      { return BOR; }

\n                       { return EOL; }
[ \t]+                   { /* ignore whitespace */ }

.                        { printf("Mystery character %s\n", yytext); }
%%
