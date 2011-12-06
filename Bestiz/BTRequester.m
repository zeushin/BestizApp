//
//  BTRequester.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/5/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTRequester.h"

static BTRequester *requester = nil;

@implementation BTRequester

@synthesize delegate;
@synthesize requesterClass;
@synthesize url = _url;
@synthesize page = _page;
@synthesize queue = _queue;
@synthesize requestMehod;

- (void)dealloc
{
    [_url release];
    [_queue release];
    
    [super dealloc];
}

+ (id)requester
{
    return requester;
}

- (void)request
{
    
}

@end
