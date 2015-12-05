//
//  CustomSegmentControl.h
//  CustomSegmentControl
//
//  Created by huangzq on 15/10/23.
//  Copyright © 2015年 bios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopView.h"
typedef enum {
    EnumArrowUpType,
    EnumArrowdownType,
}ArrowState;
@protocol SegmentSelectedAtIndexDelegate
-(void) selectedAtIndex:(NSInteger) index;
@end
@interface CustomSegmentControl : UISegmentedControl
@property (nonatomic ,assign) id<SegmentSelectedAtIndexDelegate> delegate;
@property (nonatomic ,strong) UIButton* otherSegmentItemButton;
@property (nonatomic ,strong) PopView *popView;
@property (nonatomic ,strong) UIImageView *imageViewArrow;
@property (nonatomic ,assign) ArrowState arrowState;
@property (nonatomic ,strong) NSArray *titles;
@property (nonatomic ,assign) NSInteger selectedTitltIndex;
@property (nonatomic ,strong) UIView *theview;
-(instancetype) initWithFrame:(CGRect)frame titles:(NSArray*)titles subView:(UIView*)view;



@end
