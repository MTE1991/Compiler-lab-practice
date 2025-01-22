%{
#include "power.tab.h"
%}

%%
[0-9]+(\.[0-9]+)? {
    yylval.fval = atof(yytext);
    return FLOAT;
}
"," { return ','; }
"(" { return '('; }
")" { return ')'; }
"power" { return POWER; }
[ \t] { /* Ignore whitespaces and tabs */ }
\n { return '\n'; }
. { printf("Invalid char: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}