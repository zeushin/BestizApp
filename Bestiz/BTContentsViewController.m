//
//  IFContentsViewController.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/21/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTContentsViewController.h"
#import "BTContents.h"
#import "BTComment.h"

@interface BTContentsViewController() {
@private
    
}

@property (nonatomic, retain) NSMutableArray *contentsData;
@end

@implementation BTContentsViewController

@synthesize textView = _textView;
@synthesize boardIndex = _boardIndex;
@synthesize harfURL = _harfURL;
@synthesize contentsData = _contentsData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [textView setDelegate:self];
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
    [self setTitle:_boardIndex.nameOfBoard];
    
    [BTContents getContents:_boardIndex.boardCategory url:_harfURL delegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.textView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [_textView release];
    [_boardIndex release];
    [_harfURL release];
    [_contentsData release];
    
    [super dealloc];
}


#pragma mark - BTRequesterDelegate method

- (void)requestFinishedWithResults:(NSMutableArray *)results
{
    self.contentsData = results;
    BTContents *contents = (BTContents *)[_contentsData lastObject];
    [_textView setText:contents.contents];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    [self setScrollsToTop];
}

@end
