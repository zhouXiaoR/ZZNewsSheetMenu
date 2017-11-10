//
//  ZZNewsSheetMenu.h
//  ZZNewsSheetMenu
//
//  Created by 周晓瑞 on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZNewsSheetMenu : UIView

+(instancetype)newsSheetMenu;

@property(nonatomic,assign)BOOL hiddenAllCornerFlag;
@property(nonatomic,strong)NSMutableArray<NSString *> *mySubjectArray;
@property(nonatomic,strong)NSMutableArray<NSString *> *recommendSubjectArray;

-(void)showNewsMenu;
- (void)dismissNewsMenu;
@end
