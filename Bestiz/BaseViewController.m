//
//  BaseViewController.m
//  Bestiz
//
//  Created by Bumcheol Shin on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)initializeBoardIndexData
{
    NSString *gHeaven = @"게스트 천국";
    NSString *gHeavenURL = [boardIndex urlOfBoard:BoardCategoryGuestHeaven boardType:BoardTypeList];
    NSString *gChatter = @"게천잡담";
    NSString *gChatterURL = [boardIndex urlOfBoard:BoardCategoryGuestChatter boardType:BoardTypeList];
    NSString *gSpring = @"게잡의 봄";
    NSString *gSpringURL = [boardIndex urlOfBoard:BoardCategoryGuestSpring boardType:BoardTypeList];
    NSString *gSummer = @"게잡의 여름";
    NSString *gSummerURL = [boardIndex urlOfBoard:BoardCategoryGuestSummer boardType:BoardTypeList];
    
    BoardIndex *guestHeavenIndex = [[BoardIndex alloc] initWithNameOfBoard:gHeaven urlOfBoard:gHeavenURL typeOfGuest:GuestTypeHeaven];
    BoardIndex *guestChatterIndex = [[BoardIndex alloc] initWithNameOfBoard:gChatter urlOfBoard:gChatterURL typeOfGuest:GuestTypeChatter];
    BoardIndex *guestSpringIndex = [[BoardIndex alloc] initWithNameOfBoard:gSpring urlOfBoard:gSpringURL typeOfGuest:GuestTypeChatter];
    BoardIndex *guestSummerIndex = [[BoardIndex alloc] initWithNameOfBoard:gSummer urlOfBoard:gSummerURL typeOfGuest:GuestTypeChatter];
    
    boardIndexData = [[NSArray arrayWithObjects:guestHeavenIndex, guestChatterIndex, guestSpringIndex, guestSummerIndex, nil] retain];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        boardIndex = [[BoardIndex alloc] init];
        
        [self initializeBoardIndexData];
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [boardIndex release];
    [boardIndexData release];
    
    [super dealloc];
}

@end
