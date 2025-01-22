%{
#include "calc.tab.h"
#include <stdlib.h> 
%}
%%
[0-9]+          { yylval = atoi(yytext); return ID; }
[+\-*/]         { return yytext[0]; }
[ \t]+          { /* Ignore whitespace */ }
\n              { return '\n'; } // Send newline to Bison
.               { return yytext[0]; }
%%
int yywrap() {
    return 1;
}
