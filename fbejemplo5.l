%{
#include "fbejemplo5.tab.h"
#include <stdlib.h>
#include <stdio.h>
%}

%option noyywrap

%%
"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return MUL; }
"/"     { return DIV; }
"|"     { return ABS; }
[0-9]+  { yylval = atoi(yytext); return NUMBER; }
\n      { return EOL; }
[ \t]+  { /* ignore whitespace */ }
.       { printf("Mystery character %s\n", yytext); }
%%
