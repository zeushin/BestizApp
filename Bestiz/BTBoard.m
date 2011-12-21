//
//  BTBoard.m
//  Bestiz
//
//  Created by Shin Bumcheol on 11/25/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTBoard.h"

@implementation BTBoard

@synthesize title;
@synthesize number;
@synthesize subject;
@synthesize name;
@synthesize date;
@synthesize read;
@synthesize vote;
@synthesize url;
@synthesize contents;

- (void)dealloc
{
    [title release];
    [subject release];
    [name release];
    [date release];
    [url release];
    [contents release];
    
    [super dealloc];
}

+ (void)getList:(BoardCategory)board withPage:(NSUInteger)page delegate:(id <BTRequesterDelegate>)delegate
{
    NSString *urlString = nil;
    BTBoardIndex *boardIndex = [[BTBoardIndex alloc] init];
    
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
        requester.requestMehod = BTRequestMethodGET;
        requester.boardType = BoardTypeList;
        [requester request];
    }
}

@end
