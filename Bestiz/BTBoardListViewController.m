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

@interface BTBoardListViewController() {
@private
    BTContentsViewController *_contentsView;
    BOOL requestEnable;
}

@property (nonatomic) NSUInteger page;

- (void)requestBoard;

@end

@implementation BTBoardListViewController

@synthesize boardIndex = _boardIndex;
@synthesize page = _page;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.page = 1;
        requestEnable = YES;
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

    // 네비타이틀
    [self setTitle:_boardIndex.nameOfBoard];
    
    // 리프레쉬 버튼
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshTable:)];
    self.navigationItem.rightBarButtonItem = refresh;
    [refresh release];
    
    // 리스트뷰델리게이트 연결
    self.delegate = self;
    
    // 게시글 리퀘스트
    [self requestBoard];
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

// Private method

- (void)requestBoard
{
    [BTBoard getList:_boardIndex.boardCategory withPage:_page delegate:self];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    requestEnable = NO;
}


// Touch up inside method

- (void)refreshTable:(UIBarButtonItem *)button
{
    _page = 1;
    [self requestBoard];
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


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _contentsView = [[BTContentsViewController alloc] init];
    _contentsView.boardIndex = _boardIndex;
    BTBoard *board = [data objectAtIndex:indexPath.row];
    _contentsView.harfURL = [board.url absoluteString];
    _contentsView.btBoard = board;
    
    [BTContents getContents:_boardIndex.boardCategory url:[board.url absoluteString] delegate:self];
}

#pragma mark - BTRequesterDelegate method

- (void)requestFinishedWithResults:(NSMutableArray *)results tag:(NSInteger)tag
{
    if (tag == BoardTypeList) {
        if (_page == 1) {
            self.data = results;
            [table reloadData];
            [self setScrollsToTop];
        } else {
            [data addObjectsFromArray:results];
            [table reloadData];
        }
        
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
        _page++;
        requestEnable = YES;
    } else if (tag == BoardTypeContents) {
        _contentsView.contentsData = results;
        [self.navigationController pushViewController:_contentsView animated:YES];
        [_contentsView release];
    }
}

#pragma mark - BTListViewController delegate method
- (void)didReachedBottomOfTableView
{
    if (requestEnable) {
        [self requestBoard];
    }
}

@end
