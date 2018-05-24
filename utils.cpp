#include <string>

// Pasted from:
// https://stackoverflow.com/questions/874134/find-if-string-ends-with-another-string-in-c
bool hasEnding (std::string const &fullString, std::string const &ending) {
	if (fullString.length() >= ending.length()) {
		return (0 == fullString.compare (fullString.length() - ending.length(), ending.length(), ending));
	} else {
		return false;
	}
}

#ifdef _WIN32
#include <windows.h>
#include <Shlwapi.h>
bool isValidDirectory(const char *path){
	return PathIsDirectory(path);
}
void fillFilenameVector(const char *dir, std::vector<std::string> &files){
	// reference: https://msdn.microsoft.com/en-us/library/aa365200(VS.85).aspx
}
int makefolder(const char *path){
	return -1;
}
void copyfile(const char *src, const char *dst){
	
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

bool isValidDirectory(const char *path){
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

void fillFilenameVector(const char *dir, std::vector<std::string> &files){
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

int makefolder(const char *path)
{
	Stat st;
	int status = 0;

	if (stat(path, &st) != 0)
	{
		/* Directory does not exist. EEXIST for race condition */
		if (mkdir(path, S_IRWXU | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH) != 0 && errno != EEXIST)	// mode 755
			status = -1;
	}
	else if (!S_ISDIR(st.st_mode))
	{
		errno = ENOTDIR;
		status = -1;
	}

	return(status);
}
#elif __unix__
#else
#error OS not supported
#endif