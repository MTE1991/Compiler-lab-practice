%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int yyerror(const char* s);
int yylex();
%}

%union {
    float fval;
}

%token <fval> FLOAT
%token POWER
%type <fval> expr

%%
input:
    input_line
    | input input_line
    ;

input_line:
    expr '\n' { printf("Result = %f\n", $1); }
    | '\n'
    ;

expr:
    '(' expr ')' { $$ = $2; }
    | POWER '(' expr ',' expr ')' {
        $$ = powf($3, $5);
    }
    | FLOAT { $$ = $1; }
    ;
%%

int yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
    return 1;
}

int main() {
    printf("Enter base and exponent in this format, power(base, exponent)\n");
    while (1) {
        printf(">> ");
        yyparse();
    }
    return 0;
}