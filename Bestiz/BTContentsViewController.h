//
//  IFContentsViewController.h
//  Bestiz
//
//  Created by Shin Bumcheol on 12/21/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTListViewController.h"

@interface BTContentsViewController : BTListViewController <UITextViewDelegate, BTRequesterDelegate>
{
    UITextView *textView;
    BTBoardIndex *boardIndex;
    NSString *harfURL;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) BTBoardIndex *boardIndex;
@property (nonatomic, retain) NSString *harfURL;

@end
