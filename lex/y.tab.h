/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    NUMBER = 258,
    IDENT = 259,
    RETURN = 260,
    FUNCTION = 261,
    SEMICOLON = 262,
    BEGIN_PARAMS = 263,
    END_PARAMS = 264,
    BEGIN_LOCALS = 265,
    END_LOCALS = 266,
    BEGIN_BODY = 267,
    END_BODY = 268,
    BEGINLOOP = 269,
    ENDLOOP = 270,
    COLON = 271,
    INTEGER = 272,
    COMMA = 273,
    ARRAY = 274,
    L_SQUARE_BRACKET = 275,
    R_SQUARE_BRACKET = 276,
    L_PAREN = 277,
    R_PAREN = 278,
    IF = 279,
    ELSE = 280,
    THEN = 281,
    CONTINUE = 282,
    ENDIF = 283,
    OF = 284,
    READ = 285,
    WRITE = 286,
    DO = 287,
    WHILE = 288,
    FOR = 289,
    TRUE = 290,
    FALSE = 291,
    ASSIGN = 292,
    EQ = 293,
    NEQ = 294,
    LT = 295,
    LTE = 296,
    GT = 297,
    GTE = 298,
    ADD = 299,
    SUB = 300,
    MULT = 301,
    DIV = 302,
    MOD = 303,
    AND = 304,
    OR = 305,
    NOT = 306
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 8 "mini_l.y" /* yacc.c:1909  */

  int val;
  char*	 ident;

#line 111 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
