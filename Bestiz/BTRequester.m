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
#import "AppDelegate.h"

static BTRequester *requester = nil;
static NSString *REQUESTER_MODEL_NAME = @"RequesterModelName";
static UIActivityIndicatorView *actView = nil;
static UIView *alaphaView = nil;

@interface BTRequester()
{
@private
    
}

- (NSString *)__requestMethod;
- (void)showRequestActivity;
- (void)hideRequestActivity;

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
    [self showRequestActivity];
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


- (void)showRequestActivity
{
    @synchronized(actView)
    {
        if (actView == nil)
        {
            actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            actView.tag = 0;
        }
        
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        UIViewController *vc = [app.navigationController.viewControllers lastObject];
        CGPoint p;
        p.x = vc.view.frame.size.width / 2.0;
        p.y = vc.view.frame.size.height / 2.0;
        
//        if (app.keyboardState == IFKeyboardStateUp)
//        {
//            p.y -= app.keyboardHeight / 2.0;
//        }
        
        [actView setCenter:p];
        
        if (actView.tag == 0)
        {
            alaphaView = [[UIView alloc] initWithFrame:vc.view.frame];
            [alaphaView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
            [alaphaView addSubview:actView];
            [vc.view addSubview:alaphaView];
        }
        
        actView.tag += 1;
        [actView startAnimating];
    }
}

- (void)hideRequestActivity
{
    @synchronized(actView)
    {
        actView.tag -= 1;
        if (actView.tag < 0)
        {
            actView.tag = 0;
        }
        
        if (actView.tag == 0)
        {
            [actView stopAnimating];
            [actView removeFromSuperview];
            [alaphaView removeFromSuperview];
            [alaphaView release];
        }
    }
}


#pragma mark - ASIHttpRequestDelegate Method
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSArray *parsingResult;
    BestizParser *bestizParser = [[BestizParser alloc] init];
    NSLog(@"%@", request);
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
    
    [self hideRequestActivity];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"request Failed");
    NSString *log = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSLog(@"failed log: %@", log);
    [log release];
    
    NSError *error = request.error;
    NSLog(@"faild domain: %@", error.domain);
    
    [self hideRequestActivity];
}


@end
