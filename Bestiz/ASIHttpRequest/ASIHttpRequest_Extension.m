//
//  ASIHttpRequest_JSONExtension.m
//  Nanumi
//
//  Created by Park JiHun on 11. 7. 6..
//  Copyright 2011 Matji. All rights reserved.
//

#import "ASIHttpRequest_Extension.h"

//#import "JSONKit.h"
//@implementation ASIHTTPRequest (Extension)
//@dynamic responseResultCode, responseResultTotalCount, responseResultObject, responseResultDescription;
//
//- (NSInteger)responseResultCode
//{
//    NSData *data = [self responseData];
//    NSDictionary *response = [data objectFromJSONData];
//    return [[response objectForKey:@"code"] intValue];
//}
//
//- (NSInteger)responseResultTotalCount
//{
//    NSData *data = [self responseData];
//    NSDictionary *response = [data objectFromJSONData];
//    return [[response objectForKey:@"total_count"] intValue];
//}
//
//- (NSString *)responseResultDescription
//{
//    NSData *data = [self responseData];
//    NSDictionary *response = [data objectFromJSONData];
//    return [response objectForKey:@"description"];
//}
//
//
//- (id)responseResultObject
//{
//    id result = nil;
//    NSData *data = [self responseData];
//    NSDictionary *response = [data mutableObjectFromJSONData];    
//    NSUInteger code = [[response objectForKey:@"code"] intValue];
//    
//    if (code == 200)
//        result = [response objectForKey:@"result"];
//    
//    return result;
//}
//
//
//@end


@implementation ASIFormDataRequest (Extension)

- (void)setPostParametersWithDictionary:(NSDictionary *)params
{
    if (params == nil) return;
    
    NSArray *keys = [params allKeys];
    
    for (NSString *key in keys)
    {
        id value = [params objectForKey:key];
        if ([value isKindOfClass:[NSNumber class]])
        {
            value = [value stringValue];
        }
        
        [self setPostValue:value forKey:key];
    }
}

@end
