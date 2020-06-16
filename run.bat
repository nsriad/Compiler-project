bison -d draft.y
flex draft.l
gcc draft.tab.c lex.yy.c -o app
app