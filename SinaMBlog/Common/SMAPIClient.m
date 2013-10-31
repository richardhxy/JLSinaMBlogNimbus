//
//  SNAPIClient.m
//  SkyNet
//
//  Created by jimneylee on 13-7-25.
//  Copyright (c) 2013年 jimneylee. All rights reserved.
//

#import "SMAPIClient.h"
#import "AFImageRequestOperation.h"

// TODO:发布前要修改
#define SinaWeiboV2ConsumerKey         @"2893625261"	// The consumer key (The client id)
#define SinaWeiboV2ConsumerSecret      @"3c74b04cd0906a69cee6abddc1335eef"	// The secret key
#define SinaWeiboV2CallbackUrl         @"null"

NSString *const kSNAPIBaseURLString = @"https://api.weibo.com/2/";

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation SMAPIClient

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (SMAPIClient*)sharedClient
{
    static SMAPIClient* _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[SMAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kSNAPIBaseURLString]];
    });
    
    return _sharedClient;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self registerHTTPOperationClass:[AFImageRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - TimeLine

///////////////////////////////////////////////////////////////////////////////////////////////////
// 公共微博某页
// !note: page -> cusor
- (NSString*)relativePathForPublicTimelineWithPageCounter:(NSInteger)pageCounter
                                             perpageCount:(NSInteger)perpageCount
{
    return [NSString stringWithFormat:@"statuses/public_timeline.json?cursor=%d&count=%d&source=%@",
            pageCounter, perpageCount, SinaWeiboV2ConsumerKey];
}
@end
