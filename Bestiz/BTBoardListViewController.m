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
    
    BOOL requestEnable;
    BOOL isSearching;
}

@property (nonatomic, retain) BTContentsViewController *contentsView;
@property (nonatomic) NSUInteger page;
@property (nonatomic) NSUInteger searchPage;
@property (nonatomic, retain) NSMutableArray *searchedData;
@property (nonatomic, retain) NSMutableArray *autoSugData;
//@property (nonatomic, retain) ADBannerView *bannerView2;

- (void)requestBoard;
- (void)addDummyData;
- (void)hideKeyboard;

@end

@implementation BTBoardListViewController

@synthesize contentsView = _contentsView;
@synthesize boardIndex = _boardIndex;
@synthesize page = _page;
@synthesize bannerView1 = _bannerView1;
@synthesize searchBar = _searchBar;
@synthesize searchPage = _searchPage;
@synthesize searchedData = _searchedData;
@synthesize autoSugData = _autoSugData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.page = 1;
        self.searchPage = 1;
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
    
//    // 탭제스쳐
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
//    tapGesture.cancelsTouchesInView = NO;
//    [tapGesture addTarget:self action:@selector(hideKeyboard)];
//    [table addGestureRecognizer:tapGesture];
//    [tapGesture release];

    // 배너
//    self.bannerView2 = [[ADBannerView alloc] init];
//    [bannerView2 setDelegate:self];
    
    self.autoSugData = [NSMutableArray array];
    if (_boardIndex.boardCategory == BoardCategoryGuestSpring) {
        self.autoSugData = [NSArray arrayWithObjects:@"소시", @"뱅", @"東", @"SJ", nil];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.bannerView1 = nil;
    self.searchBar = nil;
}

- (void)dealloc
{
    [_contentsView release];
    [_boardIndex release];
    [_bannerView1 release];
    [_searchBar release];
    [_searchedData release];
    [_autoSugData release];
    
    [super dealloc];
}

// Private method

- (void)requestBoard
{
    if (!isSearching) {
        [BTBoard getList:_boardIndex.boardCategory withPage:_page delegate:self withRequestque:requestQueue];
    } else {
        BTBoard *board = [_searchedData lastObject];
        if (![board.number isEqualToString:@"1"]) // 마지막 글 넘버가 1일때 더이상 페이지 안나옴. 더검색 기능 없음.
        {
        [BTBoard searchList:_boardIndex.boardCategory keyword:_searchBar.text page:_searchPage delegate:self withRequestque:nil];
        }
    }
    
    requestEnable = NO;
    [self.navigationItem.rightBarButtonItem setEnabled:requestEnable];
}

- (void)addDummyData
{
    NSArray *nilArray = [NSArray arrayWithObject:@""];
    [data addObject:nilArray];
    [table reloadData];
}

- (void)hideKeyboard
{
    [_searchBar resignFirstResponder];
}


// Touch up inside method

- (void)refreshTable:(UIBarButtonItem *)button
{
    _page = 1;
    [self requestBoard];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%@", tableView);
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if (!isSearching) {
            return [_autoSugData count];
        }
        NSLog(@"searched data count: %d", [_searchedData count]);
        return [_searchedData count];
    } else {
        NSLog(@"data count: %d", [data count]);
        return [data count];      
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        [cell setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:0.9]];
    } else {
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    BTBoard *board = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    { // 테이블 = 검색결과
        if (!isSearching)
        { // 검색시작 전 자동완성테이블 (게봄에만 적용)
            static NSString *CellIdentifier = @"AutoSugCell";

            if (cell == nil)
            {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                NSLog(@"%@", [_autoSugData objectAtIndex:indexPath.row]);
                [cell.textLabel setText:[_autoSugData objectAtIndex:indexPath.row]];
                
                return cell;
            }
        }
        
        board = [_searchedData objectAtIndex:indexPath.row];
    }
    else
    { // 테이블 : 게시글
        board = [data objectAtIndex:indexPath.row];    
    }
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
//    if (indexPath.row > 0 && (indexPath.row + 1) % 26 == 0) {
//        NSString *iAdCellIdentifier = @"iadCell";
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iAdCellIdentifier] autorelease];
//        
//        // 두번째 배너 에드
//        [cell addSubview:bannerView2];
//        
//        NSLog(@"Add Banner!!");
//
//        return cell;
//    }

    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        [cell.textLabel setFont:[UIFont systemFontOfSize:kFontSize-1]];
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:kFontSize]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell.detailTextLabel setMinimumFontSize:10.0f];
        [cell.detailTextLabel setAdjustsFontSizeToFitWidth:YES];
    }
    
    // Configure the cell...
    
    NSString *string = [NSString stringWithFormat:@"%@  %@", board.number, board.name];
    [cell.textLabel setText:string];
    [cell.detailTextLabel setText:board.subject];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.contentsView = [[[BTContentsViewController alloc] init] autorelease];
    _contentsView.boardIndex = _boardIndex;
    
    BTBoard *board = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        board = [_searchedData objectAtIndex:indexPath.row];
    } else {
        board = [data objectAtIndex:indexPath.row];
    }
    _contentsView.harfURL = [board.url absoluteString];
    _contentsView.btBoard = board;
    
    [BTContents getContents:_boardIndex.boardCategory url:[board.url absoluteString] delegate:self withRequestque:requestQueue];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row > 0 && (indexPath.row + 1) % 26 == 0) {
//        return 50.0;
//    }
//    return 44.0;
//}


#pragma merk - Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    
    if ([_searchBar resignFirstResponder])
        [self hideKeyboard];
}


