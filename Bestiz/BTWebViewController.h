//
//  BTWebViewController.h
//  Bestiz
//
//  Created by Shin Bumcheol on 1/29/12.
//  Copyright (c) 2012 BananaWiki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTWebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *reloadItem;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *backItem;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *forwItem;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *actionItem;

@property (nonatomic, retain) NSString *baseURL;

- (IBAction)reloadItemTapped:(id)sender;
- (IBAction)backItemTapped:(id)sender;
- (IBAction)forwItemTapped:(id)sender;
- (IBAction)actionItemTapped:(id)sender;

@end
