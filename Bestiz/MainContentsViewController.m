//
//  MainContentViewController.m
//  Bestiz
//
//  Created by Bumcheol Shin on 11/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainContentsViewController.h"

#define kContentsFontSize 14.0f

@implementation MainContentsViewController

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

- (NSString *)parsingContents
{
    if (contentsData == nil) return nil;
    NSLog(@"%@", index.guestType);
    NSString *hrefType;
    if (index.guestType == GuestTypeHeaven) {
        hrefType = HEAVEN_SERVER;
    } else if (index.guestType == GuestTypeChatter) {
        hrefType = CHATTER_SERVER;
    }
    
    NSString *hrefString = [NSString stringWithFormat:@"%@/%@", hrefType, [contentsData objectForKey:@"href"]];
    NSLog(@"Contents url : %@", hrefString);
    NSURL *url = [NSURL URLWithString:hrefString];    
    bestizParser = [[BestizParser alloc] init];
    NSString *parsedString = [bestizParser parsingWithContentOfURL:url];
    
    return parsedString;
}

- (void)displayTableHeaderView
{    
    UITextView *contentsTextView = [[UITextView alloc] init];
    
    NSString *contentsString = [self parsingContents];
//    contentsString = [contentsString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    contentsTextView.text = contentsString;
    contentsTextView.font = [UIFont systemFontOfSize:kContentsFontSize];
    
	CGSize maximumLabelSize = CGSizeMake(320.0f, 2000.0f);
    CGSize contentsSize = [contentsString sizeWithFont:[UIFont systemFontOfSize:kContentsFontSize] constrainedToSize:maximumLabelSize lineBreakMode:UILineBreakModeCharacterWrap];
    [contentsTextView setFrame:CGRectMake(0, 0, 320.0f, contentsSize.height)];
    contentsTextView.backgroundColor = [UIColor redColor];

    UIView *contentsView = [[UIView alloc] initWithFrame:contentsTextView.frame];
    [contentsView addSubview:contentsTextView];
    [contentsTextView release];
    table.tableHeaderView = contentsView;
    [contentsView release];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = [contentsData objectForKey:@"title"];
    [self displayTableHeaderView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [super dealloc];
}

@end
