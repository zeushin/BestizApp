//
//  BTContentsWebViewController.h
//  Bestiz
//
//  Created by Shin Bumcheol on 12/29/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTListViewController.h"

@interface BTContentsWebViewController : BTListViewController <BTRequesterDelegate>
{
    UIWebView *_webView;
    BTBoardIndex *_boardIndex;
    NSString *_harfURL;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) BTBoardIndex *boardIndex;
@property (nonatomic, retain) NSString *harfURL;

@end
