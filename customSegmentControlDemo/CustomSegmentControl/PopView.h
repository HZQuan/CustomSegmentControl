//
//  ShareActivity.h
//  iDuShare
//
//  Created by duxinfeng on 14-5-7.
//  Copyright (c) 2014年 新风作浪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopView : UIView
@property (nonatomic ,copy) NSString *selectedType;

-(instancetype)initFundTypePopViewWithY:(NSInteger) origonY andTitles:(NSArray*)titleArray;
- (UIImage *)imageWithColor:(UIColor *)color;
-(void)configPopView;
-(void)show;
- (void)tappedCancel;
@end


