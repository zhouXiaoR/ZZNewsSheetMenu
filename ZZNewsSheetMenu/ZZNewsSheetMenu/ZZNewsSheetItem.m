//
//  ZZNewsSheetItem.m
//  ZZNewsSheetMenu
//
//  Created by 周晓瑞 on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ZZNewsSheetItem.h"

@interface ZZNewsSheetItem()
@property(nonatomic,weak)UIButton *closeButton;
@property(nonatomic,weak)UILabel *itemTitleLab;
@end

@implementation ZZNewsSheetItem

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUp];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonWidth = 20;
    CGFloat buttonHeight =20;
    self.closeButton.frame = CGRectMake(self.frame.size.width - 0.8 * buttonWidth, -0.3 * buttonWidth, buttonWidth, buttonHeight);
    self.closeButton.layer.cornerRadius = buttonWidth / 2.0f;
    self.itemTitleLab.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

- (void)setFlagType:(ZZCornerFlagType)flagType{
    _flagType = flagType;
    
    if (flagType == ZZCornerFlagTypeNone) {
        self.closeButton.hidden = YES;
        return;
    }
    
    NSString * title = self.cornerFlagDictionary[[NSString stringWithFormat:@"%d",(int)flagType]];
    self.closeButton.hidden = NO;
    [self.closeButton setTitle:title forState:UIControlStateNormal];
}

- (void)setItemTitle:(NSString *)itemTitle{
    _itemTitle = [itemTitle copy];
    self.itemTitleLab.text = itemTitle;
}
- (void)setCornerFlagHidden:(BOOL)cornerFlagHidden{
    _cornerFlagHidden = cornerFlagHidden;
    
    self.longGestureEnable = !cornerFlagHidden;
    if (self.flagType != ZZCornerFlagTypeDelete) {
        self.longGestureEnable = NO;
    }
    
    [self commintAnimation:cornerFlagHidden];
}

- (void)commintAnimation:(BOOL)hidden{
    // self.closeButton.hidden = cornerFlagHidden;
    if (hidden) {
        [UIView animateWithDuration:0.15 animations:^{
            self.closeButton.alpha = 0.0f;
        }];
    }else{
        [UIView animateWithDuration:0.15 animations:^{
            self.closeButton.alpha = 1.0f;
        }];
    }
}

#pragma mark - SetUp
- (void)defaultConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 4.0f;
}
- (void)setUp{
    [self defaultConfig];
    [self addTipsLab];
    [self addCloseButton];
    [self addLongPanGesture];
}
- (void)addTipsLab{
    UILabel *tLab = [[UILabel alloc]init];
    tLab.textColor = [UIColor whiteColor];
    tLab.font = [UIFont systemFontOfSize:10];
    tLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:tLab];
    self.itemTitleLab = tLab;
}

- (void)addCloseButton{
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitle:@"X" forState:UIControlStateNormal];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [closeButton addTarget:self action:@selector(zz_close) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    self.closeButton = closeButton;
    closeButton.backgroundColor = [UIColor grayColor];
}

- (void)addLongPanGesture{
    UILongPressGestureRecognizer * ges = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPanGesture:)];
    [self addGestureRecognizer:ges];
    self.longGestureEnable = YES;
}

- (NSDictionary *)cornerFlagDictionary{
    return @{
        @"1":@"x",
        @"2":@"+"
        };
}

#pragma mark -  事件处理
- (void)longPanGesture:(UILongPressGestureRecognizer*)ges{
    if (!self.isGestureEnable) 
        return;
    
    if (self.longPressBlock) {
        self.longPressBlock(ges);
    }
}

- (void)zz_close{
    if (self.itemCloseBlock) {
        self.itemCloseBlock(self);
    }
}



@end
