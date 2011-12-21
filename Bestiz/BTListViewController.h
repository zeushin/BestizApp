//
//  BTListViewController.h
//  Bestiz
//
//  Created by Shin Bumcheol on 12/19/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTBaseViewController.h"

@interface BTListViewController : BTBaseViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *data;
    UITableView *table;
}

@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) IBOutlet UITableView *table;

- (void)setScrollsToTop;

@end
