%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
extern int yylex();
extern int yylineno;
%}
%token FUNCTION, TYPE_BOOL, TYPE_STRING, TYPE_VOID, MAIN
%token TYPE_INT, TYPE_CHAR, TYPE_REAL, TYPE_P_INT, TYPE_P_CHAR, TYPE_P_REAL
%token EOS, ID, IF, ELSE, WHILE, FOR, DO, VAR, RETURN, TRUE, FALSE, NULL
%token AND, OR, EQUALIVATION, NOTEQUAL, PLUSONE, MINUSONE, BIGGER_EQ, SMALLER_EQ, BIGGER, SMALLER, DIVIDED, EQUAL, PLUS, MINUS, MULTIPLY
%token NOT, ADDRESS_OF, SCB, ECB, LP, RP, COMMA, BSI, ESI, LENGTH
%token CHAR_lowercase, CHAR_uppercase, CHAR, INVALID_STRING, STRING, EMPTY_STRING, DEC_INT, HEX_INT, REAL
%left ESI COMMA RP ECB
%left EQUALIVATION SMALLER_EQ BIGGER_EQ BIGGER SMALLER NOTEQUAL
%left PLUS MINUS
%left MULTIPLY DIVIDED
%left AND OR 
%left EQUAL
%right NOT ADDRESS_OF LP SCB BSI 
%nonassoc IF ELSE FOR DO WHILE FUNCTION ID
%start main_program
%%

main_program:	code {printf("finished code!!!!!!!\n");}
				|main_func {printf("finished program: code MAIN\n");}

main_func:		FUNCTION TYPE_VOID MAIN LP parameter_list RP code_block

code: 			function {printf("code comments function\n");}
				|void_function {printf("code comments void_function\n");}
				|


				

void_function:	FUNCTION TYPE_VOID id LP parameter_list RP void_code_block code
				

id:				ID

function:		FUNCTION type id LP parameter_list RP code_block code

void_code_block: 	SCB var_dec body ECB//SCB var_dec body ECB {printf("block:SCB body ECB\n");}

code_block:			SCB var_dec body return ECB


//body_block:		var_dec body


args:			id COMMA args 	{printf("args:ID COMMA args\n");}
				|id			{printf("args:ID\n");}

			
parameter_list:	type args EOS parameter_list
				|type args
				|{}

exp:		exp BIGGER exp {printf("exp:exp BIGGER exp\n");}
			|exp BIGGER_EQ exp {printf("exp:exp BIGGER_EQ exp\n");}
			|exp SMALLER exp {printf("exp:exp SMALLER exp\n");}
			|exp SMALLER_EQ exp {printf("exp:exp SMALLER_EQ exp\n");}
			|exp EQUALIVATION exp {printf("exp:exp EQUALIVATION exp\n");}
			|assignment_statment {printf("exp:exp EQUAL exp\n");}
			|exp NOTEQUAL exp {printf("exp:exp NOTEQUAL exp\n");}
 			|exp PLUS exp {printf("exp:exp PLUS exp\n");}
			|exp MINUS exp {printf("exp:exp MINUS exp\n");}
			|exp MULTIPLY exp {printf("exp:exp MULTIPLY exp\n");}
			|exp DIVIDED exp {printf("exp:exp DIVIDED exp\n");}
			|exp AND exp {printf("exp:exp AND exp\n");}
			|exp OR exp {printf("exp:exp OR exp\n");}
			|NOT exp {printf("exp:NOT exp\n");}
			|LP exp RP {printf("exp:LP exp RP\n");}
			|literal {printf("exp: literal \n");}
			|pointer_id {printf("exp: pointer_id \n");}
			|ADDRESS_OF exp {printf("exp:ADDRESS_OF exp\n");}


/* */

pointer_id:	MULTIPLY exp {printf("exp:MULTIPLY exp\n");}


literal:	number
			|id {printf("literal:id\n");}
			|bool {printf("literal:bool\n");}
			|char {printf("literal:char\n");}
			|string {printf("literal:STRING\n");}
			|null	{printf("literal:NULL\n");}
			|string_length
			|literal BSI exp ESI//---------------------------




null:		NULL


int:		DEC_INT
			|HEX_INT

real:		REAL
bool:		TRUE {printf("bool:TRUE\n");}

			|FALSE {printf("bool:FALSE\n");}

char:		CHAR_uppercase {printf("char:CHAR_uppercase\n");}
			|CHAR_lowercase {printf("char:CHAR_lowercase\n");}
			|CHAR {printf("char:CHAR\n");}


number:			int {printf("number:DEC_INT\n");}
				|real{printf("number:HEX_INT\n");}
				

string_length:	LENGTH string LENGTH
				|LENGTH id LENGTH

