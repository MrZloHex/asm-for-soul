ASMC = nasm
ASM_FLAGS = -felf64 -g

SRC = boobs.asm

LL = ld

TARGET = boobs

all: clean build run

build: $(TARGET)

$(TARGET): $(TARGET).o
	$(LL) $^ -o $(TARGET)

$(TARGET).o: $(SRC)
	$(ASMC) $^ $(ASM_FLAGS) -o $(TARGET).o


run:
	./$(TARGET)


clean:
	-rm -f $(TARGET)
	-rm -f $(TARGET).o



