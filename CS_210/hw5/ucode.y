%{
/*Alex Wezensky
CS 210
Dr. Jeffery
11/18/15
HW 5 Context Free Grammars and Bison*/
#define YYDEBUG 1
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *s);
extern char *yyfilename;
extern char *yytext;
extern int lineno;
//int yydebug = 1;
%}

%token CONTROL_L CAROT_L Op_Version VERSIONSTAMP Op_Uid UCODESTAMP 
%token IDENTIFIER COMMA DECCONST Op_Impl Op_Local Op_Link FILENAME Op_Global OCTCONST
%token Op_Con Op_Declend Op_Asgn Op_Bang Op_Cat Op_Compl Op_Diff Op_Div Op_Eqv Op_Inter
%token Op_Lconcat Op_Lexeq Op_Lexge Op_Lexgt Op_Lexle Op_Lexlt Op_Lexne
%token Op_Minus Op_Mod Op_Mult Op_Neg Op_Negv Op_Nonull Op_Nonnull
%token Op_Null Op_Number Op_Numeq Op_Numge Op_Numgt Op_Numle Op_Numlt
%token Op_Numne Op_Plus Op_Power Op_Random Op_Rasgn Op_Rcv Op_Rcvbk
%token Op_Refresh Op_Rswap Op_Sect Op_Snd Op_Sndbk Op_Size Op_Subsc
%token Op_Swap Op_Tabmat Op_Toby Op_Unions Op_Bscan Op_Ccase
%token Op_Coact Op_Cofail Op_Coret Op_Dup Op_Efail Op_Eret Op_Escan
%token Op_Esusp Op_Limit Op_Lsusp Op_Pfail Op_Pnull Op_Pop Op_Pret
%token Op_Psusp Op_Push1 Op_Pushn1 Op_Sdup Op_Unmark Op_Var Op_Mark0 
%token ANY LABEL Op_Error Op_Proc Op_Record Op_End
%token Op_Cset Op_Int Op_Invoke Op_Line Op_Llist Op_Real Op_Str     
%token Op_Chfail Op_Create Op_EInit Op_Goto Op_Init Op_Mark
%token Op_Field Op_Keywd Op_Synt
%token REALCONST Op_Neqv Op_RcvBk Op_SndBk Op_Value Op_Arg Op_Static
%token Op_Quit Op_FQuit Op_Tally Op_Apply Op_Acset Op_Areal Op_Astr Op_Aglobal
%token Op_Astatic Op_Agoto Op_Amark Op_Noop Op_Colm Op_Filen Op_Trace Op_Lab
%token Op_Invocable Op_Copyd Op_Trapret Op_Trapfail

%%

ucode: u2 CONTROL_L u1
     | u2 CAROT_L u1;

u2: version ucodeline records implline links globalline;

version: Op_Version VERSIONSTAMP;
ucodeline: Op_Uid UCODESTAMP;
records: | record records;
record: Op_Record IDENTIFIER COMMA DECCONST fields;
fields: field | field fields;
field: DECCONST COMMA IDENTIFIER
     | OCTCONST COMMA IDENTIFIER;
implline: Op_Impl Op_Local
        | Op_Impl Op_Error;
links: | link links;
link: Op_Link FILENAME;
globalline: Op_Global OCTCONST globals
          | Op_Global DECCONST globals;
globals: | OCTCONST COMMA OCTCONST COMMA IDENTIFIER COMMA OCTCONST globals
         | OCTCONST COMMA OCTCONST COMMA IDENTIFIER COMMA DECCONST globals
         | DECCONST COMMA OCTCONST COMMA IDENTIFIER COMMA OCTCONST globals
         | DECCONST COMMA OCTCONST COMMA IDENTIFIER COMMA DECCONST globals;

u1: procedures;
procedures: | procedure procedures;
procedure: procs localdecs Op_Declend instructions Op_End;

procs: Op_Proc IDENTIFIER;

localdecs: | localdec localdecs;
localdec: locals | cons;
locals: | local locals;
local: Op_Local OCTCONST COMMA OCTCONST COMMA IDENTIFIER
     | Op_Local DECCONST COMMA OCTCONST COMMA IDENTIFIER
     | Op_Local OCTCONST COMMA OCTCONST COMMA LABEL
     | Op_Local DECCONST COMMA OCTCONST COMMA LABEL
     | Op_Local OCTCONST COMMA OCTCONST COMMA Op_Arg
     | Op_Local DECCONST COMMA OCTCONST COMMA Op_Arg
     | Op_Local OCTCONST COMMA OCTCONST COMMA Op_Proc
     | Op_Local DECCONST COMMA OCTCONST COMMA Op_Proc;

cons: | con cons;
con: Op_Con OCTCONST COMMA OCTCONST COMMA confields
   | Op_Con DECCONST COMMA OCTCONST COMMA confields;
confields: | confield confields;
confield: OCTCONST
        | OCTCONST COMMA confields
        | DECCONST
        | DECCONST COMMA confields;

instructions: | instruction instructions;
instruction: noop | intop | labelop | syntdir;

noop: Op_Asgn | Op_Bang | Op_Cat | Op_Compl | Op_Diff | Op_Div | Op_Eqv | Op_Inter
    | Op_Lconcat | Op_Lexeq | Op_Lexge | Op_Lexgt | Op_Lexle | Op_Lexlt | Op_Lexne
    | Op_Minus | Op_Mod | Op_Mult | Op_Neg | Op_Negv | Op_Nonull | Op_Nonnull
    | Op_Null | Op_Number | Op_Numeq | Op_Numge | Op_Numgt | Op_Numle | Op_Numlt
    | Op_Numne | Op_Plus | Op_Power | Op_Random | Op_Rasgn | Op_Rcv | Op_Rcvbk
    | Op_Refresh | Op_Rswap | Op_Sect | Op_Snd | Op_Sndbk | Op_Size | Op_Subsc
    | Op_Swap | Op_Tabmat | Op_Toby | Op_Unions | Op_Bscan | Op_Ccase
    | Op_Coact | Op_Cofail | Op_Coret | Op_Dup | Op_Efail | Op_Eret | Op_Escan
    | Op_Esusp | Op_Limit | Op_Lsusp | Op_Pfail | Op_Pnull | Op_Pop | Op_Pret
    | Op_Psusp | Op_Push1 | Op_Pushn1 | Op_Sdup | Op_Unmark | Op_Mark0 | Op_Value
    | Op_Neqv;

intop: Op_Cset OCTCONST | Op_Cset DECCONST
     | Op_Int OCTCONST | Op_Int DECCONST
     | Op_Invoke OCTCONST | Op_Invoke DECCONST
     | Op_Line OCTCONST | Op_Line DECCONST
     | Op_Llist OCTCONST | Op_Llist DECCONST
     | Op_Real OCTCONST | Op_Real DECCONST
     | Op_Str OCTCONST | Op_Str DECCONST
     | Op_Colm DECCONST
     | Op_Var OCTCONST | Op_Var DECCONST;
     
labelop: Op_Chfail LABEL | Op_Create LABEL | Op_EInit LABEL | Op_Goto LABEL | Op_Init LABEL
       | Op_Lsusp LABEL | Op_Mark LABEL | Op_Lab LABEL;

syntdir: Op_Field IDENTIFIER | Op_Keywd IDENTIFIER | Op_Synt ANY | Op_Filen FILENAME
       | Op_Proc IDENTIFIER;

%%

extern FILE *yyin;

void yyerror(char *s)
{
  fprintf(stderr, "%s: %s on line %d at token '%s'\n",
	  s, yyfilename, lineno, yytext);
}
