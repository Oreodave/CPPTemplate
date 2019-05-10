# critical variables
PROJ_NAME = main
TARGET = dist/$(PROJ_NAME)
FILETYPE = .exe

# compiler options
CC = g++
LCC = clang++
UFLAGS = -I src/includes #-shared # Universal flags
DFLAGS = -Og -g -Wall $(UFLAGS) # debug flags
RFLAGS = -O3 -Wall $(UFLAGS) # release flags

# folder/file options
SRC = src
OBJ = obj
SOURCES := $(wildcard $(SRC)/*.cpp)
OBJECTS := $(patsubst $(SRC)/%.cpp, $(OBJ)/%.o, $(SOURCES))
DOBJECTS := $(patsubst $(SRC)/%.cpp, $(OBJ)/%-gcc.o, $(SOURCES))
LOBJECTS := $(patsubst $(SRC)/%.cpp, $(OBJ)/%-clang.o, $(SOURCES))

# build recipes
default: $(TARGET)-clang # default
release: $(TARGET) # release
gcc: $(TARGET)-gcc
all: $(TARGET)-gcc $(TARGET)-clang $(TARGET)

# test recipes
debug:
	gdb $(TARGET)-clang.exe


clean:
	find . -maxdepth 2 -type f \
		-name *.o -delete -or \
		-name *.d -delete -or \
		-name *$(FILETYPE) -delete

$(TARGET): $(OBJECTS)
	$(CC) $(RFLAGS) $^ -o $@$(FILETYPE)

$(OBJ)/%.o: $(SRC)/%.cpp
	$(CC) $(RFLAGS) -MMD -c $^ -o $@

$(TARGET)-gcc: $(DOBJECTS)
	$(CC) $(DFLAGS) $^ -o $@$(FILETYPE)

$(OBJ)/%-gcc.o: $(SRC)/%.cpp
	$(CC) $(DFLAGS) -MMD -c $^ -o $@

$(TARGET)-clang: $(LOBJECTS)
	$(LCC) $(DFLAGS) $^ -o $@$(FILETYPE)

$(OBJ)/%-clang.o: $(SRC)/%.cpp
	$(LCC) $(DFLAGS) -MMD -c $^ -o $@
