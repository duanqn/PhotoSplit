#ifdef _WIN32
#include <windows.h>
#include <Shlwapi.h>
bool isValidDirectory(char *path){
	return PathIsDirectory(path);
}
void fillFilenameVector(char *dir, std::vector<std::string> &files){
}
#elif __linux__
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <errno.h>
#include <dirent.h>
#include <cstdio>
#include <vector>
#include <string>

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

void fillFilenameVector(char *dir, std::vector<std::string> &files){
	if(!isValidDirectory(dir)){
		return;
	}
	DIR *p = opendir(dir);
	struct dirent *filep;
	if(p == NULL){
		return;
	}

	while((filep = readdir(p)) != NULL){
		files.push_back(std::string(filep->d_name));
	}

	closedir(p);
}
#elif __unix__
#else
#error OS not supported
#endif