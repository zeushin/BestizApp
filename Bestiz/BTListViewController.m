//
//  BTListViewController.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/19/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTListViewController.h"

@interface BTListViewController() {
@private
    BOOL reachedAtBottom;
}
@end

@implementation BTListViewController

@synthesize delegate;
@synthesize data;
@synthesize table;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
    
    table.dataSource = self;
    table.delegate = self;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.table = nil;
}

- (void)dealloc
{
    [data release];
    [table release];
    
    [super dealloc];
}

- (void)setScrollsToTop
{
    if ([data count] > 0)
    {
        [table scrollRectToVisible:CGRectMake(0, 0, table.frame.size.width, table.frame.size.height) animated:YES];
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];        
    }
}

- (void)setScrollsToFirstRow
{
    if ([data count] > 0)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];        
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"data count: %d", [data count]);

    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    return nil;
}


#pragma mark - Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height)
    {
        if (!reachedAtBottom)
        {
            reachedAtBottom = YES;
            
            if ([delegate respondsToSelector:@selector(didReachedBottomOfTableView)])
            {
                [delegate didReachedBottomOfTableView];
            }
        }
    }
    else
    {
        reachedAtBottom = NO;
    }
}

@end
