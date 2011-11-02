//
//  BoardIndexList.m
//  Bestiz
//
//  Created by Bumcheol Shin on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BoardIndexList.h"

@implementation BoardIndexList

@synthesize boardNameOfGeustHeaven, boardNameOfGuestSpring, boardNameOfGuestChatter;
@synthesize urlOfGuestHeaven, urlOfGuestSpring, urlOfGuestChatter;

- (id)init
{
    self = [super init];
    if (self) {
        boardNameOfGeustHeaven = [[NSString alloc] initWithString:@"게스트 천국"];
        boardNameOfGuestSpring = [[NSString alloc] initWithString:@"게잡의 봄"];
        boardNameOfGuestChatter = [[NSString alloc] initWithString:@"게천잡담"];
        
        urlOfGuestHeaven = [[NSString alloc] initWithFormat:@"%@%@%@", HEAVEN_SERVER, BOARD_LIST, GUEST_HEAVEN_BOARD_ID];
        urlOfGuestSpring = [[NSString alloc] initWithFormat:@"%@%@%@", CHATTER_SERVER, BOARD_LIST, GUEST_CHATTER_SPRING_ID];
        urlOfGuestChatter = [[NSString alloc] initWithFormat:@"%@%@%@", CHATTER_SERVER, BOARD_LIST, GUEST_HEAVEN_BOARD_ID];
    }
    return self;
}

- (void)dealloc
{
    [boardNameOfGeustHeaven release];
    [boardNameOfGuestSpring release];
    [boardNameOfGuestChatter release];
    [urlOfGuestHeaven release];
    [urlOfGuestSpring release];
    [urlOfGuestChatter release];
    
    [super dealloc];
}

@end
