//
//  BTBaseParser.h
//  Bestiz
//
//  Created by Shin Bumcheol on 12/11/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTKeyForModel.h"

@class BTBaseModel;

@protocol BTBaseParserProtocol
@required
- (BTBaseModel *)parseToModel:(NSDictionary *)dic;
@end

@interface BTBaseParser : NSObject <BTBaseParserProtocol>

- (BOOL)isNull:(id)obj;
- (BOOL)isObject:(id)obj;
- (BOOL)isArray:(id)obj;
- (BOOL)isString:(id)obj;
- (BOOL)isNumber:(id)obj;

- (NSInteger)parseToInt:(id)obj;
- (double)parseToDouble:(id)obj;
- (NSString*)parseToString:(id)obj;

- (NSMutableArray *)parseToModels:(NSArray *)dicArray;
- (BTBaseModel *)parseToModel:(NSDictionary *)dic;

@end
