//
//  IFContentsViewController.h
//  Bestiz
//
//  Created by Shin Bumcheol on 12/21/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTListViewController.h"

@interface BTContentsViewController : BTListViewController <BTRequesterDelegate, UIWebViewDelegate>
{
//    NSMutableArray *_contentsData;
//    UIWebView *_webView;
//    BTBoardIndex *_boardIndex;
//    NSString *_harfURL;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *contentsData;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) BTBoardIndex *boardIndex;
@property (nonatomic, retain) NSString *harfURL;

@end
