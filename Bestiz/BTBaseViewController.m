//
//  BaseViewController.m
//  Bestiz
//
//  Created by Bumcheol Shin on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BTBaseViewController.h"
#import "ASIHTTPRequest.h"

@interface BTBaseViewController() {
@private
    
}

- (void)cancelRequests;
@end

@implementation BTBaseViewController

@synthesize bannerIsVisible, requestQueue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.requestQueue = [[[NSOperationQueue alloc] init] autorelease];
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

    self.bannerIsVisible = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{    
    [requestQueue release];
    
    [super dealloc];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self cancelRequests];
}

- (void)cancelRequests
{
    [requestQueue cancelAllOperations];
    //    [requestQueue.operations makeObjectsPerformSelector:@selector(clearDelegatesAndCancel)];
    [[ASIHTTPRequest sharedQueue] cancelAllOperations];
    //    [[[ASIHTTPRequest sharedQueue] operations] makeObjectsPerformSelector:@selector(clearDelegatesAndCancel)];
}

@end
