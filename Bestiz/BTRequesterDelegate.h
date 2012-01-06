//
//  BTRequesterDelegate.h
//  Bestiz
//
//  Created by Shin Bumcheol on 12/5/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

@protocol BTRequesterDelegate
@optional
- (void)requestFinishedWithResults:(NSMutableArray *)results tag:(NSInteger)tag;
@end