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

all: dir $(BUILD_DIR)/dnn_face_recognition

dir: $(BUILD_DIR)
	$(MKDIR_P) $(BUILD_DIR)

dlib.o: /usr/lib/dlib-19.12/dlib/all/source.cpp
	g++ -std=c++11 -O3 -I/usr/lib/dlib-19.12 -lpthread -lX11 -DDLIB_JPEG_SUPPORT -I/usr/lib/libjpeg -l:libjpeg.a /usr/lib/dlib-19.12/dlib/all/source.cpp -c -o dlib.o

$(BUILD_DIR)/%.o: %.cpp
	$(CC) $(CFLAGS) $(DLIB) -c -o $@ $<

$(BUILD_DIR)/dnn_face_recognition: $(OBJ_FILES)
	$(LD) -o $@ $^ $(LDFLAGS)
clean:
	rm $(BUILD_DIR)/*
