%{
    #include <stdio.h>
    #include <math.h>
    #define YYSTYPE int
    int sym[52] ;
    int idx = 26 ;
    void yyerror(char const *s);
    int yylex() ;
%}


%token NUM VAR MAIN OUT FUNC
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
	| statement MAIN '{' statement '}' function    { //sym[40] = $$ ; printf("Output: %d\n",sym[40]) ;
                                                    }
    ;


statement :
    |';' statement
	|expression ';' statement   { //printf("\nValue of expression: %d\n",$1);
                                }
    |var_declaration statement
    |conditional_statement statement
    |loop_statement statement
    |FUNC'('')' statement       {// printf("Func Output : %d\n",sym[49]) ;
                                }
	;

var_declaration:VAR '=' expression      { sym[$1] = $3 ; sym[49] = $3 ;
            //printf("Value of variable: %d\t\n",$3);
            }
    |TYPE var_declaration
    |var_declaration',' var_declaration
    |OUT expression      { printf("Output : %d\n",$2) ;}
    |expression
    |VAR INC_OP     { $1 = sym[idx]+1 ;}
    |VAR DEC_OP     { $1 = sym[idx]-1 ;}
    ;

TYPE:INT
    |FLOAT
    |DOUBLE
    |VOID
    |CHAR
    ;

conditional_statement:IF '(' expression ')' '{' statement '}'	{if($3) $$ = $6;}
    |IF '(' expression ')' '{' statement '}' ELSE '{' statement '}' 	{
                            if($3) { $$ = $6;}
                            else { $$ = $10;} }
    ;

loop_statement:BREAK
    |CONTINUE
    |FOR '(' var_declaration ';' expression ';' var_declaration ')' '{' statement '}'    {
                                                if($5)
                                                {
                                                    for(int i=sym[49] ; i<sym[50] ; i++ )
                                                    {
                                                        printf("in for : %d\n",i) ;
                                                    }
                                                }
                                            }
    |WHILE '(' expression ')' '{' statement '}'	{
                                                    if($3)
                                                    {
                                                        for(int i=sym[49] ; i<sym[50] ; i++ )
                                                        {
                                                            printf("in while : %d\n",i) ;
                                                        }
                                                    }
                                                }
    ;

expression : NUM	{$$ = $1 ; sym[50] = $1 ; }
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


function:
	|func function
	;

func: TYPE FUNC '('')' '{' statement '}'
			{
				sym[49] = $6 ;
			}
            ;

%%
