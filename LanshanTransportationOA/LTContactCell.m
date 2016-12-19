//
//  LTContactCell.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/19.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTContactCell.h"

@implementation LTContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        
        //名字
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(32, 8, 200, 25)];
        _nameLabel.backgroundColor  = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        
        _selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_MainScreen_Width-48, 11, 18, 18)];
        [self.contentView addSubview:_selectImageView];
        
        //分割线
        UIView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(32, 39, _MainScreen_Width-32, 1)];
        [lineView setBackgroundColor:[UIColor colorWithRed:232/255.f green:232/255.f blue:232/255.f alpha:1.0]];
        [self.contentView addSubview:lineView];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
