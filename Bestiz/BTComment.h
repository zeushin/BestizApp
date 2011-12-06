//
//  BTComment.h
//  Bestiz
//
//  Created by Shin Bumcheol on 12/3/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTRequestableModel.h"

@interface BTComment : BTRequestableModel
{
    NSString *name;
    NSString *contents;
    NSString *ip;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *contents;
@property (nonatomic, retain) NSString *ip;

@end
