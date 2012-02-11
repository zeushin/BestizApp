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
//    NSString *st = [self parseToString:[dic objectForKey:BOARD_URL]];
//    st = [st stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:st];
//    NSLog(@"NSString: %@", st);
//    NSLog(@"NSURL: %@", url);
    BTBoard *board = [[[BTBoard alloc] init] autorelease];
    board.number = [self parseToString:[dic objectForKey:BOARD_NO]];
    board.subject = [self parseToString:[dic objectForKey:BOARD_SUBJECT]];
    board.name = [self parseToString:[dic objectForKey:BOARD_NAME]];
    NSString *urlString = [[self parseToString:[dic objectForKey:BOARD_URL]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    board.url = [NSURL URLWithString:urlString];
    board.totalPage = [self parseToInt:[dic objectForKey:BOARD_TOTALPAGE]];
    
    return board;
}

@end
