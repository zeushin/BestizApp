//
//  BoardIndexList.m
//  Bestiz
//
//  Created by Bumcheol Shin on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTBoardIndex.h"

@implementation BTBoardIndex

@synthesize nameOfBoard, imgOfBoard, boardCategory;

- (id)init
{
    self = [super init];
    if (self) {
//        nameOfBoard = [NSString string];
//        urlOfBoard = [NSString string];
    }
    return self;
}

- (id)initWithNameOfBoard:(NSString *)name Image:(UIImage *)img boardCategory:(BoardCategory)category
{
    self = [self init];
    if (self) {
        self.nameOfBoard = name;
        self.imgOfBoard = img;
        self.boardCategory = category;
    }
    return self;
}

- (void)dealloc
{
    [nameOfBoard release];
    [imgOfBoard release];
    
    [super dealloc];
}

- (NSString *)urlOfBoard:(BoardCategory)category boardType:(BoardType)boardType
{
    NSString *boardUrl;

    if (boardType == BoardTypeList)
    {
        switch (category) {
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
        switch (category) {
            case BoardCategoryGuestHeaven:
                boardUrl = [NSString stringWithFormat:@"%@", HEAVEN_SERVER];
                break;
                
            case BoardCategoryGuestChatter:
                boardUrl = [NSString stringWithFormat:@"%@", CHATTER_SERVER];
                break;
                
            case BoardCategoryGuestSpring:
                boardUrl = [NSString stringWithFormat:@"%@", CHATTER_SERVER];
                break;
                
            case BoardCategoryGuestSummer:
                boardUrl = [NSString stringWithFormat:@"%@", CHATTER_SERVER];
                break;
                
            default:
                break;
        }
    }
    
    return boardUrl;
}



@end
