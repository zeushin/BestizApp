//
//  BTBaseParser.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/11/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTBaseParser.h"

@implementation BTBaseParser

- (BOOL)isNull:(id)obj
{
	return (obj == nil || obj == [NSNull null]);
}

- (BOOL)isObject:(id)obj
{
	return ([self isNull:obj] == NO && [obj isKindOfClass:[NSDictionary class]]);
}

- (BOOL)isArray:(id)obj
{
	return ([self isNull:obj] == NO && [obj isKindOfClass:[NSArray class]]);
}

- (BOOL)isString:(id)obj
{
	return ([self isNull:obj] == NO && [obj isKindOfClass:[NSString class]]);
}

- (BOOL)isNumber:(id)obj
{
	return ([self isNull:obj] == NO && [obj isKindOfClass:[NSNumber class]]);
}

- (NSInteger)parseToInt:(id)obj
{
	if ([self isNumber:obj])
    {
		return [obj intValue];
	}
	
	return 0;
}

- (double)parseToDouble:(id)obj
{
	if ([self isNumber:obj])
    {
		return [obj doubleValue];
	}	
	
	return 0;
}

- (NSString*)parseToString:(id)obj
{
	if ([self isString:obj])
    {
		return obj;
	}
	else if ([self isNumber:obj])
    {
		return [obj stringValue];
	}
	
	return nil;
}

- (NSMutableArray *)parseToModels:(NSArray *)dicArray;
{
    NSMutableArray *models = [NSMutableArray array];
    
    for (NSDictionary *dic in dicArray)
    {
        BTBaseModel *model = [self parseToModel:dic];
        if (model)
            [models addObject:model];        
    }
    
    return models; 
}

/* Subclass should be overide below method */
- (BTBaseModel *)parseToModel:(NSDictionary *)dic {return nil;}

@end
