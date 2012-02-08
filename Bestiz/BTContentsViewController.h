//
//  IFContentsViewController.h
//  Bestiz
//
//  Created by Shin Bumcheol on 12/21/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTListViewController.h"
#import "BTBoard.h"

@interface BTContentsViewController : BTListViewController <BTRequesterDelegate, UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIControl *headerView;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet ADBannerView *bannerView1;

@property (nonatomic, retain) BTBoard *btBoard;
@property (nonatomic, retain) NSMutableArray *contentsData;
@property (nonatomic, retain) BTBoardIndex *boardIndex;
@property (nonatomic, retain) NSString *harfURL;

@end
