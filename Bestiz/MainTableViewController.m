//
//  MainTableViewController.m
//  Bestiz
//
//  Created by Bumcheol Shin on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainTableViewController.h"
#import "BoardIndex.h"
#import "MasterViewController.h"

@implementation MainTableViewController

- (BoardIndex *)boardIndexName:(NSString *)name Url:(NSString *)url GuestType:(GuestType)guestType
{
    BoardIndex *boardIndex = [[[BoardIndex alloc] init] autorelease];
    boardIndex.nameOfBoard = name;
    boardIndex.urlOfBoard = url;
    boardIndex.guestType = guestType;
    
    return boardIndex;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        BoardIndex *boardIndex = [[BoardIndex alloc] init];
        
        NSString *guestHeaven = @"게스트 천국";
        NSString *guestHeavenUrl = [boardIndex urlOfBoard:BoardCategoryGuestHeaven BoardType:BoardTypeList];
        NSString *guestSpring = @"게잡의 봄";
        NSString *guestSpringUrl = [boardIndex urlOfBoard:BoardCategoryGuestSpring BoardType:BoardTypeList];
        NSString *guestChatter = @"게천잡담";
        NSString *guestChatterUrl = [boardIndex urlOfBoard:BoardCategoryGuestChatter BoardType:BoardTypeList];
        
        boardIndexList = [[NSMutableArray alloc] init];
        [boardIndexList addObject:[self boardIndexName:guestHeaven Url:guestHeavenUrl GuestType:GuestTypeHeaven]];
        [boardIndexList addObject:[self boardIndexName:guestSpring Url:guestSpringUrl GuestType:GuestTypeChatter]];
        [boardIndexList addObject:[self boardIndexName:guestChatter Url:guestChatterUrl GuestType:GuestTypeChatter]];
        
        [boardIndex release];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.title = @"Bestiz";
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [boardIndexList release];
    
    [super dealloc];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [boardIndexList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSInteger row = indexPath.row;
    
    BoardIndex *boardIndex = [boardIndexList objectAtIndex:row];
    NSString *boardTitle = boardIndex.nameOfBoard;
    cell.textLabel.text = boardTitle;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    MasterViewController *masterViewController = [[MasterViewController alloc] init];
    BoardIndex *boardIndex = [boardIndexList objectAtIndex:indexPath.row];
    masterViewController.urlString = boardIndex.urlOfBoard;
    masterViewController.title = boardIndex.nameOfBoard;
    if (boardIndex.guestType == GuestTypeHeaven)
        masterViewController.hrefString = HEAVEN_SERVER;
    else
        masterViewController.hrefString = CHATTER_SERVER;
    
    [self.navigationController pushViewController:masterViewController animated:YES];
    [masterViewController release];
}

@end
