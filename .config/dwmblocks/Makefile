PREFIX ?= /usr/local

output: dwmblocks.c blocks.def.h blocks.h
	cc `pkg-config --cflags x11` `pkg-config --libs x11` dwmblocks.c -o dwmblocks
blocks.h:
	cp blocks.def.h $@


clean:
	rm -f *.o *.gch dwmblocks
install: output
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f dwmblocks $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dwmblocks
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dwmblocks
