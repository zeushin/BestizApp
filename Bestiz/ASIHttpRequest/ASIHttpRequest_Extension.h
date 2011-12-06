//
//  ASIHttpRequest_JSONExtension.h
//  Nanumi
//
//  Created by Park JiHun on 11. 7. 6..
//  Copyright 2011 Matji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

//@interface ASIHTTPRequest (Extension)
//    
//
//@property (nonatomic, readonly) NSInteger responseResultCode;
//@property (nonatomic, readonly) NSInteger responseResultTotalCount;
//@property (nonatomic, retain, readonly) id responseResultObject;
//@property (nonatomic, copy, readonly) NSString *responseResultDescription;
//
//
////- (id)responseResultObject;
////- (NSInteger)responseResultTotalCount;
////- (NSInteger)responseResultCode;
////- (NSString *)responseResultDescription;
//
//
//@end

@interface ASIFormDataRequest (Extension)

- (void)setPostParametersWithDictionary:(NSDictionary *)params;

@end
