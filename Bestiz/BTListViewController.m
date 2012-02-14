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
    
    CGRect illustView1Frame;
}

@property (nonatomic, retain) UIImageView *illustView1;
@property (nonatomic, retain) UIImageView *illustView2;
@property (nonatomic, retain) UIImageView *illustView3;

- (void)background;

@end

@implementation BTListViewController

@synthesize delegate;
@synthesize data;
@synthesize table;
@synthesize illustView1 = _illustView1, illustView2 = _illustView2, illustView3 = _illustView3;

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
    
    [self background];

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
    [_illustView1 release];
    [_illustView2 release];
    [_illustView3 release];
    
    [super dealloc];
}


- (void)background
{
    [table setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:0.8]];
    
    UIImage *table_bg = [UIImage imageNamed:@"table_bg.png"];
    self.illustView1 = [[UIImageView alloc] initWithImage:table_bg];
    
    illustView1Frame = _illustView1.frame;
    illustView1Frame.size.width = 302;
    illustView1Frame.size.height = 204;
    illustView1Frame.origin.x = 9;
    illustView1Frame.origin.y = -illustView1Frame.size.height + 10;
    
    [_illustView1 setFrame:illustView1Frame];
    [self.view addSubview:_illustView1];
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
//    // Return the number of rows in the section.
//    NSLog(@"data count: %d", [data count]);
//
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    return nil;
}


#pragma mark - Table view delegate method

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
//        [cell setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:0.9]];
        [cell setBackgroundColor:[UIColor clearColor]];
    } else {
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
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

    [_illustView1 setFrame:CGRectMake(illustView1Frame.origin.x, illustView1Frame.origin.y - scrollView.contentOffset.y, illustView1Frame.size.width, illustView1Frame.size.height)];

}

@end
