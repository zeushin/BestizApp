//
//  BTCommentParser.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/12/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTContentsParser.h"

@implementation BTContentsParser

- (BTBaseModel *)parseToModel:(NSDictionary *)dic
{
    BTContents *contents = [[[BTContents alloc] init] autorelease];
    contents.name = [self parseToString:[dic objectForKey:CONTENTS_NAME]];
    contents.subject = [self parseToString:[dic objectForKey:CONTENTS_SUBJECT]];
    contents.contents = [self parseToString:[dic objectForKey:CONTENTS]];
    
    return contents;
}

@end
