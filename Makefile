CC=gcc
SRC=$(wildcard *.c)
TST=$(patsubst %.c, %.o, $(wildcard *test*.c))
OBJ=$(filter-out $(TST), $(patsubst %.c, %.o, $(SRC)))
TSTOBJ=$(patsubst %.o, __%.o, $(OBJ))
BIN=testmain

all: $(BIN)

clean:
	rm -f *.o testmain

$(BIN): weak_symbols $(TST)
#$(BIN): weak_symbols $(TSTOBJ) $(TST)
#$(CC) $(TSTOBJ) $(TST) -o $(BIN)
	@rm weak_symbols
	@rm $(TSTOBJ)

$(TSTOBJ): __%.o: %.o
	objcopy $< --weaken-symbols=weak_symbols $@

$(TST): %.o: %.c $(TSTOBJ)
	$(CC) -c $<
	$(CC) $@ $(TSTOBJ) -o $*

$(OBJ): %.o: %.c
	$(CC) -c $<

weak_symbols: $(SRC)
	@echo main > weak_symbols
	@for f in `ls *test*.c`; do \
	  awk -F'(' '/@weaken/{getline; print $$1}' $$f | awk '{ print $$2 }' >> weak_symbols;\
	done
