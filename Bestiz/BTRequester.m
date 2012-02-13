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
@synthesize keyword = _keyword;
@synthesize queue = _queue;
@synthesize requestMehod = _requestMehod, boardType = _boardType;

- (void)dealloc
{
    [_url release];
    [_queue release];
    [_keyword release];
    
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
    NSString *getURL = _url;
    
    // page 파라미터
    if (_page > 0)
        getURL = [NSString stringWithFormat:@"%@&page=%d", getURL, _page];
    
    // 키워드 파라미터
    if (_boardType == BoardTypeSearch) {
        self.keyword = [_keyword stringByAddingPercentEscapesUsingEncoding:-2147481280];
        getURL = [NSString stringWithFormat:@"%@&keyword=%@", getURL, _keyword];
    } else {
        getURL = [getURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSURL *url = [NSURL URLWithString:getURL];
    NSLog(@"requestURL: %@", url);
    
    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:url] autorelease];
    
    [request setDelegate:self];
    [request setRequestMethod:[self __requestMethod]];
    
    NSString *requestClassName = NSStringFromClass(requesterClass);
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setValue:requestClassName forKey:REQUESTER_MODEL_NAME];
    
    [request setUserInfo:userInfo];
    [request setTag:_boardType];
    [request setQueue:_queue];
    [request setDefaultResponseEncoding:-2147481280];
//    [request setDefaultResponseEncoding:NSUTF8StringEncoding];
    
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
//        UIViewController *vc = [app.navigationController.viewControllers lastObject];
//        CGPoint p;
//        p.x = vc.view.frame.size.width / 2.0;
//        p.y = vc.view.frame.size.height / 2.0;
        CGPoint p;
        p.x = app.window.frame.size.width / 2.0;
        p.y = app.window.frame.size.height / 2.0;
//        if (app.keyboardState == IFKeyboardStateUp)
//        {
//            p.y -= app.keyboardHeight / 2.0;
//        }
        
        [actView setCenter:p];
        
        if (actView.tag == 0)
        {
            alaphaView = [[UIView alloc] initWithFrame:app.window.frame];
            [alaphaView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
            [alaphaView addSubview:actView];
            [app.window addSubview:alaphaView];
            [alaphaView addSubview:actView];
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
    NSArray *parsingResult = [NSArray array];
    BestizParser *bestizParser = [[BestizParser alloc] init];

    NSLog(@"Response Status Message: %@", [request responseStatusMessage]);
//    NSLog(@"%@", [request responseHeaders]);

    NSString *responseString = [request responseString];
    
    if (responseString) { // 응답 데이터가 있을경우에만...
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
            case BoardTypeSearch:
                parsingResult = [bestizParser parsingWithListOfData:data];
                break;
            default:
                break;
        }
        
        NSString *requesterModelName = [request.userInfo objectForKey:REQUESTER_MODEL_NAME];
        BTBaseParser *parser = [self __parserWithRequesterClassName:requesterModelName];
        NSMutableArray *models = [parser parseToModels:parsingResult];
        
        if (delegate && [(NSObject *)delegate respondsToSelector:@selector(requestFinishedWithResults:tag:)]) {
            [delegate requestFinishedWithResults:models tag:request.tag];
        }
    } else {
        if (delegate && [(NSObject *)delegate respondsToSelector:@selector(requestFinishedWithResults:tag:)]) {
            [delegate requestFinishedWithResults:nil tag:request.tag];
        }
    }
    
    [bestizParser release];
    
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
    
    if (delegate && [(NSObject *)delegate respondsToSelector:@selector(requestFailed)]) {
        [delegate requestFailed];
    }
}


@end
