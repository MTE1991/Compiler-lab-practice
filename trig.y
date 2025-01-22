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

%token <fval> FLOAT
%token SIN COS TAN
%type <fval> expr

%%
input:
    input_line
    | input input_line
    ;

input_line:
    expr '\n' { printf("Result = %f\n", $1); }  // Use %f for float results
    | '\n'
    ;

expr:
    '(' expr ')' { $$ = $2; }
    | SIN '(' expr ')' { $$ = sin($3 * M_PI / 180); }
    | COS '(' expr ')' { $$ = cos($3 * M_PI / 180); }
    | TAN '(' expr ')' { $$ = tan($3 * M_PI / 180); }
    | FLOAT { $$ = $1; }
    ;
%%

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter angle values in this format:\nsin(theta)\ncos(theta)\ntan(theta)\n");
    while (1) {
        printf(">> ");
        yyparse();
    }
    return 0;
}

