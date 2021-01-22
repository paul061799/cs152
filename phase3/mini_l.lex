%{
	#include "mini_l.tab.h"
	int currPos = 0, currLine = 1;
%}

DIGIT		[0-9]
COMMENT		##.*
VARIABLE	[a-zA-Z]+[a-zA-Z_0-9]*
BADVARUSCORE	[a-zA-Z_]+[a-zA-Z_0-9]*_
BADVARNUMSTART	[0-9]+[a-zA-Z_]+[a-zA-Z_0-9]*
BADVARUSTART	_[a-zA-Z_0-9]*

%%

"function"	{return FUNCTION; currPos += yyleng;}

"beginparams"  	{return BEGIN_PARAMS; currPos += yyleng;}

"endparams"    	{return END_PARAMS; currPos += yyleng;}

"beginlocals"  	{return BEGIN_LOCALS; currPos += yyleng;}

"endlocals"	{return END_LOCALS; currPos += yyleng;}

"beginbody"	{return BEGIN_BODY; currPos += yyleng;}

"endbody"	{return END_BODY; currPos += yyleng;}

"integer"      	{return INTEGER; currPos += yyleng;}

"array"        	{return ARRAY; currPos += yyleng;}

"of"		{return OF; currPos += yyleng;}

"if"		{return IF; currPos += yyleng;}

"then" 		{return THEN; currPos += yyleng;}

"endif"		{return ENDIF; currPos += yyleng;}

"else" 		{return ELSE; currPos += yyleng;}

"while"		{return WHILE; currPos += yyleng;}

"do"		{return DO; currPos += yyleng;}

"for"		{return FOR; currPos += yyleng;}

"beginloop"	{return BEGINLOOP; currPos += yyleng;}

"endloop"	{return ENDLOOP; currPos += yyleng;}

"continue"	{return CONTINUE; currPos += yyleng;}

"read"		{return READ; currPos += yyleng;}

"write"		{return WRITE; currPos += yyleng;}

"and"		{return AND; currPos += yyleng;}

"or" 		{return OR; currPos += yyleng;}

"not"		{return NOT; currPos += yyleng;}

"true"		{return TRUE; currPos += yyleng;}

"false"		{return FALSE; currPos += yyleng;}

"return" 	{return RETURN; currPos += yyleng;}

"+"		{return ADD; currPos += yyleng;}

"-"		{return SUB; currPos += yyleng;}

"*"		{return MULT; currPos += yyleng;}

"/"		{return DIV; currPos += yyleng;}

"%"		{return MOD; currPos += yyleng;}

"=="		{return EQ; currPos += yyleng;}

"<>"		{return NEQ; currPos += yyleng;}

"<"		{return LT; currPos += yyleng;}

">"		{return GT; currPos += yyleng;}

"<="		{return LTE; currPos += yyleng;}

">="		{return GTE; currPos += yyleng;}

";"	       	{return SEMICOLON; currPos += yyleng;}

":"	       	{return COLON; currPos += yyleng;}

","	       	{return COMMA; currPos += yyleng;}

"["	       	{return L_SQUARE_BRACKET; currPos += yyleng;}

"]"	       	{return R_SQUARE_BRACKET; currPos += yyleng;}

"("		{return L_PAREN; currPos += yyleng;}

")"		{return R_PAREN; currPos += yyleng;}

":="		{return ASSIGN; currPos += yyleng;}

[ \t]+		{currPos += yyleng;} //spaces get ignored

"\n"		{currLine++; currPos = 0;}

{COMMENT}	{currLine++; currPos = 0;}

{DIGIT}+        {yylval.val = atoi(yytext); return NUMBER; currPos += yyleng;}

{BADVARUSCORE}	{printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", currLine, currPos, yytext); exit(0);}

{BADVARNUMSTART}	{printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", currLine, currPos, yytext); exit(0);}

{BADVARUSTART}	{printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", currLine, currPos, yytext); exit(0);}

{VARIABLE}+	{yylval.ident = yytext; return IDENT; currPos += yyleng;}

.		{printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext), exit(0);}

%%


int main(int argc, char** argv){
	//yylex();
	yyparse();

	return 0;
}
