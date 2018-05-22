#ifdef _WIN32
#include <windows.h>
#include <Shlwapi.h>
bool isValidDirectory(char *path){
	return PathIsDirectory(path);
}
#elif __linux__
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>
#include <cstdio>

bool isValidDirectory(char *path){
	struct stat filestat;
	bool res = false;
	int err = stat(path, &filestat);
	if(err != 0){
		int tmp = errno;
		fprintf(stderr, "Error %d occured.\n", tmp);
	}
	if(S_ISDIR(filestat.st_mode)){
		res = true;
	}
	return res;
}
#elif __unix__
#else
#error OS not supported
#endif