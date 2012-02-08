//
//  BTComment.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/19/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTComment.h"

@implementation BTComment

@synthesize name;
@synthesize comment;
@synthesize ip;

- (void)dealloc
{
    [name release];
    [comment release];
    [ip release];
    
    [super dealloc];
}

+ (void)getComment:(BoardCategory)board url:(NSString *)harfURL delegate:(id <BTRequesterDelegate>)delegate withRequestque:(NSOperationQueue *)queue
{
    NSString *urlString = nil;
    BTBoardIndex *boardIndex = [[BTBoardIndex alloc] init];
    
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
        requester.requestMehod = BTRequestMethodGET;
        requester.boardType = BoardTypeComment;
        requester.queue = queue;
        
        [requester request];
    }
}

@end
