//
//  BTBoard.h
//  Bestiz
//
//  Created by Shin Bumcheol on 11/25/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTRequestableModel.h"

@interface BTBoard : BTRequestableModel
{
    NSString *title;
    NSUInteger number;
    NSString *subject;
    NSString *name;
    NSDate *date;
    NSUInteger read;
    NSUInteger vote;
    
    NSURL *url;
    NSString *contents;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic) NSUInteger number;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic) NSUInteger read;
@property (nonatomic) NSUInteger vote;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSString *contents;

+ (void)getList:(BoardCategory)board withPage:(NSUInteger)page delegate:(id <BTRequesterDelegate>)delegate;

@end
