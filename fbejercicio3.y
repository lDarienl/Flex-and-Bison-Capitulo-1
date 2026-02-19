/* calculator with hex/dec + OR, and abs() function */
%{
#include <stdio.h>
%}

%token NUMBER
%token ADD SUB MUL DIV
%token BOR          /* binary OR: | */
%token ABSF         /* abs function name */
%token LPAREN RPAREN
%token EOL

%define api.value.type {int}

%%

calclist:
      /* empty */
    | calclist EOL
    | calclist exp EOL   { printf("= %d (0x%X)\n", $2, (unsigned)$2); }
    ;

exp:
      or_exp
    ;

or_exp:
      add_exp
    | or_exp BOR add_exp { $$ = $1 | $3; }   /* bitwise OR */
    ;

add_exp:
      mul_exp
    | add_exp ADD mul_exp { $$ = $1 + $3; }
    | add_exp SUB mul_exp { $$ = $1 - $3; }
    ;

mul_exp:
      term
    | mul_exp MUL term { $$ = $1 * $3; }
    | mul_exp DIV term { $$ = $1 / $3; }
    ;

term:
      NUMBER
    | ABSF LPAREN exp RPAREN { $$ = $3 >= 0 ? $3 : -$3; }
    | LPAREN exp RPAREN      { $$ = $2; }
    ;

%%

int yyerror(char *s)
{
    fprintf(stderr, "error: %s\n", s);
    return 0;
}

int main(int argc, char **argv)
{
    return yyparse();
}
