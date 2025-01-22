%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
void yyerror(const char* s);
int yylex();
%}

%union {
    float fval;
}

%token EXP 
%token <fval> FLOAT;
%type <fval> expr;

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
    | EXP '(' expr ')' { $$ = exp($3); }
    | FLOAT { $$ = $1; }
    ;
%%

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", yyerror);
}

int main() {
    printf("Enter a value for exp(val)\n");
    while (1) {
        printf(">> ");
        yyparse();
    }
    return 0;
}