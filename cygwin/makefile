#******************************************************************************
#* Created: 14 January 2003
#* Author:  Daniel Joseph Pezely <Pez@play.org>
#*
#******************************************************************************

BASEFILENAME := constant_simple

CDEFS := $(CDEFS)
CINCS := $(CINCS) -I/usr/include/Xm -IUI -I$(XSISDK_ROOT)/include -I. -I/usr/include


CC    := gcc
CPP   := g++
OPTIMIZED ?= -O3
CDEFS     := $(CDEFS) -DEX_OK=X_OK -DXMSTRINGDEFINES
COPTS     := $(COPTS) $(OPTIMIZED) -mno-cygwin 
CPPOPTS   := $(CPPOPTS) $(OPTIMIZED) -fpermissive -mno-cygwin 
LDFLAGS   := -mno-cygwin


CFLAGS    := $(CINCS) $(CDEFS) $(COPTS)
CPPFLAGS  := $(CINCS) $(CDEFS) $(CPPOPTS)
LDFLAGS   := -L$(SI_HOME)/Application/bin -L$(XSISDK_ROOT)/lib/nt-x86 $(LDFLAGS)
DEPLIBS   := -lm -lshader

SOURCEFILES = \
   $(BASEFILENAME).cpp \
   $(END_OF_LIST)

CPPOBJS   := $(patsubst %.cpp, objs/%.o, $(filter %.cpp,$(SOURCEFILES)))
COBJS     := $(patsubst %.c, objs/%.o, $(filter %.c,$(SOURCEFILES)))
OBJS      := $(CPPOBJS) $(COBJS)

HFILES = \
   $(BASEFILENAME).h \
   $(END_OF_LIST)

.phony: depend all

all:		bin run/$(BASEFILENAME).dll $(BASEFILENAME).spdl

ifeq "$(NODEP)" ""
   include makefile.dep
endif


depend:	makefile.dep

makefile.dep: $(SOURCEFILES) $(HFILES)
	@-rm -f $@; touch $@
	@echo Building $@

$(CPPOBJS): objs/%.o: %.cpp
	@-if [ ! -d "$(dir $@)" ]; then mkdir -p "$(dir $@)"; fi
	$(CPP) -c $(CPPFLAGS) $< -o $@

$(COBJS): objs/%.o: %.c
	@-if [ ! -d "$(dir $@)" ]; then mkdir -p "$(dir $@)"; fi
	$(CC) -c $(CFLAGS) $< -o $@

bin:	$(CPPOBJS) $(COBJS) 
	@-if [ ! -d "$(dir $@)" ]; then mkdir -p "$(dir $@)"; fi

run/$(BASEFILENAME).dll: run/%.dll: objs/%.o $(BASEFILENAME).spdl
	@-if [ ! -d "$(dir $@)" ]; then mkdir -p "$(dir $@)";fi
	$(CC) $(LDFLAGS) -shared -o $(BASEFILENAME).dll \
	-Wl,--out-implib=$(BASEFILENAME).dll.a \
	-Wl,--export-all-symbols \
	-Wl,--enable-auto-import \
	-Wl,--whole-archive objs/$(BASEFILENAME).o \
	-Wl,--no-whole-archive $(DEPLIBS) 
	@echo $@ is up to date

clean:
	@-rm -f *~ core *.dep $(BIN)
	@-rm -rf objs
	@-rm -rf run
	@echo Project cleaned

install: all
	@echo "Please wait while XSI loads in batch mode..."
	$(XSI_BINDIR)/XSI.exe -i $(BASEFILENAME).spdl

uninstall:
	@echo "Removing SPDL file for $(BASEFILENAME)"
	@echo "Please wait while XSI loads in batch mode..."
	$(XSI_BINDIR)/XSI.exe -u $(BASEFILENAME).spdl

