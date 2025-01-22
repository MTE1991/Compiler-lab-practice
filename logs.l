%{
#include "logs.tab.h"
%}

%%
[0-9]+(\.[0-9]+)? {
    yylval.fval = atof(yytext);
    return FLOAT;
}
"(" { return '('; }
")" { return ')'; }
"log" { return LOG; }
"log2" { return LOG2; }
"log10" { return LOG10; }
[ \t] { /* Ignore whitespace and tabs */}
\n { return '\n'; }
. { printf("Unknown char: %s\n", yytext); }
%%

int yywrap() { return 1; }