var_dec:		var_dec premitive_dec {printf("var_dec:var_dec premitive_dec\n");}
				|var_dec string_dec {printf("var_dec:var_dec string_dec\n");}
				|{printf("var_dec: epsilon\n");}

premitive_dec:	VAR type premitive_assign_op EOS {printf("premitive_dec:VAR type premitive_assign_op EOS");}


string_dec:		TYPE_STRING string_assign_op EOS {printf("string_dec:TYPE_STRING string_assign_op EOS\n");}

string_assign_op:		id BSI exp ESI {printf("string_assign_op:ID BSI exp ESI \n");}
						|string_assign_op COMMA id BSI exp ESI {printf("string_assign_op:ID BSI exp ESI COMMA string_assign_op \n");}
						|string  EQUAL id BSI exp ESI  {printf("string_assign_op:ID BSI exp ESI EQUAL string \n");}
						|string_assign_op COMMA id BSI exp ESI EQUAL string   {printf("string_assign_op:ID BSI exp ESI EQUAL string COMMA string_assign_op \n");}
				

premitive_assign_op:	id {printf("premitive_assign_op:ID\n");}
						|id COMMA premitive_assign_op {printf("premitive_assign_op:ID COMMApremitive_assign_op \n");}
						|id EQUAL exp {printf("premitive_assign_op:ID EQUAL exp \n");}
						|id EQUAL exp COMMA premitive_assign_op {printf("premitive_assign_op:ID EQUAL exp COMMA premitive_assign_op \n");}


string:			STRING {printf("string:STRING\n");}
				|EMPTY_STRING {printf("string:EMPTY_STRING\n");}





type:			TYPE_INT 	{printf("(TYPE__INT)\n");}
				|TYPE_CHAR 	{printf("(TYPE__CHAR)\n")}
				|TYPE_REAL 	{printf("(TYPE__REAL)\n");}
				|TYPE_BOOL		{printf("(TYPE__BOOL)\n");}
				|TYPE_P_INT		{printf("(TYPE__INT*)\n");}
				|TYPE_P_CHAR	{printf("(TYPE__char*)\n");}
				|TYPE_P_REAL	{printf("(TYPE__REAL*)\n");}





return:		RETURN literal EOS


assignment_statment:	exp EQUAL exp EOS


body:			body body_ {printf("block:SCB body ECB\n");}
				|body exp_list 
				| {printf("block:SCB body ECB\n");} 

body_:		ifelse {printf("body_:ifelse\n")}
			|loop {printf("body_:loop\n")}
			|function {printf("body_:function\n")}
			|void_function {printf("body_:void_function\n")}
			|function_call {printf("body_:function_call\n")}
			|void_code_block
			
			//|exp EQUAL exp
			//|assignment_statment
			//|var_dec
			//| {printf("block:SCB body ECB");}

function_call:	id LP RP {printf("function_call:ID LP RP \n");}
				|id LP exp_list RP {printf("function_call:ID LP exp_list RP \n");}

exp_list:		exp {printf("exp_list:exp\n");}
				|exp_list COMMA exp {printf("exp_list:exp_list COMMA exp\n");}


ifelse:			IF LP exp RP body_  {printf("if:IF LP exp RP SCB body ECB \n");}
				|IF LP exp RP body_ ELSE body_ //{printf("if:ELSE SCB body ECB\n");}
			//|IF LP exp RP body {printf("if:IF LP exp RP body\n");}
			//|ELSE body_ {printf("if:ELSE body\n");}

loop:		WHILE LP exp RP SCB body ECB {printf("i'm while loop\n");}
			|for_loop {printf("loop: for_loop\n");}
			|DO code_block WHILE LP exp RP EOS {printf("loop:DO SCB body ECB WHILE LP exp RP EOS\n");}

for_loop:	FOR LP loop_i_dec EOS exp EOS inc_dec RP SCB body ECB

inc_dec:	id PLUSONE {printf("i++\n");}
			|PLUSONE id {printf("++i\n");}
			|id MINUSONE {printf("i--\n");}
			|MINUSONE id {printf("--i\n");}

loop_i_dec: number id EQUAL DEC_INT {printf("loop_i_dec: INT ID EQUAL DEC_INT\n");}
			|id EQUAL DEC_INT {printf("loop_i_dec:ID EQUAL DEC_INT\n");}
			|id {printf("loop_i_dec: ID\n");}

%%

#include "lex.yy.c"
int main() {return yyparse();}

int yyerror(){
 	fflush(stdout);
 	fprintf(stderr, "\n\n------------------------------------------------------\nError located in line: %d\n", yylineno);
	fprintf(stderr, "The parser can not accept: \" %s \" .\n",yytext);
	return 0;
}


int yywrap(){
	return 1;
}
