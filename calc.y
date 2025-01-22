%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token ID
%left '+' '-'
%left '*' '/'

%%
expr_list: /* empty */                { /* Do nothing for an empty input */ }
         | expr_list expr '\n'       { printf("Result: %d\n", $$); }
         ;
expr: expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr {
        if ($3 == 0) {
            yyerror("Division by zero");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
      }
    | ID { $$ = $1; }
    ;
%%

int main() {
    printf("Enter expressions, press Enter to evaluate, Ctrl+C to quit:\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

