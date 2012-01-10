//
//  BTMainTableViewController.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/19/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTMainTableViewController.h"
#import "BTBoardListViewController.h"
#import "BTBoard.h"

@interface BTMainTableViewController()
{
@private
    
}

@property (nonatomic, retain) NSMutableArray *boardIndexData;

- (void)__initializeBoardIndexData;

@end

@implementation BTMainTableViewController

@synthesize boardIndexData = _boardIndexData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self __initializeBoardIndexData];
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
    
    [self setTitle:@"Bestiz.net"];
    
//    [adView.frame setCGRectOffset(adView.frame, 0, 50)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [_boardIndexData release];
    
    [super dealloc];
}


- (void)__initializeBoardIndexData
{
    NSString *gHeaven = @"게스트 천국";
    NSString *gChatter = @"게천잡담";
    NSString *gSpring = @"게잡의 봄";
    NSString *gSummer = @"게잡의 여름";
    
    UIImage *gHeavenImage = [UIImage imageNamed:@"gc.gif"];
    UIImage *gChatterImage = [UIImage imageNamed:@"gj.gif"];
    UIImage *gSpringImage = [UIImage imageNamed:@"gb.gif"];
    UIImage *gSummerImage = [UIImage imageNamed:@"gy.gif"];
    
    BTBoardIndex *guestHeavenIndex = [[BTBoardIndex alloc] initWithNameOfBoard:gHeaven Image:gHeavenImage boardCategory:BoardCategoryGuestHeaven];
    BTBoardIndex *guestChatterIndex = [[BTBoardIndex alloc] initWithNameOfBoard:gChatter Image:gChatterImage boardCategory:BoardCategoryGuestChatter];
    BTBoardIndex *guestSpringIndex = [[BTBoardIndex alloc] initWithNameOfBoard:gSpring Image:gSpringImage boardCategory:BoardCategoryGuestSpring];
    BTBoardIndex *guestSummerIndex = [[BTBoardIndex alloc] initWithNameOfBoard:gSummer Image:gSummerImage boardCategory:BoardCategoryGuestSummer];
    
    self.boardIndexData = [NSArray arrayWithObjects:guestHeavenIndex, guestChatterIndex, guestSpringIndex, guestSummerIndex, nil];
    [guestHeavenIndex release];
    [guestChatterIndex release];
    [guestSpringIndex release];
    [guestSummerIndex release];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_boardIndexData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    // Configure the cell...
    BTBoardIndex *boardIndex = (BTBoardIndex *)[_boardIndexData objectAtIndex:indexPath.row];
    cell.textLabel.text = boardIndex.nameOfBoard;
    [cell.imageView setImage:boardIndex.imgOfBoard];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Bestiz";
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTBoardListViewController *detailViewController = [[BTBoardListViewController alloc] init];
    detailViewController.boardIndex = (BTBoardIndex *)[_boardIndexData objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - ADBannerView delegate methods

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!bannerIsVisible) {
        [UIView beginAnimations:@"animationAdBannerOn" context:nil];
        banner.frame = CGRectOffset(banner.frame, 0, -50);
        [UIView commitAnimations];
        bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (bannerIsVisible) {
        [UIView beginAnimations:@"animationAdBannerOff" context:nil];
        banner.frame = CGRectOffset(banner.frame, 0, 50);
        [UIView commitAnimations];
        bannerIsVisible = NO;
    }
}


@end
