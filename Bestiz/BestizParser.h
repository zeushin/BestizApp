//
//  BestizParser.h
//  Bestiz
//
//  Created by Bumcheol Shin on 11/13/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BestizParser : NSObject

- (NSMutableArray *)parsingWithListOfURL:(NSURL *)url;
- (NSString *)parsingWithContentOfURL:(NSURL *)url;

@end
