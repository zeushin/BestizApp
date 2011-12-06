//
//  BoardIndexList.m
//  Bestiz
//
//  Created by Bumcheol Shin on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BoardIndex.h"

@implementation BoardIndex

@synthesize nameOfBoard, urlOfBoard, guestType;

- (id)init
{
    self = [super init];
    if (self) {
//        nameOfBoard = [NSString string];
//        urlOfBoard = [NSString string];
    }
    return self;
}

- (id)initWithNameOfBoard:(NSString *)name urlOfBoard:(NSString *)url typeOfGuest:(GuestType)type
{
    self = [self init];
    if (self) {
        self.nameOfBoard = name;
        self.urlOfBoard = url;
        self.guestType = type;
        NSLog(@"%@%@%@", nameOfBoard, urlOfBoard, guestType);
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (NSString *)urlOfBoard:(BoardCategory)boardCategory boardType:(BoardType)boardType
{
    NSString *boardUrl;

    if (boardType == BoardTypeList)
    {
        switch (boardCategory) {
            case BoardCategoryGuestHeaven:
                boardUrl = [NSString stringWithFormat:@"%@%@%@", HEAVEN_SERVER, BOARD_LIST, GUEST_HEAVEN_BOARD_ID];
                break;
                
            case BoardCategoryGuestChatter:
                boardUrl = [NSString stringWithFormat:@"%@%@%@", CHATTER_SERVER, BOARD_LIST, GUEST_HEAVEN_CHATTER_ID];
                break;
                
            case BoardCategoryGuestSpring:
                boardUrl = [NSString stringWithFormat:@"%@%@%@", CHATTER_SERVER, BOARD_LIST, GUEST_CHATTER_SPRING_ID];
                break;
                
            case BoardCategoryGuestSummer:
                boardUrl = [NSString stringWithFormat:@"%@%@%@", CHATTER_SERVER, BOARD_LIST, GUEST_CHATTER_SUMMER_ID];
                break;
                
            default:
                break;
        }
    }
    else if (boardType == BoardTypeContents)
    {
        switch (boardCategory) {
            case BoardCategoryGuestHeaven:
                boardUrl = [NSString stringWithFormat:@"%@%@%@", HEAVEN_SERVER, BOARD_CONTENT, GUEST_HEAVEN_BOARD_ID];
                break;
                
            case BoardCategoryGuestChatter:
                boardUrl = [NSString stringWithFormat:@"%@%@%@", CHATTER_SERVER, BOARD_CONTENT, GUEST_HEAVEN_CHATTER_ID];
                break;
                
            case BoardCategoryGuestSpring:
                boardUrl = [NSString stringWithFormat:@"%@%@%@", CHATTER_SERVER, BOARD_CONTENT, GUEST_CHATTER_SPRING_ID];
                break;
                
            case BoardCategoryGuestSummer:
                boardUrl = [NSString stringWithFormat:@"%@%@%@", CHATTER_SERVER, BOARD_CONTENT, GUEST_CHATTER_SUMMER_ID];
                break;
                
            default:
                break;
        }
    }
    
    return boardUrl;
}



@end
