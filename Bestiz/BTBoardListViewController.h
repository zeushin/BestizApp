//
//  BTBoardListViewController.h
//  Bestiz
//
//  Created by Shin Bumcheol on 12/20/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTListViewController.h"

@interface BTBoardListViewController : BTListViewController <BTRequesterDelegate, BTListViewControllerDelegate, UISearchBarDelegate>
{
    BTBoardIndex *boardIndex;
    UISearchDisplayController *searchController;
}

@property (nonatomic, retain) BTBoardIndex *boardIndex;
@property (nonatomic, retain) IBOutlet ADBannerView *bannerView1;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

@end
