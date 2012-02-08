//
//  BTRequester.h
//  Bestiz
//
//  Created by Shin Bumcheol on 12/5/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "BTRequesterDelegate.h"
#import "BTBoardIndex.h"

typedef enum {
    BTRequestMethodGET,
    BTRequestMethodPOST,
    BTRequestMethodDELETE,
    BTRequestMethodUPDATE
} BTRequestMethod;


@interface BTRequester : NSObject <ASIHTTPRequestDelegate>
{
    id <BTRequesterDelegate> delegate;
    Class requesterClass;
    NSString *_url;
    NSUInteger _page;
    NSString *_keyword;
    NSOperationQueue *_queue;
    BTRequestMethod _requestMehod;
    BoardType _boardType;
}

@property (nonatomic, assign) id <BTRequesterDelegate> delegate;
@property (nonatomic, assign) Class requesterClass;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, retain) NSString *keyword;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic) BTRequestMethod requestMehod;
@property (nonatomic) BoardType boardType;

+ (id)requester;
- (void)request;

@end
