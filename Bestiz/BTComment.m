//
//  BTComment.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/3/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTComment.h"

@implementation BTComment

@synthesize name;
@synthesize contents;
@synthesize ip;

- (void)dealloc
{
    [name release];
    [contents release];
    [ip release];
    
    [super dealloc];
}

@end
