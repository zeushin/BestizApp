//
//  BTReqeustableModel.h
//  Bestiz
//
//  Created by Shin Bumcheol on 12/3/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTBaseModel.h"
#import "BTBoardIndex.h"
#import "BTRequester.h"

@protocol BTRequestableModelProtocol

@optional
+ (void)searchList:(BoardCategory)board keyword:(NSString *)keyword page:(NSUInteger)page delegate:(id <BTRequesterDelegate>)delegate withRequestque:(NSOperationQueue *)queue;
+ (void)getList:(BoardCategory)board withPage:(NSUInteger)page delegate:(id <BTRequesterDelegate>)delegate withRequestque:(NSOperationQueue *)queue;
+ (void)getContents:(BoardCategory)board url:(NSString *)harfURL delegate:(id <BTRequesterDelegate>)delegate withRequestque:(NSOperationQueue *)queue;
+ (void)getComment:(BoardCategory)board url:(NSString *)harfURL delegate:(id <BTRequesterDelegate>)delegate withRequestque:(NSOperationQueue *)queue;

@end

@interface BTRequestableModel : BTBaseModel <BTRequestableModelProtocol>

@end
