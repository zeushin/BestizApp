//
//  BTListViewController.h
//  Bestiz
//
//  Created by Shin Bumcheol on 12/19/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTBaseViewController.h"

@protocol BTListViewControllerDelegate <NSObject>
@optional
- (void)didReachedBottomOfTableView;

@end

@interface BTListViewController : BTBaseViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *data;
    UITableView *table;
}

@property (nonatomic, assign) id <BTListViewControllerDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) IBOutlet UITableView *table;

- (void)setScrollsToTop;

@end
