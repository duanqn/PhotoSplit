all: dnn_face_recognition

dlib.o: /usr/lib/dlib-19.12/dlib/all/source.cpp
	g++ -std=c++11 -O3 -I/usr/lib/dlib-19.12 -lpthread -lX11 -DDLIB_JPEG_SUPPORT -I/usr/lib/libjpeg -l:libjpeg.a /usr/lib/dlib-19.12/dlib/all/source.cpp -c -o dlib.o

dnn_face_recognition.o: dnn_face_recognition_ex.cpp
	g++ -std=c++11 -O3 -I/usr/lib/dlib-19.12 -lpthread -lX11 -DDLIB_JPEG_SUPPORT -l:libjpeg.a ./dnn_face_recognition_ex.cpp -c -o dnn_face_recognition.o

dnn_face_recognition: dnn_face_recognition.o dlib.o
	g++ dlib.o -lpthread -l:libjpeg.a -lX11 dnn_face_recognition.o -o build/dnn_face_recognition
clean:
	rm *.o
	rm dnn_face_recognition
