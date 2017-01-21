//
//  ViewController.m
//  CustomSegmentControl
//
//  Created by huangzq on 15/10/23.
//  Copyright © 2015年 bios. All rights reserved.
//

#import "ViewController.h"
#import "CustomSegmentControl.h"

@interface ViewController ()<SegmentSelectedAtIndexDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *titleArray = [NSArray arrayWithObjects:@"日涨跌",@"一月",@"一年",@"今年",@"三年以来",@"成立以来",@"今年以来", nil];
    CustomSegmentControl *segmentCtrl = [[CustomSegmentControl alloc] initWithFrame:CGRectMake(20, 100, 300, 35) titles:titleArray subView:self.view];
    segmentCtrl.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)selectedAtIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);

}

@end
