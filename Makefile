CFLAGS = -I/usr/local/include/mnolth
CFLAGS += -O3
CFLAGS += -Wall -pedantic -std=c89
LIBS += -lmnolth -ljack -lx264 -lm -lpthread

OBJ = rt.o server.o client.o

default: mnort libmnort.a

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

mnort: mnort.o $(OBJ)
	$(CC) $(CFLAGS) $^ -o $@ $(LIBS)

libmnort.a: $(OBJ)
	@echo "Building libmnort"
	@$(AR) rcs $@ $^

clean:
	$(RM) mnort libmnort.a
	$(RM) $(OBJ)

install: mnort libmnort.a
	cp mnort /usr/local/bin
	cp libmnort.a /usr/local/lib
	cp rt.scm /usr/local/share/mnolth/scm
