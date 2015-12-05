//
//  ShareActivity.m
//  iDuShare
//
//  Created by duxinfeng on 14-5-7.
//  Copyright (c) 2014年 新风作浪. All rights reserved.
//

#import "PopView.h"
#define WINDOW_COLOR    [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define kThemeGreenColor [UIColor colorWithRed:68/255.0f green:197/255.0f blue:210/255.0f alpha:1]
#define DF_COLOR(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]

#define ANIMATE_DURATION    0.3f
#define NOW_HEIGHT(a) (a.frame.origin.y + a.frame.size.height+1)
#define BTNTAG 3

@interface PopView ()


@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,assign) CGFloat activityHeight;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,assign) NSInteger selectedId;


@end

@implementation PopView

-(instancetype)initFundTypePopViewWithY:(NSInteger)origonY andTitles:(NSArray *)titleArray
{
    self = [super init];
    if (self) {
        //初始化背景视图，添加手势
        self.alpha = 0.0f;
        self.frame = CGRectMake(0, origonY, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-origonY);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        self.titleArray = titleArray;
        [self configPopView];
    }
    return self;

}

-(void)configPopView
{
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
  //self.backGroundView.backgroundColor = [UIColor whiteColor];
    self.backGroundView.backgroundColor = [[UIColor alloc] initWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
    self.backGroundView.clipsToBounds = YES;
    [self addSubview:self.backGroundView];
    float leftX = 0;
    float upY = 0;
    float wideR = 55;
    float highR = 40;
    float spaceX = 0.5;
    float spaceY = 0.5;
    int row = 2;
    
    NSInteger screen_W = [UIScreen mainScreen].bounds.size.width;
     
    if (screen_W==375) {
        wideR  = (screen_W-2*leftX-3*spaceX)/2;
    }else if (screen_W==414){
        row=4;
        wideR  = (screen_W-2*leftX-4*spaceX)/4;
    }else{
        wideR  = (screen_W-2*leftX-3*spaceX)/2;
    }
    for (int i = 0; i < self.titleArray.count; i++) {
        int nowrow = i%row;
        int nowline = i/row;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
        button.tag = BTNTAG + i;
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitle:self.titleArray[i] forState:UIControlStateHighlighted];
        //       UIColor *color =[[UIColor alloc]initWithRed:0/255.0 green:90/255.0 blue:255/255.0 alpha:1.0];
        UIFont *font = [UIFont systemFontOfSize:14];
        button.titleLabel.font = font;
        button.frame = CGRectMake(leftX+(wideR+spaceX)*nowrow, upY+(highR+spaceY)*nowline, wideR, highR);
        if (![self.titleArray[i] isEqualToString:@""]) {
            [button addTarget:self action:@selector(more_sub_Click:) forControlEvents:UIControlEventTouchUpInside];    
        }
        [self.backGroundView addSubview:button];
        button.titleLabel.text = self.titleArray[i];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor: [UIColor whiteColor]] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:0/255.0 green:130/255.0 blue:255/255.0 alpha:1.0f]] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
         self.activityHeight = NOW_HEIGHT(button);
    }        

}


- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)more_sub_Click:(UIButton *)sender
{   
    
    
    self.selectedId = sender.tag;
    [self tappedCancel];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popViewSelectedIndex" object:[NSString stringWithFormat:@"%ld",(long)self.selectedId ]];
}

- (void)show
{   
    
    [[UIApplication sharedApplication].delegate.window addSubview:self];
      [UIView animateWithDuration:ANIMATE_DURATION animations:^{
      self.alpha = 1.0f;
      [self.backGroundView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.activityHeight)];
          
    } completion:^(BOOL finished) {
        if (finished) {
                  }
 
    }];
}

- (void)tappedCancel
{   
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0.0f;
         } completion:^(BOOL finished) {
        if (finished) {
        [self removeFromSuperview];
        }
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popViewCancel" object:nil];
}

@end


