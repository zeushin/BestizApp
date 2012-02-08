//
//  BaseViewController.h
//  Bestiz
//
//  Created by Bumcheol Shin on 11/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "BTBoardIndex.h"
#import "BestizParser.h"
#import "BTRequesterDelegate.h"

#define SHOW_BANNER 0

const static CGFloat kFontSize = 12.0f;

@interface BTBaseViewController : UIViewController <ADBannerViewDelegate>
{
    BOOL bannerIsVisible;
    NSOperationQueue *requestQueue;
}

@property (nonatomic, assign) BOOL bannerIsVisible;
@property (nonatomic, retain) NSOperationQueue *requestQueue;

@end
