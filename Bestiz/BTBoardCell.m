//
//  BTBoardCell.m
//  Bestiz
//
//  Created by Shin Bumcheol on 12/29/11.
//  Copyright (c) 2011 BananaWiki. All rights reserved.
//

#import "BTBoardCell.h"

@implementation BTBoardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
