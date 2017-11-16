//
//  ZZNewsSheetConfig.h
//  ZZNewsSheetMenu
//
//  Created by 周晓瑞 on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZZNewsSheetConfig : NSObject

+(instancetype)defaultCofing;

@property(nonatomic,assign)NSInteger sheetMaxColumn;

@property(nonatomic,assign)CGSize   sheetItemSize;

@property(nonatomic,strong)UIColor *sheetItemTitleColor;

@property(nonatomic,strong)UIFont *sheetItemFont;

@property(nonatomic,strong)UIColor *sheetBackgroundColor;

@property(nonatomic,assign)BOOL      isShakeAnimation;

@property(nonatomic,strong)UIColor *closeBackgroundColor;

@property(nonatomic,assign)BOOL     isHiddenWhenHasNoneRecomment;

@end
