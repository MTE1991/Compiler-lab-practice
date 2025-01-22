%{
#include "trig.tab.h"
%}

%%
[0-9]+(\.[0-9]+)? {
    yylval.fval = atof(yytext);  // Use yylval.float for float values
    return FLOAT;
}
"(" { return '('; }
")" { return ')'; }
"sin" { return SIN; }
"cos" { return COS; }
"tan" { return TAN; }
[ \t] { /* Ignore whitespace */ }
\n { return '\n'; }
. { printf("Unknown char: %s\n", yytext); }
%%

int yywrap() { return 1; }
