%{
#include "fbejemplo5.tab.h"
#include <stdlib.h>
#include <stdio.h>
%}

%option noyywrap

%%
"0x"[0-9a-fA-F]+   { yylval = (int)strtol(yytext, NULL, 16); return NUMBER; }

"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return MUL; }
"/"     { return DIV; }
"|"     { return ABS; }
[0-9]+  { yylval = atoi(yytext); return NUMBER; }
\n      { return EOL; }
[ \t]+  { /* ignore whitespace */ }
"//".*      { /* ignore comment */ }
.       { printf("Mystery character %s\n", yytext); }
%%
