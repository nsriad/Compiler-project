%{
    #include <stdio.h>
    #include <math.h>
    #define YYSTYPE int
    int sym[26] ;
    void yyerror(char const *s);
    int yylex() ;
%}

%token NUM VAR MAIN
%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%token INC_OP DEC_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP
%token CHAR INT FLOAT DOUBLE VOID ELIF
%token CASE DEFAULT IF ELSE SWITCH WHILE FOR CONTINUE BREAK RETURN TYPE_NAME


%nonassoc IFX
%nonassoc ELSE
%left '<' '>' '=' GE_OP LE_OP EQ_OP NE_OP INC_OP DEC_OP
%left '+' '-'
%left '*' '/'

%start program

%%


program:
	| statement MAIN '{' statement '}'	{printf("In main funtion\n");}
       ;


statement :
    |';' statement
	|expression ';' statement   { printf("\nValue of expression: %d\n",$1);}
    |var_declaration statement
    |conditional_statement statement
    |loop_statement statement
	;

var_declaration:VAR '=' expression      { sym[$1] = $3 ;
            printf("Value of variable: %d\t\n",$3);}
    |VAR INC_OP     { $1 = $1+1 ;}
    |VAR DEC_OP     { $1 = $1-1 ;}
    ;

conditional_statement:IF '(' expression ')' '{' statement '}'	{if($3) printf("In if: %d\n",$6);
                         else printf("Condition false\n");}
    |IF '(' expression ')' '{' statement '}' ELSE '{' statement '}' 	{if($3 != 0) printf("In if: %d\n",$6);
                         else printf("In else: %d\n",$10);}
    ;

loop_statement:BREAK
    |CONTINUE
    |FOR '(' var_declaration ';' expression ';' var_declaration ')' '{' statement '}'    {if($5) printf("in for\n") ;}
    |WHILE '(' expression ')' '{' statement '}'	{if($3) printf("In while: %d\n",$6);
                             else printf("Condition false\n");}
    ;

expression : NUM	{$$ = $1 ;}
	| VAR	{$$ = sym[$1] ;}
	| expression '+' expression 	{$$ = $1 + $3 ;}
	| expression '-' expression 	{$$ = $1 - $3 ;}
	| expression '*' expression 	{$$ = $1 * $3 ;}
	| expression '/' expression 	{ if($3) $$ = $1 / $3 ;
					  else { $$ = 0 ; printf("\nDivision by zero error!\n") ;} }
	| expression '<' expression 	{$$ = $1 < $3 ;}
	| expression '>' expression 	{$$ = $1 > $3 ;}
    | expression LE_OP expression 	{$$ = $1 <= $3 ;}
    | expression GE_OP expression 	{$$ = $1 >= $3 ;}
    | expression EQ_OP expression 	{$$ = $1 <= $3 ;}
    | expression NE_OP expression 	{$$ = $1 <= $3 ;}
	| '(' expression ')'	{$$ = $2 ;}
     ;


%%
