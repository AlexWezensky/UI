#
# Ucode makefile
# Adapted from Generic Bison Template Makefile
#    ...by Dr. J
#
# Replace the macro definition below with this semester's application.
APP=ucode
CFLAGS=-c -g

$(APP): main.o lex.yy.o $(APP).tab.o
	cc -o $(APP) main.o lex.yy.o $(APP).tab.o

main.o: main.c $(APP).tab.h
	cc $(CFLAGS) main.c

lex.yy.o: lex.yy.c
	cc $(CFLAGS) lex.yy.c

lex.yy.c: $(APP).l $(APP).tab.h
	flex $(APP).l

$(APP).tab.o: $(APP).tab.c
	cc $(CFLAGS) $(APP).tab.c

$(APP).tab.c: $(APP).y
	bison $(APP).y

$(APP).tab.h: $(APP).y
	bison -d $(APP).y

clean:
	rm -f *.o ucode core ucode.tab.* lex.yy.c
