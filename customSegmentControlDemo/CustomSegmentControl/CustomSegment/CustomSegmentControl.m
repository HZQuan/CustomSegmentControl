//
//  CustomSegmentControl.m
//  CustomSegmentControl
//
//  Created by huangzq on 15/10/23.
//  Copyright © 2015年 bios. All rights reserved.
//

#import "CustomSegmentControl.h"
@implementation CustomSegmentControl
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles subView:(UIView *)view
{   
    
    self = [[CustomSegmentControl alloc] initWithFrame:frame];
    if (self) {
        for (int i = 0; i <= 2; i++) {
            [self insertSegmentWithTitle:titles[i] atIndex:i animated:NO];
        } 
        [self insertSegmentWithTitle:@"其他" atIndex:3 animated:NO];
        CGSize size = [@"其他" boundingRectWithSize:CGSizeMake(100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]}  context:nil].size;
        [self setWidth:size.width + 26 forSegmentAtIndex:3];
    }
    self.theview = view;
    [self addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.otherSegmentItemButton = button;
    int x = frame.origin.x+(frame.size.width)*3/4;
    int y = frame.origin.y;
    int width = frame.size.width* 1/4;
    int height = frame.size.height ;
    button.frame = CGRectMake(x, y, width, height);
    [view addSubview:self];
    [view addSubview:button];
    
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessageFromPopViewCancel:) name:@"popViewCancel" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessageFromPopViewIndexChange:) name:@"popViewSelectedIndex" object:nil];
    self.titles = titles;
    _imageViewArrow = [[UIImageView alloc] init];
    _imageViewArrow.image = [UIImage imageNamed:@"up"];
    [view addSubview: _imageViewArrow];
    [self initArrowWithFrame:frame andView:view];
    self.arrowState = EnumArrowdownType;
    int popviewheight = button.frame.origin.y+button.frame.size.height+2;
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    for (int i = 3; i < titles.count; i++) {
        [titleArray addObject:[titles objectAtIndex:i]];
    }
    PopView *popView = [[PopView alloc] initFundTypePopViewWithY:popviewheight andTitles:titleArray];
    self.popView = popView;
    return self;
}

-(void) initArrowWithFrame:(CGRect) frame andView:(UIView*)view
{   
    CGSize size = [self contentOffsetForSegmentAtIndex:3];
    NSLog(@"----------------%f,%f",size.width,size.height);
    int arrowX = frame.origin.x + frame.size.width - 16;
    int arrowY = self.frame.origin.y + (frame.size.height - 8)/2;
    _imageViewArrow.frame = CGRectMake(arrowX, arrowY, 10, 8);
    int x = frame.origin.x + (frame.size.width) * 3/4;
    int y = frame.origin.y;
    int width = frame.size.width * 1/4;
    int height = frame.size.height;
    self.otherSegmentItemButton.frame = CGRectMake(x, y, width, height);


}

-(void) receiveMessageFromPopViewIndexChange:(NSNotification *)notification
{   
    [self.delegate selectedAtIndex:[notification.object intValue]];
    NSString *title = [self.titles objectAtIndex:[notification.object intValue]];
    CGSize size = [title boundingRectWithSize:CGSizeMake(100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingUsesDeviceMetrics|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]}  context:nil].size;
    [self setWidth:size.width + 26 forSegmentAtIndex:3];
    [self setTitle:title forSegmentAtIndex:3];
    [self initArrowWithFrame:self.frame andView:self.theview];
}

-(void)receiveMessageFromPopViewCancel:(NSNotification *)notification
{
    self.userInteractionEnabled = YES;
    [self changeArrowRotation];
}
-(void) segmentChange:(UISegmentedControl*) segmentControl;
{
    [self.delegate selectedAtIndex:segmentControl.selectedSegmentIndex];
}

-(void) click:(id) sender
{   
    self.userInteractionEnabled = NO;
    self.selectedSegmentIndex = 3;
      if (self.arrowState == EnumArrowdownType) {
        [self changeArrowRotation];
        [self.popView show];
    }else{
        [self.popView tappedCancel];
    }
}

-(void) changeArrowRotation
{
    if (self.arrowState == EnumArrowdownType) {
        self.arrowState = EnumArrowUpType;
        CAKeyframeAnimation *animation=[CAKeyframeAnimation animation];  
        //设置属性值  
        animation.values = @[@0,@-M_PI_2,@-M_PI];
        animation.duration = 0.3;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        //把关键帧添加到layer中  
        [self.imageViewArrow.layer addAnimation:animation forKey:@"transform.rotation.z"];  
    
        }else{
            self.arrowState = EnumArrowdownType;
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            //设置属性值  
            animation.values = @[@-M_PI,@-M_PI_2,@0];
            animation.duration = 0.3;
            animation.fillMode = kCAFillModeForwards;
            animation.removedOnCompletion = NO;
            //把关键帧添加到layer中  
            [self.imageViewArrow.layer addAnimation:animation forKey:@"transform.rotation.z"];  
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
