%{
  #include "y.tab.h"
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  extern yy_size_t yyleng;
%}

%option noyywrap

%%


"\""						{ return QUOTE; }
"int start(){"				{ return INIT; }
"print"						{ return PRINT; }
";"							{ return SEMICOLON; }
"{"							{ return OPEN_CURLY_BRACKET; }
"}"							{ return CLOSE_CURLY_BRACKET; }
"#"							{ return HASHTAG; }
"<"							{ return OPEN_ANGLE_BRACKET; }
">"							{ return CLOSE_ANGLE_BRACKET; }
"("							{ return OPEN_PARENTHESES; }
")"							{ return CLOSE_PARENTHESES; }
"+"							{ return ADD; }
"-"							{ return SUBSTRACT; }

"int"						{ return INTEGER_TYPE;}
"double"					{ return DOUBLE_TYPE;}
"string"					{ return STRING_TYPE;}

[0-9]+.[0-9]+				{ return DOUBLE; }
[0-9]+						{ yylval.integer = atoi(yytext) ; return INTEGER; }

[a-zA-Z]([a-zA-Z0-9_])*		{ 	yylval.string = malloc(yyleng+1);
								strcpy(yylval.string,yytext);
								return VARIABLE; }
\"[^\"]*\"					{ 	yylval.string = malloc(yyleng+1);
								strcpy(yylval.string,yytext);
								return STRING; }

\/\*([^\*\/])*\*\/			;

[ \t]						;
\n							{ yylineno++; }


%%