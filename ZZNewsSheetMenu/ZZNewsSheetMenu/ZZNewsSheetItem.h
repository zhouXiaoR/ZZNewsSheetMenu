//
//  ZZNewsSheetItem.h
//  ZZNewsSheetMenu
//
//  Created by 周晓瑞 on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZZCornerFlagTypeNone = 0,
    ZZCornerFlagTypeDelete = 1,
    ZZCornerFlagTypeAddition = 2,
    ZZCornerFlagTypeCustom = 3,
} ZZCornerFlagType;

@class ZZNewsSheetItem;

typedef void(^ZZLongItemPressBlock)(UILongPressGestureRecognizer *ges);
typedef void(^ZZItemCloseBlock)(ZZNewsSheetItem *item);

@interface ZZNewsSheetItem : UIView

@property(nonatomic,assign,getter=isGestureEnable)BOOL longGestureEnable;
@property(nonatomic,copy)ZZLongItemPressBlock longPressBlock;
@property(nonatomic,copy)ZZItemCloseBlock itemCloseBlock;
@property(nonatomic,copy)NSString *itemTitle;
@property(nonatomic,assign)BOOL cornerFlagHidden;
@property(nonatomic,assign)ZZCornerFlagType flagType;
@end
