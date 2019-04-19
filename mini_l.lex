%{
  int currLine = 1, curPos = 1;
%}

digit [0-9]
integer {digit}+
alpha [a-z]|[A-Z]
ident ({alpha})|{alpha}[0-9a-zA-Z_]*[a-zA-Z0-9]+
invalStart [0-9_]{ident}
invalEnd {ident}(_)+
comment ##.*

%%

"function"  {printf("FUNCTION \n"); curPos += yyleng;}

"beginparams"  {printf("BEGIN_PARAMS \n"); curPos += yyleng;}

"endparams"  {printf("END_PARAMS \n"); curPos += yyleng;}

"beginlocals"  {printf("BEGIN_LOCALS \n"); curPos += yyleng;}

"endlocals"  {printf("END_LOCALS \n"); curPos += yyleng;}

"beginbody"  {printf("BEGIN_BODY \n"); curPos += yyleng;}

"endbody"  {printf("END_BODY \n"); curPos += yyleng;}

"integer" {printf("INTEGER \n"); curPos += yyleng;} 

"array"  {printf("ARRAY \n"); curPos += yyleng;}

"of" {printf("OF \n"); curPos += yyleng;}

"if"  {printf("IF \n"); curPos += yyleng;}

"then"  {printf("THEN \n"); curPos += yyleng;}

"endif"  {printf("ENDIF \n"); curPos += yyleng;}

"else" {printf("ELSE \n"); curPos += yyleng;}

"while"  {printf("WHILE \n"); curPos += yyleng;}

"do"  {printf("DO \n"); curPos += yyleng;}

"beginloop"  {printf("BEGINLOOP \n"); curPos += yyleng;}

"endloop" {printf("ENDLOOP \n"); curPos += yyleng;}

"continue"  {printf("CONTINUE \n"); curPos += yyleng;}

"read"  {printf("READ \n"); curPos += yyleng;}

"write"  {printf("WRITE \n"); curPos += yyleng;}

"and"  {printf("AND \n"); curPos += yyleng;}

"or"  {printf("OP \n"); curPos += yyleng;}

"not" {printf("NOT \n"); curPos += yyleng;}

"true"  {printf("TRUE \n"); curPos += yyleng;}

"false"  {printf("FALSE \n"); curPos += yyleng;}

"return"  {printf("RETURN \n"); curPos += yyleng;}

"-"  {printf("SUB \n"); curPos += yyleng;}

"+"  {printf("ADD \n"); curPos += yyleng;}

"*"  {printf("MULT \n"); curPos += yyleng;}
 
"/"  {printf("DIV \n"); curPos += yyleng;}

"%"  {printf("MOD \n"); curPos += yyleng;}

"=="  {printf("EQ \n"); curPos += yyleng;}

"<>"  {printf("NEQ \n"); curPos += yyleng;}

"<" {printf("LT \n"); curPos += yyleng;}

">"  {printf("GT \n"); curPos += yyleng;}

"<="  {printf("LTE \n"); curPos += yyleng;}

">="  {printf("GTE \n"); curPos += yyleng;}

";"  {printf("SEMICOLON \n"); curPos += yyleng;}
 
":"  {printf("COLON \n"); curPos += yyleng;}

","  {printf("COMMA \n"); curPos += yyleng;}

"\("  {printf("L_PAREN \n"); curPos += yyleng;}
 
"\)"  {printf("R_PAREN \n"); curPos += yyleng;}

"["  {printf("L_SQUARE_BRACKET \n"); curPos += yyleng;}

"]"  {printf("R_SQUARE_BRACKET \n"); curPos += yyleng;}

":="  {printf("ASSIGN \n"); curPos += yyleng;}

{integer}  {printf("NUMBER %.*s \n", yyleng, yytext); curPos += yyleng;}

{ident}  {printf("IDENT %.*s \n", yyleng, yytext); curPos += yyleng;}

[ ]+|[\t]+ {curPos += yyleng;}

{comment}|"\n" {currLine ++; curPos = 1;}


{invalStart} {curPos += yyleng; printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter \n", currLine, curPos, yytext); exit(0);}

{invalEnd}  {curPos += yyleng; printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore \n", currLine, curPos, yytext); exit(0);}


.  {curPos += yyleng; printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, curPos, yytext); exit(0);}

%%

int main(int argc, char ** argv) {

  yylex();
}

