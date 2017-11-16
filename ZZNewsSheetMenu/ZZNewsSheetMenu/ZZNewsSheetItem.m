//
//  ZZNewsSheetItem.m
//  ZZNewsSheetMenu
//
//  Created by 周晓瑞 on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ZZNewsSheetItem.h"
#import "ZZNewsSheetConfig.h"
static NSTimeInterval const kAnimationItemDuration = 0.25f;

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
    CGSize size = [ZZNewsSheetConfig defaultCofing].sheetItemSize;
    CGFloat buttonWidth = size.width / 3.0;
    CGFloat buttonHeight = size.width / 3.0;
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
    
     BOOL isShakeAnimation = [ZZNewsSheetConfig defaultCofing].isShakeAnimation;
    if (self.flagType == ZZCornerFlagTypeDelete) {
        if (isShakeAnimation) {
            [self startShakeAnimation];
        }
    }else{
        if (isShakeAnimation) {
             [self removeAnimation];
        }
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
    BOOL isShakeAnimation = [ZZNewsSheetConfig defaultCofing].isShakeAnimation;
    NSTimeInterval animationDuration = isShakeAnimation ? kAnimationItemDuration : 0.0f;
    if (hidden) {
        [UIView animateWithDuration:animationDuration animations:^{
            self.closeButton.alpha = 0.0f;
        } completion:^(BOOL finished) {
            if (isShakeAnimation) {
                 [self removeAnimation];
            }
        }];
    }else{
        [UIView animateWithDuration:animationDuration animations:^{
            self.closeButton.alpha = 1.0f;
        } completion:^(BOOL finished) {
            if (self.flagType == ZZCornerFlagTypeDelete) {
                if (isShakeAnimation) {
                     [self startShakeAnimation];
                }
            }
        }];
    }
}

- (void)removeAnimation{
    [self.layer removeAllAnimations];
}

- (void)startShakeAnimation{
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    shakeAnimation.values = @[@(-0.06),@0.06,@(-0.06)];
    
    CGFloat timeArc = (arc4random() % 9 + 1 ) * 0.01;
    shakeAnimation.timeOffset = [self.layer convertTime:CACurrentMediaTime()+timeArc 
                                                toLayer:nil];
    
    shakeAnimation.duration = 0.2f;
    shakeAnimation.fillMode = kCAFillModeForwards;
    shakeAnimation.repeatCount = HUGE_VAL;
    shakeAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:shakeAnimation forKey:@"shake"];
}

#pragma mark - SetUp
- (void)defaultConfig{
    self.backgroundColor = [ZZNewsSheetConfig defaultCofing].sheetBackgroundColor;
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
    tLab.textColor = [ZZNewsSheetConfig defaultCofing].sheetItemTitleColor;
    tLab.font = [ZZNewsSheetConfig defaultCofing].sheetItemFont;
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
    closeButton.backgroundColor = [ZZNewsSheetConfig defaultCofing].closeBackgroundColor;
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
