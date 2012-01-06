//
//  BTRequester.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/5/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTRequester.h"
#import "BestizParser.h"
#import "BTBaseParser.h"

static BTRequester *requester = nil;

static NSString *REQUESTER_MODEL_NAME = @"RequesterModelName";

@interface BTRequester()
{
@private
    
}

- (NSString *)__requestMethod;
@end

@implementation BTRequester

@synthesize delegate;
@synthesize requesterClass;
@synthesize url = _url;
@synthesize page = _page;
@synthesize queue = _queue;
@synthesize requestMehod = _requestMehod, boardType = _boardType;

- (void)dealloc
{
    [_url release];
    [_queue release];
    
    [super dealloc];
}

+ (id)requester
{
    @synchronized(requester)
    {
        if (requester == nil) {
            requester = [[BTRequester alloc] init];
        }
    }
    return requester;
}

- (NSString *)__requestMethod
{
    switch (_requestMehod) {
        case BTRequestMethodGET:
            return @"GET";
            break;
        case BTRequestMethodPOST:
            return @"POST";
            break;
        case BTRequestMethodDELETE:
            return @"DELETE";
            break;
        case BTRequestMethodUPDATE:
            return @"UPDATE";
            break;
        default:
            return nil;
            break;
    }
}

- (void)request
{
    NSString *getURL = nil;
    if (_page > 0)
        getURL = [NSString stringWithFormat:@"%@&page=%d", _url, _page];
    else
        getURL = _url;
    
    NSLog(@"requestURL: %@", getURL);
    NSURL *url = [NSURL URLWithString:getURL];
    
    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:url] autorelease];
    
    [request setDelegate:self];
    [request setRequestMethod:[self __requestMethod]];
    
    NSString *requestClassName = NSStringFromClass(requesterClass);
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setValue:requestClassName forKey:REQUESTER_MODEL_NAME];
    
    [request setUserInfo:userInfo];
    [request setTag:_boardType];
    [request setQueue:_queue];
//    [request setDefaultResponseEncoding:-2147481280];
    
    [request startAsynchronous];
}


- (BTBaseParser *)__parserWithRequesterClassName:(NSString *)className
{
    NSString *parserClassName = [[NSString alloc] initWithFormat:@"%@Parser", className];
    BTBaseParser *parser = [[[NSClassFromString(parserClassName) alloc] init] autorelease];
    [parserClassName release];
    
    return parser;
}

#pragma mark - ASIHttpRequestDelegate Method
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSArray *parsingResult;
    BestizParser *bestizParser = [[BestizParser alloc] init];
    
    NSString *responseString = [request responseString];
    NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    switch (request.tag) {
        case BoardTypeList:
            parsingResult = [bestizParser parsingWithListOfData:data];
            break;
        case BoardTypeContents:
            parsingResult = [bestizParser parsingWithContentsOfData:data];
            break;
        case BoardTypeComment:
            parsingResult = [bestizParser parsingWithCommentOfData:data];
            break;
            
        default:
            break;
    }
    [bestizParser release];
    
    NSString *requesterModelName = [request.userInfo objectForKey:REQUESTER_MODEL_NAME];
    BTBaseParser *parser = [self __parserWithRequesterClassName:requesterModelName];
    NSMutableArray *models = [parser parseToModels:parsingResult];
    
    if (delegate && [(NSObject *)delegate respondsToSelector:@selector(requestFinishedWithResults:tag:)]) {
        [delegate requestFinishedWithResults:models tag:request.tag];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSString *log = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", log);
    [log release];
    
    NSError *error = request.error;
    NSLog(@"%@", error.domain);
    NSLog(@"request Failed");
}


@end
