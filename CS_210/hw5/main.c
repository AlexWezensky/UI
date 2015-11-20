/*
 * this version, migrated from your HW#1, might need further adaptation
 * in order to work with a Bison parser.
 */
#include "ucode.tab.h"
#include <stdio.h>
#include <stdlib.h>
extern FILE *yyin;
extern char *yytext;
char *yyfilename;
int main(int argc, char *argv[])
{
   int i;
   if (argc < 2) { printf("usage: ucod file.dat\n"); exit(-1); }
   yyin = fopen(argv[1],"r");
   if (yyin == NULL) { printf("can't open/read '%s'\n", argv[1]); exit(-1); }
   yyfilename = argv[1];
   if ((i=yyparse()) != 0) {
      printf("parse failed\n");
      }
   else printf("no errors\n");
   return 0;
}
