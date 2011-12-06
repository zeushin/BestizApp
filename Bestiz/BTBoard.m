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

@end
