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

@interface BTContentsViewController() {
@private
    
}

@property (nonatomic) CGFloat cellHeight;

- (void)resizingView;

@end

@implementation BTContentsViewController

@synthesize scrollView = _scrollView;
@synthesize webView = _webView;
@synthesize boardIndex = _boardIndex;
@synthesize harfURL = _harfURL;
@synthesize contentsData = _contentsData;
@synthesize cellHeight = _cellHeight;

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
    // Do any additional setup after loading the view from its nib.
    [self setTitle:_boardIndex.nameOfBoard];
    
//    [table setTableHeaderView:_webView];
    
    BTContents *contents = (BTContents *)[_contentsData lastObject];
    
    NSString *baseURL = [NSString stringWithFormat:@"%@/%@", [_boardIndex urlOfBoard:_boardIndex.boardCategory boardType:BoardTypeContents], _harfURL];

    [_webView loadHTMLString:contents.contents baseURL:[NSURL URLWithString:baseURL]];
    
    [_webView.scrollView setScrollEnabled:NO];
    
//    NSString *contentsString = [contents.contents stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    [_textView setText:contentsString];
//    [_textView setFont:[UIFont systemFontOfSize:kFontSize-1]];
    
    
    [BTComment getComment:_boardIndex.boardCategory url:_harfURL delegate:self];
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [_webView release];
    [_boardIndex release];
    [_harfURL release];
    [_contentsData release];
    [_scrollView release];
    
    [super dealloc];
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
    NSLog(@"webview: %@", _webView);
    NSLog(@"webviewContent : %f %f", _webView.scrollView.contentSize.width, _webView.scrollView.contentSize.height);
    
    // 테이블 크기를 테이블 컨텐츠 사이즈만큼 늘리고 웹뷰 밑에 붙임
    CGRect tableFrame = table.frame;
    tableFrame.size.height = table.contentSize.height;
    tableFrame.origin.y = _webView.frame.size.height;
    [table setFrame:tableFrame];
    NSLog(@"table: %@", table);
    
    // 웹뷰와 테이블뷰 사이즈 만큼 스크롤뷰의 컨텐츠 사이즈를 늘림
    CGSize size = _scrollView.contentSize;
    size.height = _webView.frame.size.height + table.frame.size.height;
    [_scrollView setContentSize:size];
    NSLog(@"scrollView: %f %f", _scrollView.contentSize.width, _scrollView.contentSize.height);
    

    
    [_scrollView reloadInputViews];
    [table reloadData];
}


#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell.textLabel setFont:[UIFont systemFontOfSize:kFontSize]];
        _cellHeight = cell.frame.size.height;
    }
    
    // Configure the cell...
    BTComment *comment = [data objectAtIndex:indexPath.row];
    cell.textLabel.text = comment.comment;
    
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

#pragma mark - BTRequesterDelegate method

- (void)requestFinishedWithResults:(NSMutableArray *)results tag:(NSInteger)tag
{
//    if (tag == BoardTypeContents) {
//        self.contentsData = results;
//        BTContents *contents = (BTContents *)[_contentsData lastObject];
//        NSString *contentsString = [contents.contents stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        [_textView setText:contentsString];
//        [self.navigationItem.rightBarButtonItem setEnabled:YES];
//        [self setTableHeaderViewFrame];
//    } else 
        if (tag == BoardTypeComment) {
        self.data = results;
        [table reloadData];
    }
    
    [self resizingView];
}

#pragma mark - UIWebView delegate method
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self resizingView];
}

@end
