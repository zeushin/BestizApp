//
//  BTGuestChatter.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/3/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTGuestChatter.h"

@implementation BTGuestChatter

- (id)init
{
    self = [super init];
    if (self) {
        title = [NSString stringWithString:@"게스트 잡담"];
    }
    
    return self;
}

@end
