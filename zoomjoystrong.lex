%{
	#include <stdio.h>
	#include "zoomjoystrong.tab.h"
%}

%option noyywrap

%%

end					{ return END; }
;					{ return END_STATEMENT; }
point				{ yylval.str = yytext; return POINT; }
line				{ yylval.str = yytext; return LINE; }
circle				{ yylval.str = yytext; return CIRCLE; }
rectangle			{ yylval.str = yytext; return RECTANGLE; }
set_color			{ yylval.str = yytext; return SET_COLOR; }
\-?[0-9]+     		{ yylval.val = atoi(yytext); return INT; }
[0-9]\.[0-9]+		{ yylval.fval = atoi(yytext); return FLOAT; }
[ \n\t]				{ }
.					{;}

%%

