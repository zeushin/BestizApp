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

typedef enum {
    BTReqeustMethodGET,
    BTRequestMethodPOST,
    BTRequestMethodDELTE,
    BTRequestMethodUPDATE
} BTRequestMethod;


@interface BTRequester : NSObject <ASIHTTPRequestDelegate>
{
    id <BTRequesterDelegate> delegate;
    Class requesterClass;
    NSString *_url;
    NSUInteger _page;
    NSOperationQueue *_queue;
    BTRequestMethod _requestMehod;
}

@property (nonatomic, assign) id <BTRequesterDelegate> delegate;
@property (nonatomic, assign) Class requesterClass;
@property (nonatomic, retain) NSString *url;
@property (nonatomic) NSUInteger page;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic) BTRequestMethod requestMehod;

+ (id)requester;
- (void)request;

@end
