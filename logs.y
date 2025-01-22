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
%token LOG10 LOG LOG2
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
    | LOG '(' expr ')' { $$ = log($3); }
    | LOG2 '(' expr ')' { $$ = log2($3); }
    | LOG10 '(' expr ')' { $$ = log10($3); }
    | FLOAT { $$ = $1; }
    ;
%%

int yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}

int main() {
    printf("Enter values in this format\nlog(val)\nlog2(val)\nlog10(val)\n");
    while (1) {
        printf(">> ");
        yyparse();
    }
    return 0;
}