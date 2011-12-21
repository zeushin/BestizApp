//
//  BTBoardListViewController.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/20/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTBoardListViewController.h"
#import "BTBoard.h"
#import "BTContentsViewController.h"

@interface BTBoardListViewController() {
@private
    
}

@property (nonatomic) NSUInteger page;

@end

@implementation BTBoardListViewController

@synthesize boardIndex = _boardIndex;
@synthesize page = _page;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.page = 1;
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

    [self setTitle:_boardIndex.nameOfBoard];
    
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshTable:)];
    self.navigationItem.rightBarButtonItem = refresh;
    [refresh release];
    
    [BTBoard getList:_boardIndex.boardCategory withPage:_page delegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [_boardIndex release];
    
    [super dealloc];
}

// Touch up inside method
- (void)refreshTable:(UIBarButtonItem *)button
{
    [button setEnabled:NO];
    _page = 1;
    [BTBoard getList:_boardIndex.boardCategory withPage:_page delegate:self];
    NSLog(@"refresh!!");
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    BTBoard *board = [data objectAtIndex:indexPath.row];
    cell.textLabel.text = board.subject;
    
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
    BTContentsViewController *contentsView = [[BTContentsViewController alloc] init];
    contentsView.boardIndex = _boardIndex;
    BTBoard *board = [data objectAtIndex:indexPath.row];
    contentsView.harfURL = [board.url absoluteString];
    [self.navigationController pushViewController:contentsView animated:YES];
    [contentsView release];
}

#pragma mark - BTRequesterDelegate method

- (void)requestFinishedWithResults:(NSMutableArray *)results
{
    self.data = results;
    [table reloadData];
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    [self setScrollsToTop];
}

@end
