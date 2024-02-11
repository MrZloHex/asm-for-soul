ASMC = nasm
ASM_FLAGS = -felf64 -g

SRC = clever.asm

LL = ld

TARGET = clever
args = 'A&B'

INC_LIB = print string

LIB_DIR = ../lib


all: clean build run

build: $(TARGET)

$(TARGET): $(TARGET).o libs
	$(LL) $(wildcard *.o) -o $(TARGET)

$(TARGET).o:
	$(ASMC) $(ASM_FLAGS) $(SRC) -o $(TARGET).o

libs:
	$(foreach lib, $(INC_LIB), $(ASMC) $(ASM_FLAGS) $(LIB_DIR)/$(lib).asm -o $(lib).o;)

run:
	./$(TARGET) $(args)


clean:
	-rm -f $(TARGET)
	-rm -f *.o



