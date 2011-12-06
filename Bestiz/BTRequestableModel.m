//
//  BTReqeustableModel.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/3/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTRequestableModel.h"

@interface BTRequestableModel()
{
@private
    BTRequester *_requester;
}

@property (nonatomic, assign) BTRequester *requester;

@end

@implementation BTRequestableModel

@synthesize requester = _requester;

- (id)init
{
    self = [super init];
    if (self) {
        self.requester = [BTRequester requester];
    }
    return self;
}

+ (void)getList:(BoardCategory)board withPage:(NSUInteger)page delegate:(id <BTRequesterDelegate>)delegate
{
    NSString *urlString = nil;
    BoardIndex *boardIndex = [[BoardIndex alloc] init];
    
    switch (board) {
        case BoardCategoryGuestHeaven:
            urlString = [boardIndex urlOfBoard:board boardType:BoardTypeList];
            break;
        case BoardCategoryGuestChatter:
            urlString = [boardIndex urlOfBoard:board boardType:BoardTypeList];
            break;
        case BoardCategoryGuestSpring:
            urlString = [boardIndex urlOfBoard:board boardType:BoardTypeList];
            break;
        case BoardCategoryGuestSummer:
            urlString = [boardIndex urlOfBoard:board boardType:BoardTypeList];
            break;
        default:
            break;
    }
    [boardIndex release];
    
    BTRequester *requester = [BTRequester requester];
    
    @synchronized(requester)
    {
        requester.requesterClass = [self class];
        requester.delegate = delegate;
        requester.url = urlString;
        requester.page = page;
        requester.requestMehod = BTReqeustMethodGET;
        [requester request];
    }
}

+ (void)getContents:(BoardCategory)board url:(NSString *)harfURL delegate:(id <BTRequesterDelegate>)delegate
{
    NSString *urlString = nil;
    BoardIndex *boardIndex = [[BoardIndex alloc] init];
    
    switch (board) {
        case BoardCategoryGuestHeaven:
            urlString = [boardIndex urlOfBoard:board boardType:BoardTypeContents];
            break;
        case BoardCategoryGuestChatter:
            urlString = [boardIndex urlOfBoard:board boardType:BoardTypeContents];
            break;
        case BoardCategoryGuestSpring:
            urlString = [boardIndex urlOfBoard:board boardType:BoardTypeContents];
            break;
        case BoardCategoryGuestSummer:
            urlString = [boardIndex urlOfBoard:board boardType:BoardTypeContents];
            break;
        default:
            break;
    }
    [boardIndex release];
    urlString = [NSString stringWithFormat:@"%@/%@", urlString, harfURL];
    
    BTRequester *requester = [BTRequester requester];
    
    @synchronized(requester)
    {
        requester.requesterClass = [self class];
        requester.delegate = delegate;
        requester.url = urlString;
        requester.requestMehod = BTReqeustMethodGET;
        [requester request];
    }
}

+ (void)getComment:(BoardCategory)board url:(NSString *)harfURL delegate:(id <BTRequesterDelegate>)delegate
{
    NSString *urlString = nil;
    BoardIndex *boardIndex = [[BoardIndex alloc] init];
    
    switch (board) {
        case BoardCategoryGuestHeaven:
            urlString = [boardIndex urlOfBoard:board boardType:BoardTypeContents];
            break;
        case BoardCategoryGuestChatter:
            urlString = [boardIndex urlOfBoard:board boardType:BoardTypeContents];
            break;
        case BoardCategoryGuestSpring:
            urlString = [boardIndex urlOfBoard:board boardType:BoardTypeContents];
            break;
        case BoardCategoryGuestSummer:
            urlString = [boardIndex urlOfBoard:board boardType:BoardTypeContents];
            break;
        default:
            break;
    }
    [boardIndex release];
    urlString = [NSString stringWithFormat:@"%@/%@", urlString, harfURL];
    
    BTRequester *requester = [BTRequester requester];
    
    @synchronized(requester)
    {
        requester.requesterClass = [self class];
        requester.delegate = delegate;
        requester.url = urlString;
        requester.requestMehod = BTReqeustMethodGET;
        [requester request];
    }
}

@end
