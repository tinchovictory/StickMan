%{
	#include "grammar.h"
	#include <stdio.h>
	#include <stdlib.h>
	extern void yyerror(char *);	
	extern int yytext();

%}

%token SEMICOLON
%token OPEN_CURLY_BRACKET
%token CLOSE_CURLY_BRACKET
%token HASHTAG
%token OPEN_PARENTHESES
%token CLOSE_PARENTHESES
%token OPEN_ANGLE_BRACKET
%token CLOSE_ANGLE_BRACKET
%token ADD
%token SUBSTRACT
%token INTEGER
%token DOUBLE
%token VARIABLE
%token STRING
%token INTEGER_TYPE
%token DOUBLE_TYPE
%token STRING_TYPE

%start Start
%%

Start : Function																								{ printf("/*  Starting... */"); }
Function : Type Name OPEN_PARENTHESES CLOSE_PARENTHESES OPEN_CURLY_BRACKET Sentence CLOSE_CURLY_BRACKET			{ ; }
Name : VARIABLE																									{ ; }
Type : INTEGER_TYPE 																							{ $$= yytext(); }
Type : DOUBLE_TYPE																								{ $$= yytext(); }
Type : STRING_TYPE																								{ $$= yytext(); }
Sentence : Assignment SEMICOLON Sentence																		{ ; }
Sentence : Declaration SEMICOLON Sentence																		{ ; }
Sentence : Expression SEMICOLON Sentence																		{ ; }
Sentence : Expression SEMICOLON 																				{ ; }
Sentence : Assignment SEMICOLON 																				{ ; }
Sentence : Declaration SEMICOLON 																				{ ; }
Sentence : Return SEMICOLON 																					{ ; }
Assignment : VARIABLE '=' Expression																			{ update( $1 , $3 ) ; } 
Declaration : Type VARIABLE '=' Expression																		{ /*add( $1 , $2 , $4 ) ;*/ }
Expression : Expression Operator Expression																		{ $$ = $1 + $3 ; }
Expression : Value																								{ $$ = $1 ; }
Expression : VARIABLE																							{ $$ = getValue($1) ; }
Operator : ADD																									{ ; }
Operator : SUBSTRACT																							{ ; }
Operator : OPEN_ANGLE_BRACKET																					{ ; }
Operator : CLOSE_ANGLE_BRACKET																					{ ; }
Value : INTEGER																									{ $$ = atoi(yytext()); }
Value : DOUBLE																									{ ; }
Value : STRING																									{ $$= yytext(); }
Return : "return" Expression																					{ printf("%d\n", $2 ); return 0; }




%%

void yyerror (char *s) {
	fprintf(stderr, "%s\n", s);
}
