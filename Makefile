CC=gcc
SRC=$(wildcard *.c)
TST=$(patsubst %.c, %.o, $(wildcard test*.c))
OBJ=$(filter-out $(TST), $(patsubst %.c, %.o, $(SRC)))
TSTOBJ=$(patsubst %.o, __%.o, $(OBJ))
BIN=testmain

test: $(BIN)

$(BIN): weak_symbols $(TSTOBJ) $(TST)
	$(CC) $(TSTOBJ) $(TST) -o $(BIN)
	@rm weak_symbols
	@rm $(TSTOBJ)

$(TSTOBJ): __%.o: %.o
	objcopy $< --weaken-symbols=weak_symbols $@

$(TST): %.o: %.c
	$(CC) -c $<

$(OBJ): %.o: %.c
	$(CC) -c $<

weak_symbols: $(SRC)
	@for f in `ls test*.c`; do \
	  awk -F'(' '/@weaken/{getline; print $$1}' $$f | awk '{ print $$2 }' >> weak_symbols;\
	done
