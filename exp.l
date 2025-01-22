%{
#include "exp.tab.h"
%}

%%
[0-9]+(\.[0-9]+)? {
    yylval.fval = atof(yytext);
    return FLOAT;
}
"(" { return '('; }
")" { return ')'; }
"exp" { return EXP; }
[ \t] { /* Ignore whitespace and tabs */ }
\n { return '\n'; }
. { printf("Unknown character: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}