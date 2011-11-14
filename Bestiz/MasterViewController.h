//
//  MasterViewController.h
//  Bestiz
//
//  Created by Bumcheol Shin on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTMLParser.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController
{
    NSString *urlString;
    NSString *hrefString;
    
    NSMutableArray *hrefData;
    NSMutableArray *titleData;
}

@property (nonatomic, retain) NSString *urlString;
@property (nonatomic, retain) NSString *hrefString;
@property (strong, nonatomic) DetailViewController *detailViewController;

@end
