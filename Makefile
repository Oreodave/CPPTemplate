# critical variables
PROJ_NAME = main
TARGET = dist/$(PROJ_NAME)
FILETYPE = .exe

# compiler options
CC = gcc
LCC = clang
DFLAGS = -Og -g -Wall # debug flags
RFLAGS = -O3 -Wall # release flags

# folder/file options
SRC = src
OBJ = obj
SOURCES := $(wildcard $(SRC)/*.c)
OBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%.o, $(SOURCES))
DOBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%-gcc.o, $(SOURCES))
LOBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%-clang.o, $(SOURCES))

# build recipes
default: $(TARGET)-clang # default
release: $(TARGET) # release
gcc: $(TARGET)-gcc
all: $(TARGET)-gcc $(TARGET)-clang $(TARGET)

# test recipes
test:
	gdb $(TARGET)-clang.exe


clean:
	find . -maxdepth 2 -type f \
		-name *.o -delete -or \
		-name *.d -delete -or \
		-name *$(FILETYPE) -delete

$(TARGET): $(OBJECTS)
	$(CC) $(RFLAGS) $^ -o $@$(FILETYPE)

$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(RFLAGS) -MMD -c $^ -o $@

$(TARGET)-gcc: $(DOBJECTS)
	$(CC) $(DFLAGS) $^ -o $@$(FILETYPE)

$(OBJ)/%-gcc.o: $(SRC)/%.c
	$(CC) $(DFLAGS) -MMD -c $^ -o $@

$(TARGET)-clang: $(LOBJECTS)
	$(LCC) $(DFLAGS) $^ -o $@$(FILETYPE)

$(OBJ)/%-clang.o: $(SRC)/%.c
	$(LCC) $(DFLAGS) -MMD -c $^ -o $@
