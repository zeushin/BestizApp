//
//  ListViewController.h
//  Bestiz
//
//  Created by Bumcheol Shin on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@interface ListViewController : BaseViewController <UITableViewDelegate>
{
    UITableView *table;
    NSMutableArray *listData;
    NSMutableDictionary *contentsData;
    BoardIndex *index;
    NSInteger page;
    NSURL *baseURL;
}

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) NSMutableArray *listData;
@property (nonatomic, retain) NSMutableDictionary *contentsData;
@property (nonatomic, retain) BoardIndex *index;
@property (nonatomic) NSInteger page;
@property (nonatomic, retain) NSURL *baseURL;

@end
