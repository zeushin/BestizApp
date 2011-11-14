//
//  BestizParser.m
//  Bestiz
//
//  Created by Bumcheol Shin on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BestizParser.h"
#import "HTMLParser.m"

@implementation BestizParser

- (HTMLNode *)parsingOfURL:(NSURL *)url
{
    NSString *stringWithUrl = [NSString stringWithContentsOfURL:url encoding:-2147481280 error:nil];
    NSData *urlData = [stringWithUrl dataUsingEncoding:NSUTF8StringEncoding];
    
    HTMLParser *parser = [[HTMLParser alloc] initWithData:urlData error:nil];
    HTMLNode *body = [parser body];
    
    return body;
}

- (NSArray *)parsingWithListOfURL:(NSURL *)url
{
    
    HTMLNode *body = [self parsingOfURL:url];
    NSArray *tableList = [body findChildrenWithAttribute:@"style" matchingName:@"word-break:break-all;" allowPartial:YES];
    
    return tableList;
}

- (NSString *)parsingWithContentOfURL:(NSURL *)url
{
    HTMLNode *body = [self parsingOfURL:url];
    NSString *allContent = [[[body findChildWithAttribute:@"style" matchingName:@"line-height:160%" allowPartial:YES] allContents] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return allContent;    
}

@end
