//
//  ViewController.m
//  侧滑视图demo
//
//  Created by xxzx on 15/6/25.
//  Copyright (c) 2015年 hxyxt. All rights reserved.
//京东详情页规格按钮特效

#import "ViewController.h"
#import "UIView+YH.h"
// 2.获得RGB颜色
#define Color(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define mainwidth   self.view.frame.size.width
#define mainheight  self.view.frame.size.height

@interface ViewController ()

@property (nonatomic,strong)UIView *sideslipView;
@property (nonatomic,strong)UIView *bg;
//侧拉视图距离左边的距离
@property (nonatomic,assign)CGFloat distance;
//侧拉视图的宽度
@property (nonatomic,assign)CGFloat sideslipView_W;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(50, 280, 250, 40)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"京东“规格”按钮演示" forState:UIControlStateNormal];
    
   [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   [button addTarget:self action:@selector(addview) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
    
    
    
}



- (void)addview
{
    //透明黑色背景
    UIView *bg = [[UIView alloc]initWithFrame:self.view.frame];
    bg.backgroundColor =Color(0, 0, 0,0.8);
    [self.view addSubview:bg];
     self.bg = bg;
   
    
    //侧拉视图距离左边的距离
    self.distance = 100;
    //侧拉视图的宽度
    self.sideslipView_W = mainwidth-100;
    
    self.sideslipView = [[UIView alloc]init];
    self.sideslipView.frame = CGRectMake(mainwidth, 0,  self.sideslipView_W, mainheight);
    self.sideslipView.backgroundColor = [UIColor blueColor];
    [self.view addSubview: self.sideslipView];
    
  
   
    [UIView animateWithDuration:0.2f animations:^{
    
    self.sideslipView.frame = CGRectMake(self.distance, 0, self.sideslipView_W, mainheight);

    }];
    
    [self.sideslipView addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(sideslipViewAnimate:)]];
    
}




// 用x来判断，用transform来控制
- (void)sideslipViewAnimate:(UIPanGestureRecognizer *)pan
{
 
     CGPoint point = [pan translationInView:pan.view];


    
    //结束拖拽
    if (pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateEnded) {
        if (pan.view.x >= self.distance+self.sideslipView_W * 0.5) { //往右边至少走动了本身的一半
          
            [UIView animateWithDuration:0.5 animations:^{
                self.bg.alpha = 0;
            
                pan.view.transform = CGAffineTransformMakeTranslation(self.sideslipView_W, 0);

            } completion:^(BOOL finished) {
                [self.sideslipView removeFromSuperview];
                [self.bg removeFromSuperview];
 
            }];
        } else {  //走动距离的没有达到本身一半
           
            [UIView animateWithDuration:0.4f animations:^{
                self.bg.alpha = 1;

                pan.view.transform = CGAffineTransformIdentity;
                
            }];
        }
    } else {      //正在拖拽中
        pan.view.transform = CGAffineTransformTranslate(pan.view.transform, point.x, 0);
        [pan setTranslation:CGPointZero inView:pan.view];
       
        //让拖动时背景黑板色渐变
        self.bg.alpha =1-(pan.view.x-self.distance)/self.sideslipView_W;

    
        if (pan.view.x >= mainwidth) {
            pan.view.transform = CGAffineTransformMakeTranslation(self.sideslipView_W, 0);
        } else if (pan.view.x <= _distance) {
            pan.view.transform = CGAffineTransformIdentity;
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  
   UITouch *touch = [touches anyObject];
    
    if ([touch.view isEqual:self.bg]) {
        
   
    [UIView animateWithDuration:0.4f animations:^{
           self.bg.alpha = 0;
        
            [self.sideslipView setFrame:CGRectMake(mainwidth, 0, self.sideslipView_W, mainheight)];
          
    } completion:^(BOOL finished) {
        
        if (finished == YES) {
         
         
            [self.sideslipView removeFromSuperview];
            [self.bg removeFromSuperview];

        }
              }];
   
    }
    
   
}



@end
