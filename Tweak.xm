#include <sys/stat.h>
#include <unistd.h>
static BOOL finish = NO;
%hook NSFileManager
- (BOOL)fileExistsAtPath:(NSString *)path{
	if(!finish && [path rangeOfString:@"/var/mobile/"].location == NSNotFound)
		return NO;
	return %orig;
}
- (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDirectory{
 	if(!finish && [path rangeOfString:@"/private/var/mobile/"].location == NSNotFound)
		return NO;
 	return %orig;
}
%end
%hook AppDelegate
- (void)applicationDidBecomeActive:(id)fp8 { 
	finish = YES;
	%orig; 
}
%end
%hookf(pid_t, fork, void) {
    return -1;
}
%hookf(int, lstat, char * path, struct stat * buf) {
	if(finish) return %orig;
    return 0;
}