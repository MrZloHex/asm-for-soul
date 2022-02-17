ASMC = nasm
ASM_FLAGS = -felf64 -g

SRC = boobs.asm

LL = ld

TARGET = boobs

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
	./$(TARGET)


clean:
	-rm -f $(TARGET)
	-rm -f *.o



