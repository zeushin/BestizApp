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
#import "BTCommentCell.h"

@interface BTContentsViewController() {
@private
    BOOL finishRequestWebView;
    BOOL finishRequestComment;
}

@property (nonatomic) CGFloat cellHeight;

- (void)requestContents;
- (void)resizingView;
- (BOOL)requestFinish;

- (void)showRequestActivity;
- (void)hideRequestActivity;


@end

@implementation BTContentsViewController

@synthesize scrollView = _scrollView, webView = _webView;
@synthesize titleLabel = _titleLabel, nameLabel = _nameLabel;
@synthesize boardIndex = _boardIndex;
@synthesize harfURL = _harfURL;
@synthesize contentsData = _contentsData;
@synthesize cellHeight = _cellHeight;
@synthesize btBoard = _btBoard;

static UIActivityIndicatorView *actView = nil;

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

    // 네비 타이틀
    [self setTitle:_boardIndex.nameOfBoard];
    
    // 제목과 글쓴이
    _titleLabel.text = _btBoard.subject;
    _nameLabel.text = _btBoard.name;
    
    // 리프레시 버튼
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshTable:)];
    self.navigationItem.rightBarButtonItem = refresh;
    [refresh release];
    
    // 웹뷰 스크롤 막기
    [_webView.scrollView setScrollEnabled:NO];
    
    // 스크롤뷰 배경색 지정
    [_scrollView setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:0.9]];
    
    // 컨텐츠 리퀘스트
    [self requestContents];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.webView = nil;
    self.scrollView = nil;
    self.titleLabel = nil;
    self.nameLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [_webView release];
    [_scrollView release];
    [_titleLabel release];
    [_nameLabel release];
    [_boardIndex release];
    [_harfURL release];
    [_contentsData release];
    [_btBoard release];
    
    [super dealloc];
}


// Private methods //

- (void)requestContents
{
    BTContents *contents = (BTContents *)[_contentsData lastObject];
    NSString *baseURL = [NSString stringWithFormat:@"%@/%@", [_boardIndex urlOfBoard:_boardIndex.boardCategory boardType:BoardTypeContents], _harfURL];
    [_webView loadHTMLString:contents.contents baseURL:[NSURL URLWithString:baseURL]];
    
    [BTComment getComment:_boardIndex.boardCategory url:_harfURL delegate:self];
}

- (void)resizingView
{
    // 웹뷰의 컨텐츠 크기만큼 프레임 조정
    CGRect webviewFrame = _webView.frame;
    webviewFrame.size.height = 1;
    _webView.frame = webviewFrame;
    CGSize fittingSize = [_webView sizeThatFits:CGSizeZero];
    webviewFrame.size = fittingSize;
    [_webView setFrame:webviewFrame];
//    NSLog(@"webview: %@", _webView);
//    NSLog(@"webviewContent : %f %f", _webView.scrollView.contentSize.width, _webView.scrollView.contentSize.height);
    
    // 테이블 크기를 테이블 컨텐츠 사이즈만큼 늘리고 웹뷰 밑에 붙임
    CGRect tableFrame = table.frame;
    tableFrame.size.height = table.contentSize.height;
    tableFrame.origin.y = _webView.frame.size.height + _webView.frame.origin.y;
    [table setFrame:tableFrame];
//    NSLog(@"table: %@", table);
    
    // 웹뷰와 테이블뷰 사이즈 만큼 스크롤뷰의 컨텐츠 사이즈를 늘림
    CGSize size = _scrollView.contentSize;
    size.height = _webView.frame.size.height + table.frame.size.height + 55; // 상단 헤더높이 55
    [_scrollView setContentSize:size];
//    NSLog(@"scrollView: %f %f", _scrollView.contentSize.width, _scrollView.contentSize.height);
}

- (BOOL)requestFinish
{
    if (finishRequestComment && finishRequestWebView) {
        [self hideRequestActivity];
        return YES;
    }
    [self showRequestActivity];
    
    return NO;
}

- (void)showRequestActivity
{
    @synchronized(actView)
    {
        if (actView == nil) {
            actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            actView.tag = 0;
        }
        CGPoint point;
        point.x = _webView.frame.size.width / 2.0;
        point.y = 20;
        
        [actView setCenter:point];
        
        if (actView.tag == 0)
        {
            [_webView addSubview:actView];
        }
        
        actView.tag += 1;
        [actView startAnimating];
    }
}

- (void)hideRequestActivity
{
    @synchronized(actView)
    {
        actView.tag -= 1;
        if (actView.tag < 0)
        {
            actView.tag = 0;
        }
        
        if (actView.tag == 0)
        {
            [actView stopAnimating];
            [actView removeFromSuperview];
        }
    }
}


// Touch up insdie method //

- (void)refreshTable:(id)sender
{
    [self.navigationItem.rightBarButtonItem setEnabled:[self requestFinish]];
    [self requestContents];
}


#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BTCommentCell";
    
    BTCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BTCommentCell" owner:self options:nil] lastObject];
    }
    
    // Configure the cell...
    BTComment *comment = [data objectAtIndex:indexPath.row];
    cell.nameLabel.text = comment.name;
    cell.ipLabel.text = comment.ip;
    cell.commentLabel.text = comment.comment;

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        [cell setBackgroundColor:[UIColor colorWithRed:242.0/255.0 green:246.0/255.0 blue:251.0/255.0 alpha:0.9]];
    } else {
        [cell setBackgroundColor:[UIColor clearColor]];
    }
}


#pragma mark - Table view delegate method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 55.0f;
    
    BTComment *comment = [data objectAtIndex:indexPath.row];
    NSString *commentString = comment.comment;
    CGSize commentSize = [commentString sizeWithFont:[UIFont boldSystemFontOfSize:13] constrainedToSize:CGSizeMake(290, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    CGFloat offset = commentSize.height - 13;
    if (offset > 13) {
        cellHeight += offset;
    }

    return cellHeight;
}


#pragma mark - BTRequesterDelegate method

- (void)requestFinishedWithResults:(NSMutableArray *)results tag:(NSInteger)tag
{    
    if (tag == BoardTypeComment) {
        self.data = results;
        [table reloadData];
    }
    
    [self resizingView];
    finishRequestComment = YES;
    [self.navigationItem.rightBarButtonItem setEnabled:[self requestFinish]];
}


#pragma mark - UIWebView delegate method
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self resizingView];
    finishRequestWebView = YES;
    [self.navigationItem.rightBarButtonItem setEnabled:[self requestFinish]];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}


#pragma mark - ADBannerView delegate methods

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{

}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{

}



@end
