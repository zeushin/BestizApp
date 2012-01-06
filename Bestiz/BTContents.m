//
//  BTComment.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/3/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTContents.h"

@implementation BTContents

@synthesize contents;

- (void)dealloc
{
    [contents release];
    
    [super dealloc];
}

+ (void)getContents:(BoardCategory)board url:(NSString *)harfURL delegate:(id <BTRequesterDelegate>)delegate
{
    BTBoardIndex *boardIndex = [[BTBoardIndex alloc] init];
    NSString *urlString = nil;
    
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
        requester.boardType = BoardTypeContents;
        requester.page = 0;
        [requester request];
    }
}

+ (NSString *)getFullURLfromHarfURL:(NSString *)harfURL board:(BoardCategory)board
{
    BTBoardIndex *boardIndex = [[BTBoardIndex alloc] init];
    NSString *urlString = nil;
    
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
    
    return urlString;
}

@end
