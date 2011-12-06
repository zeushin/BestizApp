//
//  BestizParser.m
//  Bestiz
//
//  Created by Bumcheol Shin on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BestizParser.h"
#import "HTMLParser.h"

@implementation BestizParser

- (HTMLNode *)parsingOfURL:(NSURL *)url
{
    NSString *stringWithUrl = [NSString stringWithContentsOfURL:url encoding:-2147481280 error:nil];
    NSData *urlData = [stringWithUrl dataUsingEncoding:NSUTF8StringEncoding];
    
    HTMLParser *parser = [[HTMLParser alloc] initWithData:urlData error:nil];
    HTMLNode *body = [parser body];
    
    return body;
}


/////////////////////////////////////////
// 게시글 목록을 배열로 투척 (title + href) //
/////////////////////////////////////////

- (NSMutableArray *)parsingWithListOfURL:(NSURL *)url
{
    
    HTMLNode *body = [self parsingOfURL:url];
    NSArray *tableList = [body findChildrenWithAttribute:@"style" matchingName:@"word-break:break-all;" allowPartial:YES];
    
    NSMutableArray *parsingData = [NSMutableArray array];
    
    for (int i = 0; i < [tableList count]; i++)
    {
        HTMLNode *titleNode = [tableList objectAtIndex:i];
        
        NSString *title = [titleNode allContents];
        NSString *href = [NSString stringWithFormat:@"%@", [[titleNode findChildTag:@"a"] getAttributeNamed:@"href"]];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:title, @"title", href, @"href", nil];

        [parsingData addObject:dic];
    }
    
    return parsingData;
}


////////////////////////////
// 게시글 내용을 문자열로 투척 //
////////////////////////////

- (NSString *)parsingWithContentOfURL:(NSURL *)url
{
    HTMLNode *body = [self parsingOfURL:url];
    NSString *allContent = [[[body findChildWithAttribute:@"style" matchingName:@"line-height:160%" allowPartial:YES] allContents] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return allContent;    
}

@end
