YKHttpRequest 简化封装了ASIHttpRequest

1) Add the files
2) Link against CFNetwork, SystemConfiguration, MobileCoreServices, CoreGraphics and zlib

使用YKHttpRequest #import "YKHttpRequest.h"

 示例：
	1.同步方式，不要在主线程使用 NSString* html=[YKHttpRequest loadUrl:@"http://www.google.com" params:nil];
	2.异步 [YKHttpRequest startLoadUrl:@"http://www.google.com" delegate:****     params:nil];


－－－
asihttp lib homepage : http://allseeing-i.com/ASIHTTPRequest