DLIB_INC = -I/usr/lib/dlib-19.12
DLIB_JPEG = -DDLIB_JPEG_SUPPORT
JPEGLIB = -l:libjpeg.a
PTHREAD = -lpthread
X11 = -lX11
DLIB = $(DLIB_JPEG) $(DLIB_INC)

CC = g++
CFLAGS = -std=c++11 -O3
LD = g++
LDFLAGS = $(X11) $(PTHREAD) $(JPEGLIB)

BUILD_DIR = build
MKDIR_P = mkdir -p
SRC_FILES = $(wildcard *.cpp)
OBJ_FILES := $(patsubst %.cpp,$(BUILD_DIR)/%.o,$(SRC_FILES))

.PHONY: dir

all: dir $(BUILD_DIR)/dnn_face_recognition

dir: $(BUILD_DIR)
	$(MKDIR_P) $(BUILD_DIR)

$(BUILD_DIR)/dlib.o: /usr/lib/dlib-19.12/dlib/all/source.cpp
	$(CC) $(CFLAGS) $(DLIB) -c -o $@ $<

$(BUILD_DIR)/%.o: %.cpp
	$(CC) $(CFLAGS) $(DLIB) -c -o $@ $<

$(BUILD_DIR)/dnn_face_recognition: $(OBJ_FILES) $(BUILD_DIR)/dlib.o
	$(LD) -o $@ $^ $(LDFLAGS)
clean:
	rm $(BUILD_DIR)/*
