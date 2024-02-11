AC = nasm
CFLAGS = -felf64

LD = ld

TARGET = damut

INC_LIB = print string convert math display

LIB_DIR = ../lib


all: clean compile run

run:
	./$(TARGET)

compile: $(TARGET)

$(TARGET).o: $(TARGET).asm
	$(AC) $(CFLAGS) $(TARGET).asm -o $(TARGET).o

$(TARGET): $(TARGET).o libs 
	$(LD) $(wildcard *.o) -o $(TARGET)

libs:
	$(foreach lib, $(INC_LIB), $(AC) $(CFLAGS) $(LIB_DIR)/$(lib).asm -o $(lib).o;)

clean:
	-rm $(TARGET)
	-rm *.o
