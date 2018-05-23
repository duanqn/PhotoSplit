The purpose of this project is to pack each person's photo into a seperate folder.

## Motivation
After a trip, you probably have hundreds of photos at your hands.\
These photos include the ones you took for your friends, and of course you want to give them their photos.\
However, picking someone's photos out can be very time-consuming.\
That is why I want to develop this tool for myself and for you, to save our time and spend it on something more meaningful :)

## Environment & Dependency
So far the development and testing has been done on Ubuntu Linux.\
Porting it to Windows may be a bit difficult, but you are welcome to fork this repo and give it a try!\
No matter whether you succeed or not, your efforts will be appreciated by all of us.

This program uses the following libraries
* dlib    v19.12
* libjpeg
* pthread
* X11

Make sure you have all of them installed on your computer before you compile this program.\
You may need to change the configuration in ./Makefile to use your local libraries.

## DLIB Models
There are two pre-trained models which I downloaded from [davisking/dlib-models](https://github.com/davisking/dlib-models).\
You need to have these models in order to run the PhotoSplit program.\
So for your convenience, I have added them in this repo and you can download them as you run 'git clone'.