#pragma mark - BTRequesterDelegate method

- (void)requestFinishedWithResults:(NSMutableArray *)results tag:(NSInteger)tag
{
    if (tag == BoardTypeList)
    {
        //        if ([data count] == 0) return;
        if (_page == 1) {
            self.data = results;
            //            [self addDummyData];
            [table reloadData];
            [self setScrollsToFirstRow];
        } else {
            [data addObjectsFromArray:results];
            //            [self addDummyData];
            [table reloadData];
        }
                
        _page++;
        
        [_searchBar setHidden:NO];
        
    }
    else if (tag == BoardTypeContents)
    {
        _contentsView.contentsData = results;
        [self.navigationController pushViewController:_contentsView animated:YES];
    }
    else if (tag == BoardTypeSearch)
    {
        if (_searchPage == 1) {
            self.searchedData = results;
        } else {
            [_searchedData addObjectsFromArray:results];
        }
        
        [self.searchDisplayController.searchResultsTableView reloadData];
        
        _searchPage++;
    }
    
    requestEnable = YES;
    [self.navigationItem.rightBarButtonItem setEnabled:requestEnable];
}


#pragma mark - BTListViewController delegate method
- (void)didReachedBottomOfTableView
{
    if (requestEnable) {
        [self requestBoard];
    }
}


#if SHOW_BANNER
#pragma mark - ADBannerView delegate methods

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!bannerIsVisible) {
        [UIView beginAnimations:@"animationAdBannerOn" context:nil];
        [banner setFrame:CGRectOffset(banner.frame, 0, 50)];
        [table setFrame:CGRectMake(0, 50, 320, table.frame.size.height - 50)];
        [UIView commitAnimations];
        bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (bannerIsVisible) {
        [UIView beginAnimations:@"animationAdBannerOff" context:nil];
        [banner setFrame:CGRectOffset(banner.frame, 0, -50)];
        [table setFrame:CGRectMake(0, 0, 320, table.frame.size.height + 50)];
        [UIView commitAnimations];
        bannerIsVisible = NO;
    }
}
#endif


#pragma mark - UISearchBar delegate methods

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    [searchBar setShowsScopeBar:YES];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [table.tableHeaderView setFrame:CGRectMake(0, 0, 320, 88)];
    
    CGRect frame = self.searchDisplayController.searchResultsTableView.frame;
    frame.origin.y += 44;
    frame.size.height -= 44;
    [self.searchDisplayController.searchResultsTableView setFrame:frame];
    
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar setShowsScopeBar:NO];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [table.tableHeaderView setFrame:CGRectMake(0, 0, 320, 44)];
    
    CGRect frame = self.searchDisplayController.searchResultsTableView.frame;
    frame.origin.y -= 44;
    frame.size.height += 44;
    [self.searchDisplayController.searchResultsTableView setFrame:frame];
    
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
//    [table reloadData];
    isSearching = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    isSearching = YES;
    [self requestBoard];
}


#pragma mark - UISearchDisplayDelegate methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    return YES;
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    
}


@end
