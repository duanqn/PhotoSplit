DLIB_HOME = /usr/lib/dlib-19.12
DLIB_INC = -I$(DLIB_HOME)
DLIB_JPEG = -DDLIB_JPEG_SUPPORT
JPEGLIB = -l:libjpeg.a
PTHREAD = -lpthread
X11 = -lX11
DLIB = $(DLIB_JPEG) $(DLIB_INC)

CC = g++
CFLAGS = -std=c++11 -O3
LD = g++
LDFLAGS = $(X11) $(PTHREAD) $(JPEGLIB)

BUILD_DIR = ./build
MKDIR_P = mkdir -p
SRC_FILES = $(wildcard *.cpp)
OBJ_FILES := $(patsubst %.cpp,$(BUILD_DIR)/%.o,$(SRC_FILES))

EXEC_NAME = PhotoSplit
.PHONY: dir

all: dir $(BUILD_DIR)/$(EXEC_NAME)

dir: 
	$(MKDIR_P) $(BUILD_DIR)

$(BUILD_DIR)/dlib.o: $(DLIB_HOME)/dlib/all/source.cpp
	$(CC) $(CFLAGS) $(DLIB) -c -o $@ $<

$(BUILD_DIR)/%.o: %.cpp
	$(CC) $(CFLAGS) $(DLIB) -c -o $@ $<

$(BUILD_DIR)/$(EXEC_NAME): $(OBJ_FILES) $(BUILD_DIR)/dlib.o
	$(LD) -o $@ $^ $(LDFLAGS)
clean:
	rm $(BUILD_DIR)/*
