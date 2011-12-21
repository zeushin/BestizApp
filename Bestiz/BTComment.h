//
//  BTComment.h
//  Bestiz
//
//  Created by Shin Bumcheol on 12/19/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTRequestableModel.h"

@interface BTComment : BTRequestableModel
{
    NSString *name;
    NSString *comment;
    NSString *ip;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) NSString *ip;

+ (void)getComment:(BoardCategory)board url:(NSString *)harfURL delegate:(id <BTRequesterDelegate>)delegate;

@end
