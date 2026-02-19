%{
#include <stdio.h>
%}

%option noyywrap

%%
"+"     { return ADD; }
"-"     { return SUB; }
"*"     { return TIMES; }
"/"     { return DIVIDE; }
"|"     { return ABS; }
[0-9]+  { yylval = atoi(yytext); return NUMBER; }
\n      { return NEWLINE; }
[ \t]+  { /* ignore whitespace */ }
.       { printf("Mystery character %s\n", yytext); }
%%
