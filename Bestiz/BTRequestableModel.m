//
//  BTReqeustableModel.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/3/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTRequestableModel.h"

@interface BTRequestableModel()
{
@private
    BTRequester *_requester;
}

@property (nonatomic, assign) BTRequester *requester;

@end

@implementation BTRequestableModel

@synthesize requester = _requester;

- (id)init
{
    self = [super init];
    if (self) {
        self.requester = [BTRequester requester];
    }
    return self;
}

@end
