//
//  BaseViewController.h
//  Bestiz
//
//  Created by Bumcheol Shin on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardIndex.h"
#import "BestizParser.h"

@interface BaseViewController : UIViewController
{
    BoardIndex *boardIndex;
    BestizParser *bestizParser;
    
    NSMutableArray *boardIndexData;
}

@end
