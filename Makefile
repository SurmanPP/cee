iCC = gcc
BIN_DIR = $(DEST)/usr/bin
INCLUDE_DIR = ./include
HEADER_NAME = cee.h
BUILD_DIR = ./build
CFLAGS = -O3 -I$(INCLUDE_DIR)
DIR = example
OBJECT = e.c
NAME = e
VFLAGS = -prod
VDIR = ./ceefy
VNAME = ceefy

$(INCLUDE_DIR)/$(HEADER_NAME): tmpl.cefy $(BUILD_DIR)/$(VNAME)
	$(BUILD_DIR)/$(VNAME) -o $(INCLUDE_DIR)/$(HEADER_NAME) tmpl.cefy

$(BUILD_DIR)/$(VNAME): $(BUILD_DIR)-dir
	v $(VFLAGS) -o $(BUILD_DIR)/$(VNAME) $(VDIR)

$(BUILD_DIR)/$(NAME): $(INCLUDE_DIR)/$(HEADER_NAME)
	$(CC) $(CFLAGS) -o $(BUILD_DIR)/$(NAME) $(DIR)/$(OBJECT)

$(BUILD_DIR)-dir:
	mkdir -p $(BUILD_DIR)

example: $(BUILD_DIR)/$(NAME)
	$(BUILD_DIR)/$(NAME)

clean:
	rm -fdr $(BUILD_DIR)

build: $(BUILD_DIR)/$(NAME)

install: build
	install -m 755 $(BUILD_DIR)/* $(BIN_DIR)/

all: clean install example
