//
//  BestizParser.m
//  Bestiz
//
//  Created by Bumcheol Shin on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BestizParser.h"
#import "HTMLParser.h"
#import "BTKeyForModel.h"

@implementation BestizParser

- (HTMLNode *)parsingOfURL:(NSURL *)url
{
    NSString *stringWithUrl = [NSString stringWithContentsOfURL:url encoding:-2147481280 error:nil];
    NSData *urlData = [stringWithUrl dataUsingEncoding:NSUTF8StringEncoding];
    
    HTMLParser *parser = [[HTMLParser alloc] initWithData:urlData error:nil];
    HTMLNode *body = [parser body];
    
    return body;
}

- (HTMLNode *)parsingOfData:(NSData *)data
{
//    NSString *stringWithUrl = [NSString stringWithContentsOfURL:url encoding:-2147481280 error:nil];
//    NSData *urlData = [stringWithUrl dataUsingEncoding:NSUTF8StringEncoding];
    
    HTMLParser *parser = [[HTMLParser alloc] initWithData:data error:nil];
    HTMLNode *body = [parser body];
    
    return body;
}


//////////////////////////
// 게시글 목록을 배열로 투척 //
//////////////////////////

- (NSMutableArray *)parsingWithListOfData:(NSData *)data
{
    NSMutableArray *allContents = [NSMutableArray array];
    
    HTMLNode *body = [self parsingOfData:data];
    NSArray *trs = [body findChildrenWithAttribute:@"onmouseover" matchingName:@"#F9F9F9" allowPartial:YES];
    for (HTMLNode *tr in trs)
    {
        NSArray *tds = [tr findChildTags:@"td"];
        
        NSString *no = [[tds objectAtIndex:0] allContents];
        NSString *subject = [[tds objectAtIndex:1] allContents];
        NSString *name = [[tds objectAtIndex:2] allContents];
        NSString *date = [[tds objectAtIndex:3] allContents];
        NSString *read = [[tds objectAtIndex:4] allContents];
        NSString *vote = [[tds objectAtIndex:5] allContents];
        NSString *href = [[[tds objectAtIndex:1] findChildTag:@"a"] getAttributeNamed:@"href"];
        
        NSMutableDictionary *contentsOfTableRow = [NSMutableDictionary dictionary];
        [contentsOfTableRow setObject:no forKey:BOARD_NO];
        [contentsOfTableRow setObject:subject forKey:BOARD_SUBJECT];
        [contentsOfTableRow setObject:name forKey:BOARD_NAME];
        [contentsOfTableRow setObject:date forKey:BOARD_DATE];
        [contentsOfTableRow setObject:read forKey:BOARD_READ];
        [contentsOfTableRow setObject:vote forKey:BOARD_VOTE];
        [contentsOfTableRow setObject:href forKey:BOARD_URL];
        
        [allContents addObject:contentsOfTableRow];
    }
    
    return allContents;
}


//////////////////////////////
// 게시글 내용물을 배열로 투척 //
//////////////////////////////

- (NSMutableArray *)parsingWithContentsOfData:(NSData *)data
{
    NSMutableArray *allContents = [NSMutableArray array];
    HTMLNode *body = [self parsingOfData:data];
    
    NSString *contents = [[[body findChildWithAttribute:@"style" matchingName:@"line-height:160%" allowPartial:YES] allContents] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSMutableDictionary *contentsDic = [NSDictionary dictionaryWithObject:contents forKey:CONTENTS];

    [allContents addObject:contentsDic];
    
    return allContents;
}


/////////////////////
// 댓글을 배열로 투척 //
/////////////////////

- (NSMutableArray *)parsingWithCommentOfData:(NSData *)data
{
    NSMutableArray *allContents = [NSMutableArray array];
    HTMLNode *body = [self parsingOfData:data];
    
    NSArray *trs = [body findChildrenWithAttribute:@"onmouseover" matchingName:@"#F9F9F9" allowPartial:YES];
    for (HTMLNode *tr in trs) {
        NSArray *tds = [tr findChildTags:@"td"];
        
        NSString *comment_name = [[tds objectAtIndex:0] allContents];
        NSString *comment = [[tds objectAtIndex:1] allContents];
        NSString *ip = [[tds objectAtIndex:2] allContents];
        
        NSMutableDictionary *commentTableRow = [NSMutableDictionary dictionary];
        [commentTableRow setObject:comment_name forKey:COMMENT_NAME];
        [commentTableRow setObject:comment forKey:COMMENT_COMMENT];
        [commentTableRow setObject:ip forKey:COMMENT_IP];
        
        [allContents addObject:commentTableRow];
    }
    
    return allContents;
}

@end
