//
//  BTBoardListViewController.h
//  Bestiz
//
//  Created by Shin Bumcheol on 12/20/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTListViewController.h"

@interface BTBoardListViewController : BTListViewController <BTRequesterDelegate>
{
    BTBoardIndex *boardIndex;
}

@property (nonatomic, retain) BTBoardIndex *boardIndex;

@end
