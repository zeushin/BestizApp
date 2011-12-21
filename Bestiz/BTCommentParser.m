//
//  BTCommentParser.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/19/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTCommentParser.h"

@implementation BTCommentParser

- (BTBaseModel *)parseToModel:(NSDictionary *)dic
{
    BTComment *comment = [[[BTComment alloc] init] autorelease];
    comment.name = [self parseToString:[dic objectForKey:COMMENT_NAME]];
    comment.comment = [self parseToString:[dic objectForKey:COMMENT_COMMENT]];
    comment.ip = [self parseToString:[dic objectForKey:COMMENT_IP]];
    
    return comment;
}

@end
