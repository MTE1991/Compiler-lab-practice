%{
#include "fact.tab.h"
%}

%%
[0-9]+(\.[0-9]+)? {
    yylval = atoi(yytext);
    return INTEGER;
}
"(" { return '('; }
")" { return ')'; }
"factorial" { return FACTORIAL; }
[ \t] { /* Ignore whitespace */ }
\n { return '\n'; }
. { printf("Unknown char: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}
