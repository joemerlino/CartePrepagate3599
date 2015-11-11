#include <sys/stat.h>
#include <unistd.h>
%hook NSFileManager
- (BOOL)fileExistsAtPath:(NSString *)path{
	if(path && ([path rangeOfString:@"//var/log"].location != NSNotFound || [path rangeOfString:@"//System"].location != NSNotFound || [path rangeOfString:@"//Systetem"].location != NSNotFound || [path rangeOfString:@"/private"].location != NSNotFound || [path rangeOfString:@"/Applications/"].location != NSNotFound || [path rangeOfString:@"/CartePrepagate3599.app/01_jailbreak@2x.png"].location != NSNotFound || [path rangeOfString:@"/CartePrepagate3599.app/01_jailbreak.png"].location != NSNotFound || [path rangeOfString:@"/usr/"].location != NSNotFound || [path rangeOfString:@"//Library/"].location != NSNotFound || [path rangeOfString:@"//bin/"].location != NSNotFound || [path rangeOfString:@"//etc/"].location != NSNotFound))
		return NO;
	else return %orig;
}
- (BOOL)fileExistsAtPath:(NSString *)path
             isDirectory:(BOOL *)isDirectory{
             	if([path rangeOfString:@"//etc/"].location != NSNotFound || [path rangeOfString:@"//var/"].location != NSNotFound || [path rangeOfString:@"/usr/"].location != NSNotFound || [path rangeOfString:@"/private/"].location != NSNotFound)
					return NO;
             	else return %orig;
}
%end
%hook SegnalazioneClass
- (void)inviaSegnalazioneClasse:(id)fp8 riga:(int)fp12 codErrore:(id)fp16 descrizioneErrore:(id)fp20{
	NSLog(@"[jessica] segnalazione %@ %d %@ %@", fp8, fp12, fp16, fp20);
	%orig;
}
%end
%hookf(pid_t, fork, void) {
    return -1;
}
%hookf(int, lstat, char * path, struct stat * buf) {
    return 0;
}