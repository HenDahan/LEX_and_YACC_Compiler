 //this file was made by:
 //Kfir Rahamim 203426721
 //Hen Dahan 312585953 \/\*(.[ \t\n]?)*\*\/		;
 //Bar Piglanski 204590384
%{
	#include <stdio.h>
	#include <stdlib.h>
	int yyerror();
	extern int yyval, yylineno;
%}
%option yylineno
%%
\/\*[^[\*\/]*\*\/ 		; //that's my newest invention.
[ \t\n]					; //ignores tab and spaces.
";"						{return EOS;}//End Of Statement.
"function"				{return FUNCTION;}
"main"					{return MAIN;}
"void"					{return TYPE_VOID;}
"int"					{return TYPE_INT;}
"real"					{return TYPE_REAL;}
"bool"					{return TYPE_BOOL;}
"string"				{return TYPE_STRING;}
"char"					{return TYPE_CHAR;}	
"int *"|"int* "			{return TYPE_P_INT;}
"char *"|"char* "		{return TYPE_P_CHAR;}
"real *"|"real* "		{return TYPE_P_REAL;}
"if"					{return IF;}
"else"					{return ELSE;}
"while" 				{return WHILE;}
"for"					{return FOR;}
"do"					{return DO;}
"var"					{return VAR;}
"return"				{return RETURN;}
"true"					{return TRUE;}
"false"					{return FALSE;}
"null"					{return NULL;}
"&&"					{return AND;}
"||"					{return OR;}
"=="					{return EQUALIVATION;}
"!="					{return NOTEQUAL;}
"++"					{return PLUSONE;}
"--"					{return MINUSONE;}
">="					{return BIGGER_EQ;}
"<="					{return SMALLER_EQ;}
">"						{return BIGGER;}
"<"						{return SMALLER;}
"/"						{return DIVIDED;}
"="						{return EQUAL;}
"+"						{return PLUS;}
"-"						{return MINUS;}
"*"						{return MULTIPLY;}
"!"						{return NOT;}
"&"						{return ADDRESS_OF;}
"{"						{return SCB;}//Start Code Block
"}"						{return ECB;}//End Code Block
"("						{return LP;}//Left Parameter
")"						{return RP;}//Rigth Parameter
","						{return COMMA;}
"["						{return BSI;}//Begin String Index
"]"						{return ESI;}//End String Index
"|"						{return LENGTH;}//Declared Lengh Of String |s|
[a-zA-Z][a-zA-Z0-9_]*	{return ID;}
\'[a-z]\'				{return CHAR_lowercase;}//need to check.
\'[A-Z]\'				{return CHAR_uppercase;}//need to check.
\'.\'					{return CHAR;}
\"[^"]*\"				{return STRING;}
\"\"					{return EMPTY_STRING;}
[-]?[1-9][0-9]*|0		{return DEC_INT;}
(0x|0X)[0-9ABCDEF]+		{return HEX_INT;}
[+-]?([1-9][0-9]*)?\.[0-9]+([eE][+-]?[1-9][0-9]*)?|[+-]?([1-9][0-9]*)?\.[0-9]*([eE][+-]?[1-9][0-9]*)|[+-]?[1-9][0-9]*([eE][+-]?[1-9][0-9]*)|0\.0	{return REAL;}
.						{return yytext[0];}
%%

int yywrap(void) {
    return 1;
}