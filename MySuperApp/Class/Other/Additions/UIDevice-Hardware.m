#import "UIDevice-hardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <Foundation/Foundation.h>
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "NSStringAdditions.h"


@implementation UIDevice (Hardware)

/*
 Platforms
 iPhone1,1 -> iPhone 1G
 iPhone1,2 -> iPhone 3G
 iPhone2,1 -> iPhone 3GS
 iPhone3,1 -> iPhone 4G 
 iPod1,1   -> iPod touch 1G 
 iPod2,1   -> iPod touch 2G 
 iPad1,1   -> iPad 1G
 i386	   -> iPhone/iPad Simulator
 */

-(BOOL)TTIsPad {
#ifdef __IPHONE_3_2
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
#else
    return NO;
#endif
}

- (NSString *) platform
{
	size_t size;
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	char* machine = (char*)malloc(size);
	sysctlbyname("hw.machine", machine, &size, NULL, 0);

	NSString *platform = [[NSString alloc] initWithCString:machine encoding:NSUTF8StringEncoding];
	free(machine);
	return platform;
}

- (NSString *)platformString
{
	NSString *platform = [self platform];
	if ([platform isEqualToString:@"iPhone1,1"]) return IPHONE_1G_NAMESTRING;
	if ([platform isEqualToString:@"iPhone1,2"]) return IPHONE_3G_NAMESTRING;
	if ([platform isEqualToString:@"iPhone2,1"]) return IPHONE_3GS_NAMESTRING;
	if ([platform isEqualToString:@"iPhone3,1"]) return IPHONE_4G_NAMESTRING;
	if ([platform isEqualToString:@"iPod1,1"])   return IPOD_1G_NAMESTRING;
	if ([platform isEqualToString:@"iPod2,1"])   return IPOD_2G_NAMESTRING;
	if ([platform isEqualToString:@"iPad1,1"])   return IPAD_1G_NAMESTRING;
	if ([platform isEqualToString:@"i386"]) {
		if([self performSelector:@selector(TTIsPad)])
			return IPAD_SIMULATOR_NAMESTRING;
		else
			return IPHONE_SIMULATOR_NAMESTRING;
	}
	return NULL;
}

- (BOOL)hasMicrophone {
	NSString *platform = [self platform];
	if ([platform isEqualToString:@"iPhone1,1"]) return YES;
	if ([platform isEqualToString:@"iPhone1,2"]) return YES;
	if ([platform isEqualToString:@"iPhone2,1"]) return YES;
	if ([platform isEqualToString:@"iPhone3,1"]) return YES;
	if ([platform isEqualToString:@"iPod1,1"])   return NO;
	if ([platform isEqualToString:@"iPod2,1"])   return NO;
	if ([platform isEqualToString:@"iPad1,1"])   return NO;
	
	return NO;
}


- (NSString *) macaddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        NSLog(@"Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", 
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}


- (NSString *) uniqueGlobalDeviceIdentifier{
    NSString *macaddress = [[UIDevice currentDevice] macaddress];
    NSString *uniqueIdentifier = [macaddress md5Hash];
    
    return uniqueIdentifier;
}

@end




@implementation UIDevice (Resolutions)

/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 获取当前分辨率
 
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (UIDeviceResolution) currentResolution {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            result = CGSizeMake(result.width * [UIScreen mainScreen].scale, result.height * [UIScreen mainScreen].scale);
            if (result.height <= 480.0f)
                return UIDevice_iPhoneStandardRes;
            return (result.height > 960 ? UIDevice_iPhoneTallerHiRes : UIDevice_iPhoneHiRes);
        } else
            return UIDevice_iPhoneStandardRes;
    } else
        return (([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) ? UIDevice_iPadHiRes : UIDevice_iPadStandardRes);
}

/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 当前是否运行在iPhone5端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone5{
    if ([self currentResolution] == UIDevice_iPhoneTallerHiRes) {
        return YES;
    }
    return NO;
}

/******************************************************************************
 函数名称 : + (BOOL)isRunningOniPhone
 函数描述 : 当前是否运行在iPhone端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

@end


