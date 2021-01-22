%{
#define YY_NO_UNPUT
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *s);
%}

%union{
  int val;
  char*	 ident;
}

%start	Program

%token  <val> NUMBER
%token  <ident> IDENT

%token  RETURN FUNCTION SEMICOLON BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY BEGINLOOP ENDLOOP
%token  COLON INTEGER COMMA ARRAY L_SQUARE_BRACKET R_SQUARE_BRACKET L_PAREN R_PAREN
%token  IF ELSE THEN CONTINUE ENDIF OF READ WRITE DO  WHILE FOR

%token  TRUE
%token  FALSE

%left  ASSIGN
%left  EQ
%left  NEQ
%left  LT
%left  LTE
%left  GT
%left  GTE
%left  ADD
%left  SUB
%left  MULT
%left  DIV
%left  MOD
%left  AND
%left  OR
%right  NOT


%% 
Program:		%empty	{ printf("Program -> epsilon\n"); }
    | Function Program  { printf("Program -> Function Program\n"); }
	;

Function:   FUNCTION Ident SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY
    { printf("Function -> FUNCTION Ident SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY\n"); }
    ;

Declarations: Declaration SEMICOLON Declarations { printf("Declarations -> Declaration SEMICOLON Declarations\n"); }  
    | %empty { printf("Declarations -> epsilon\n"); }
    ;

Declaration:Idents COLON INTEGER { printf("Declaration -> Idents COLON INTEGER\n"); }
    | Idents COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER  { printf("Declaration -> Idents COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n"); }
    ;

Ident:      IDENT { printf("Ident -> IDENT %s\n", yylval.ident); }
    ;

Idents:     Ident { printf("Idents -> Ident\n"); }
    | Ident COMMA Idents  { printf("Idents -> Ident COMMA Idents\n"); }
    ;

Statements: Statement SEMICOLON Statements { printf("Statements -> Statement SEMICOLON Statements\n"); }  
    | Statement SEMICOLON { printf("Statements -> Statement SEMICOLON\n"); }
    ;

Statement:  Var ASSIGN Expression { printf("Statement -> Var ASSIGN Expression\n"); }
    | IF Bool-Expr THEN Statements ENDIF { printf("Statement -> IF Bool-Exp THEN Statements ENDIF\n"); }
    | IF Bool-Expr THEN Statements ELSE Statements ENDIF { printf("Statement -> IF Bool-Exp THEN Statements ELSE Statements ENDIF\n"); }
    | WHILE Bool-Expr BEGINLOOP Statements ENDLOOP { printf("Statement -> WHILE Bool-Expr BEGINLOOP Statements ENDLOOP\n"); }
    | DO BEGINLOOP Statements ENDLOOP WHILE Bool-Expr { printf("Statement -> DO BEGINLOOP Statements ENDLOOP WHILE Bool-Expr\n"); }
    | FOR Var ASSIGN NUMBER SEMICOLON Bool-Expr SEMICOLON Var ASSIGN Expression BEGINLOOP Statements ENDLOOP 
      { printf("Statement -> FOR Var ASSIGN NUMBER SEMICOLON Bool-Expr SEMICOLON Var ASSIGN Expression BEGINLOOP Statements ENDLOOP\n"); }
    | READ Vars { printf("Statement -> READ Vars\n"); }
    | WRITE Vars { printf("Statement -> WRITE Vars\n"); }
    | CONTINUE { printf("Statement -> CONTINUE\n"); }
    | RETURN Expression { printf("Statement -> RETURN Expression\n"); }
    ;

Bool-Expr:  Relation-And-Expr OR Bool-Expr { printf("Bool-Expr -> Relation-And-Expr OR Bool-Expr\n"); }  
    | Relation-And-Expr { printf("Bool-Expr -> Relation-And-Expr\n"); }
    ;

Relation-And-Expr: Relation-Expr-Inv AND Relation-And-Expr { printf("Relation-And-Exprs -> Relation-Expr-Inv AND Relation-And-Expr\n"); }
    | Relation-Expr-Inv { printf("Relation-And-Exprs -> Relation-Expr-Inv\n"); }
    ;

Relation-Expr-Inv:  NOT Relation-Expr-Inv { printf("Relation-Expr-Inv -> NOT Relation-Expr-Inv\n"); }
  | Relation-Expr { printf("Relation-Expr-Inv -> Relation-Expr\n"); }

Relation-Expr:  Expression Comp Expression { printf("Relation-Expr -> Expression Comp Expression\n"); }
    | TRUE { printf("Relation-Expr -> TRUE\n"); }
    | FALSE { printf("Relation-Expr -> FALSE\n"); }
    | L_PAREN Bool-Expr R_PAREN { printf("Relation-Expr -> L_PAREN Bool-Expr R_PAREN\n"); }
    ;

Comp:       EQ { printf("Comp -> EQ\n"); }
    | NEQ { printf("Comp -> NEQ\n"); }
    | LT { printf("Comp -> LT\n"); }
    | LTE { printf("Comp -> LTE\n"); }
    | GT { printf("Comp -> GT\n"); }
    | GTE { printf("Comp -> GTE\n"); }
    ;

Expression: Multiplicative-Expr ADD Expression { printf("Expression -> Multiplicative-Expr ADD Expression\n"); }
    | Multiplicative-Expr SUB Expression { printf("Expression -> Multiplicative-Expr SUB Expression\n"); }
    | Multiplicative-Expr { printf("Expression -> Multiplicative-Expr\n"); }
    ;

Multiplicative-Expr: Term MULT Multiplicative-Expr { printf("Multiplicative-Expr -> Term MULT Multiplicative-Expr\n"); }
    | Term DIV Multiplicative-Expr { printf("Multiplicative-Expr -> Term DIV Multiplicative-Expr\n"); }
    | Term MOD Multiplicative-Expr { printf("Multiplicative-Expr -> Term MOD Multiplicative-Expr\n"); }
    | Term { printf("Multiplicative-Expr -> Term\n"); }
    ;

Term:       SUB Var { printf("Term -> SUB Var\n"); }
    | SUB NUMBER { printf("Term -> SUB NUMBER %d\n", yylval.val); }
    | SUB L_PAREN Expression R_PAREN { printf("Term -> SUB L_PAREN\n"); }
    | Var { printf("Term -> Var\n"); }
    | NUMBER { printf("Term -> NUMBER %d\n", yylval.val); }
    | L_PAREN Expression R_PAREN { printf("Term -> L_PAREN\n"); }
    | Ident L_PAREN Expressions R_PAREN { printf("Term -> Ident L_PAREN Expressions R_PAREN\n"); }
    ;

Expressions:Expression { printf("Expressions -> Expression\n"); }
    | Expression COMMA Expressions  { printf("Expressions -> Expression COMMA Expressions\n"); }
    ;

Vars:	    Var COMMA Vars { printf("Vars -> Var COMMA Vars\n"); }
    | Var { printf("Vars -> Var\n"); }
    ;

Var:        Ident { printf("Var -> Ident\n"); }
    | Ident L_SQUARE_BRACKET Expression R_SQUARE_BRACKET { printf("Var -> Ident L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n"); }
    ;
%%

void yyerror(char* s)
{
  extern int yylineno;	// defined and maintained in lex.c
  extern char *yytext;	// defined and maintained in lex.c
  
  printf("%s on line %d at symbol \"%s\"\n", s, yylineno, yytext);
  exit(1);
}
