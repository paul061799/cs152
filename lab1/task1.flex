%{   
   int currLine = 1, currPos = 1;
   int numCnt, pCnt, mCnt, muCnt, dCnt, lpCnt, rpCnt, eCnt;
%}

DIGIT    [0-9]
PLUS	 [+]
MINUS	 [-]
MULT	 [*]
DIV	 [/]
L_PAREN	 [(]
R_PAREN	 [)]
EQU	 [=]
DEC	 [.]
   
%%

{MINUS}            {printf("MINUS\n"); currPos += yyleng; mCnt++;}
{PLUS}             {printf("PLUS\n"); currPos += yyleng; pCnt++;}
{MULT}             {printf("MULT\n"); currPos += yyleng; muCnt++;}
{DIV}              {printf("DIV\n"); currPos += yyleng; dCnt++;}
{EQU}              {printf("EQUAL\n"); currPos += yyleng; eCnt++;}
{L_PAREN}          {printf("L_PAREN\n"); currPos += yyleng; lpCnt++;}
{R_PAREN}          {printf("R_PAREN\n"); currPos += yyleng; rpCnt++;}

{DIGIT}+       {printf("NUMBER %s\n", yytext); currPos += yyleng; numCnt++;}

[ \t]+         {/* ignore spaces */ currPos += yyleng;}

"\n"           {currLine++; currPos = 1;}

.              {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}

%%

int main(int argc, char ** argv)
{
   yylex();
   printf("Number Count: %d\n", numCnt);
   printf("Plus Count: %d\n", pCnt);
   printf("Minus Count: %d\n", mCnt);
   printf("Mult Count: %d\n", muCnt);
   printf("Div Count: %d\n", dCnt);
   printf("Operator Count: %d\n", pCnt+mCnt+muCnt+dCnt);
   printf("Left parentheses Count: %d\n", lpCnt);
   printf("Right parentheses Count: %d\n", rpCnt);
   printf("Equal Count: %d\n", eCnt);
}

