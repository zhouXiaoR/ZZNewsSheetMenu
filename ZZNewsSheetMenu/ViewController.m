//
//  ViewController.m
//  ZZNewsSheetMenu
//
//  Created by 周晓瑞 on 2017/11/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "ZZNewsSheetMenu.h"

@interface ViewController ()
@property(nonatomic,strong)ZZNewsSheetMenu *newsMenu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp{
    ZZNewsSheetMenu *sheetMenu = [ZZNewsSheetMenu newsSheetMenu];
    self.newsMenu = sheetMenu;
   sheetMenu.mySubjectArray = @[@"科技1",@"科技2",@"科技3",@"科技4",@"科技4"].mutableCopy;
   sheetMenu.recommendSubjectArray = @[@"体育",@"军事",@"音乐",@"电影",@"中国风",@"摇滚",@"小说",@"梦想",@"机器",@"电脑"].mutableCopy;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.newsMenu updateNewSheetConfig:^(ZZNewsSheetConfig *cofig) {
        cofig.sheetItemSize = CGSizeMake(40, 30);
    }];

     [self.newsMenu showNewsMenu];
}

@end
