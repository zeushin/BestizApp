//
//  BTWebViewController.m
//  Bestiz
//
//  Created by Shin Bumcheol on 1/29/12.
//  Copyright (c) 2012 BananaWiki. All rights reserved.
//

#import "BTWebViewController.h"

@interface BTWebViewController() {
@private
    
}

- (void)navItemCanEnable;
@end

@implementation BTWebViewController

@synthesize webView = _webView;
@synthesize reloadItem = _reloadItem, backItem = _backItem, forwItem = _forwItem, actionItem = _actionItem;
@synthesize baseURL = _baseURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURL *url = [NSURL URLWithString:_baseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    [self navItemCanEnable];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.webView = nil;
    self.reloadItem = nil;
    self.backItem = nil;
    self.forwItem = nil;
    self.actionItem = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [_webView release];
    [_reloadItem release];
    [_backItem release];
    [_forwItem release];
    [_actionItem release];
    [_baseURL release];
    
    [super dealloc];
}

// Private method
- (void)navItemCanEnable
{
    [_backItem setEnabled:[_webView canGoBack]];
    [_forwItem setEnabled:[_webView canGoForward]];    
}

- (IBAction)reloadItemTapped:(UIBarButtonItem *)item
{
    if (item.image == [UIImage imageNamed:@"reload.png"]) {
        [_webView reload];
    } else {
        [_webView stopLoading];
    }
}

- (IBAction)backItemTapped:(id)sender
{
    [_webView goBack];
}

- (IBAction)forwItemTapped:(id)sender
{
    [_webView goForward];
}

- (IBAction)actionItemTapped:(id)sender
{
    
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self navItemCanEnable];
    [_reloadItem setImage:[UIImage imageNamed:@"delete.png"]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self navItemCanEnable];
    [_reloadItem setImage:[UIImage imageNamed:@"reload.png"]];
}

@end
