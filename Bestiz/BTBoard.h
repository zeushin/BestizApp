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
    NSString *number;
    NSString *subject;
    NSString *name;
    NSDate *date;
    NSUInteger read;
    NSUInteger vote;
    NSUInteger totalPage;
    
    NSURL *url;
    NSString *contents;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *number;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic) NSUInteger read;
@property (nonatomic) NSUInteger vote;
@property (nonatomic) NSUInteger totalPage;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSString *contents;

+ (void)getList:(BoardCategory)board withPage:(NSUInteger)page delegate:(id <BTRequesterDelegate>)delegate withRequestque:(NSOperationQueue *)queue;
+ (void)searchList:(BoardCategory)board keyword:(NSString *)keyword page:(NSUInteger)page delegate:(id <BTRequesterDelegate>)delegate withRequestque:(NSOperationQueue *)queue;

@end
