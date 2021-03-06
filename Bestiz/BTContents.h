//
//  BTComment.h
//  Bestiz
//
//  Created by Shin Bumcheol on 12/3/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTRequestableModel.h"

@interface BTContents : BTRequestableModel
{
    NSString *name;
    NSString *subject;
    NSString *contents;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *contents;

+ (void)getContents:(BoardCategory)board url:(NSString *)harfURL delegate:(id <BTRequesterDelegate>)delegate withRequestque:(NSOperationQueue *)queue;
+ (NSString *)getFullURLfromHarfURL:(NSString *)harfURL board:(BoardCategory)board;

@end
