/* Bison declarations */
%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
void yyerror(const char *s);
int factorial(int n);
int yylex();
%}

/* Tokens */
%token INTEGER
%token FACTORIAL

%%

/* Grammar rules */
input:
    input_line
    | input input_line
    ;

input_line:
    expr '\n' { printf("Result: %d\n", $1); }
    | '\n'    /* Allow empty lines */
    ;

expr:
    '(' expr ')' { $$ = $2; }
    | FACTORIAL '(' expr ')' { $$ = factorial($3); }
    | INTEGER { $$ = $1; }
    ;
%%

/* Auxiliary functions */

int factorial(int n) {
    if (n < 0) {
        return -1;
    }
    int result = 1;
    for (int i = 1; i <= n; i++) {
        result *= i;
    }
    return result;
}

/* Error handling */

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

/* Main function */

int main() {
    printf("Enter an integer in this format, factorial(int) \n");
    while (1) {  // Infinite loop to continuously take input
        printf("> ");  // Prompt for input
        yyparse();     // Call the parser for each line of input
    }
    return 0;
}
