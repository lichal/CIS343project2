%{
	#include <stdio.h>
	#include "zoomjoystrong.h"

	int yylex();
	int yyerror(const char *s);
	int check_colors(int r, int g, int b);
	int check_radius(int x, int y, int r);
%}

%start program

%union
{
	char* str;
	int val;
	float fval;
}

%token			ERRORLINE
%token			ERROR
%token			END
%token			END_STATEMENT
%token <str>	POINT
%token <str>	LINE
%token <str>	CIRCLE
%token <str>	RECTANGLE
%token <str>	SET_COLOR
%token <val>	INT
%token <fval>	FLOAT

%%

program: statement_list END END_STATEMENT { printf("EXIT! THANK YOU FOR USING THE PROGRAM!\n"); exit(0); finish(); }

statement_list: 	statement
            	|	statement statement_list
            	;


statement:		point
			|	line
			|	circle
			|	rectangle
			|	set_color
			|	error END_STATEMENT
			;


point:		POINT
			INT
			INT
			END_STATEMENT
			{ printf("POINT: %d %d\n", $2, $3); point($2, $3); }	
			;

line:		LINE
			INT
			INT
			INT
			INT
			END_STATEMENT
			{ printf("LINE: %d %d %d %d\n", $2, $3, $4, $5); line($2, $3, $4, $5); }
			;

circle:		CIRCLE
			INT
			INT
			INT
			END_STATEMENT
			{ check_radius($2, $3, $4); }
			;

rectangle:		RECTANGLE
				INT
				INT
				INT
				INT
				END_STATEMENT
				{ rectangle($2, $3, $4, $5); }
				;

set_color:	SET_COLOR
			INT
			INT
			INT
			END_STATEMENT
			{ check_colors($2, $3, $4); }
			;

%%

/**********************************************************************
 * This is the main function calls the setup and yyparse
 *********************************************************************/
int main() {
	setup();
	yyparse();
	return 0;
}

/**********************************************************************
 * yyerror, checks for yy error
 *********************************************************************/
int yyerror(const char* s) {
	fprintf(stderr, "INVALID SYNTAX! STUPIF!\n");
	yyparse();
	return 0;
}

/**********************************************************************
 * This function checks if the color user input is within the valid 
 * range.
 *********************************************************************/
int check_colors(int r, int g, int b) {
	if (r >= 0 && r <= 255 && g >= 0 && g <= 255 && b >= 0 && b <= 255) {
		set_color(r, g, b);
	} else {
		printf("INVALID COLOR RANGE!\n");
	}
	return 0;
}

/**********************************************************************
 * This function checks if the radius is not negative
 *********************************************************************/
int check_radius(int x, int y, int r) {
	if(r > 0) {
		circle(x, y, r);	
	}else {
		printf("NEGATIVE RADIUS? REALLY?\n");
	}
	return 0;
}






