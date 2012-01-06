//
//  BTSuperParser.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/11/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTBoardParser.h"

@implementation BTBoardParser

- (BTBaseModel *)parseToModel:(NSDictionary *)dic
{
    BTBoard *board = [[[BTBoard alloc] init] autorelease];
    board.number = [self parseToString:[dic objectForKey:BOARD_NO]];
    board.subject = [self parseToString:[dic objectForKey:BOARD_SUBJECT]];
    board.name = [self parseToString:[dic objectForKey:BOARD_NAME]];
    board.url = [NSURL URLWithString:[self parseToString:[dic objectForKey:BOARD_URL]]];
    
    return board;
}

@end
