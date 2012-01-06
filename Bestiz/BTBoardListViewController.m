//
//  BTBoardListViewController.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/20/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTBoardListViewController.h"
#import "BTBoard.h"
#import "BTContents.h"
#import "BTContentsViewController.h"
#import "BTContentsWebViewController.h"

@interface BTBoardListViewController() {
@private
    BTContentsViewController *_contentsView;
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        [cell.textLabel setFont:[UIFont systemFontOfSize:kFontSize-1]];
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:kFontSize]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    // Configure the cell...
    BTBoard *board = [data objectAtIndex:indexPath.row];
    NSString *string = [NSString stringWithFormat:@"%@  %@", board.number, board.name];
    [cell.textLabel setText:string];
    [cell.detailTextLabel setText:board.subject];
    
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
    _contentsView = [[BTContentsViewController alloc] init];
    _contentsView.boardIndex = _boardIndex;
    BTBoard *board = [data objectAtIndex:indexPath.row];
    _contentsView.harfURL = [board.url absoluteString];
    [BTContents getContents:_boardIndex.boardCategory url:[board.url absoluteString] delegate:self];
    
//    BTContentsWebViewController *webView = [[BTContentsWebViewController alloc] init];
//    webView.boardIndex = _boardIndex;
//    BTBoard *board = [data objectAtIndex:indexPath.row];
//    webView.harfURL = [board.url absoluteString];
//    [self.navigationController pushViewController:webView animated:YES];
//    [webView release];
}

#pragma mark - BTRequesterDelegate method

- (void)requestFinishedWithResults:(NSMutableArray *)results tag:(NSInteger)tag
{
    if (tag == BoardTypeList) {
        self.data = results;
        [table reloadData];
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
        [self setScrollsToTop];
    } else if (tag == BoardTypeContents) {
        _contentsView.contentsData = results;
        [self.navigationController pushViewController:_contentsView animated:YES];
        [_contentsView release];
    }
}

@end
