%{
	int yyparse() ;
	int check_type() ;
	#include <stdio.h>
	#include <string.h>
	#include "main.tab.h"
	extern int yylval ;
	int nl_count = 1 ;
%}

NUM [0-9]
EXP [eE][+-]?{NUM}
REAL {NUM}"."{NUM}?{EXP}?
ALPHA [A-Z_]

%%

[\t]+
[" "]+
"\n"	{nl_count++ ;}

"void main()"	{return MAIN ;}

{NUM}+			{ yylval = atoi(yytext) ; return NUM ;}
[a-z]			{ yylval = *yytext - 'a' ; return VAR ; }


"break"			{ return BREAK ; }
"case"			{ return CASE ; }
"char"			{ return CHAR ; }
"continue"		{ return CONTINUE ; }
"default"		{ return DEFAULT ; }
"double"		{ return DOUBLE ; }
"else"			{ return ELSE ; }
"float"			{ return FLOAT ; }
"for"			{ return FOR ; }
"if"			{ return IF ; }
"int"			{ return INT ; }
"return"		{ return RETURN ; }
"switch"		{ return SWITCH ; }
"void"			{ return VOID ; }
"while"			{ return WHILE ; }

"&&"			{  return AND_OP ; }
"||"			{  return OR_OP ; }
"<="			{  return LE_OP ; }
">="			{  return GE_OP ; }
"=="			{  return EQ_OP ; }
"!="			{  return NE_OP ; }
"++"			{  return INC_OP ; }
"--"			{  return DEC_OP ; }

[-+/*<>!=,();{}] {yylval = yytext[0] ; return *yytext ;}
.   {printf("\nSyntax error at line %d\n",nl_count);}


%%

int main()
{
	//printf("\nCompiled Successful ! ");
    yyin = freopen("input.txt","r",stdin) ;
    yyout = freopen("output.txt","w",stdout) ;
	yyparse();
	return 0;
}

void yyerror (char const *s)
{
	fprintf (stderr, "\n %s at line no %d\n", s,nl_count);
}

int yywrap()
{
	return 1;
}

int check_type(void)
{

    if(strcmp(yytext,"break")==0)
    {
        return BREAK ;
    }
	else if(strcmp(yytext,"case")==0)
	{
		return CASE ;
	}
	else if(strcmp(yytext,"char")==0)
    {
        return CHAR ;
    }
	else if(strcmp(yytext,"continue")==0)
    {
        return CONTINUE ;
    }
	else if(strcmp(yytext,"default")==0)
    {
        return DEFAULT ;
    }
	else if(strcmp(yytext,"else")==0)
    {
        return ELSE ;
    }
	else if(strcmp(yytext,"float")==0)
    {
        return FLOAT ;
    }
	else if(strcmp(yytext,"for")==0)
    {
        return FOR ;
    }
	else if(strcmp(yytext,"if")==0)
    {
        return IF ;
    }
	else if(strcmp(yytext,"else if")==0)
    {
        return ELIF ;
    }
	else if(strcmp(yytext,"int")==0)
    {
        return INT ;
    }
	else if(strcmp(yytext,"return")==0)
    {
        return RETURN ;
    }
	else if(strcmp(yytext,"switch")==0)
    {
        return SWITCH ;
    }
	else if(strcmp(yytext,"void")==0)
    {
        return VOID ;
    }
	else if(strcmp(yytext,"while")==0)
    {
        return WHILE ;
    }
}
