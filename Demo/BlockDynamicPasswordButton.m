//
//
//  BlockDynamicPasswordButton.m
//
//  Created by yfc on 16/8/29.
//
//

#import "BlockDynamicPasswordButton.h"

@implementation BlockDynamicPasswordButton

@synthesize timer_;

-(instancetype)initWithFrame:(CGRect)frame andMaxTouchDownNum:(int)countDownNum_ andTimeInterval:(int)limit_ andClickedAction:(DynamicBtnBlock)block{
    if (self = [super initWithFrame:frame]) {
        
        maxCountDownNum = countDownNum_;
        timeInterval = limit_;
        
        self.dynamicBtnBlock = block;
        
        UIImage *bimage = [UIImage imageNamed:@"btn.png"];
        [self setBackgroundImage: bimage forState:UIControlStateNormal];
        [self setBackgroundImage: bimage forState:UIControlStateDisabled];
        
        [self setTitle:@"获取动态密码" forState:UIControlStateNormal];
        [self setTitle:@"获取中..." forState:UIControlStateDisabled];

        self.titleLabel.font = [UIFont systemFontOfSize: 12];
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];

        self.enabled = YES;

        
        [self addTarget:self action:@selector(dynamicPasswordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //记录点击的次数
        countDownNum = 0;
        //记录秒数
        limmit = 0;
        
    }
    return self;
}
- (void) dynamicPasswordButtonAction:(UIButton *)btn{

    [self setTitle:@"重新发送" forState:UIControlStateNormal];

    self.enabled = NO;
    

    countDownNum += 1;
    
    self.dynamicBtnBlock(countDownNum);
    
    if(!self.timer_){
        NSTimeInterval timeInterval2 = 1.0;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval2 target:self selector:@selector(timerAction:) userInfo:self repeats:YES];
        self.timer_ = timer;
    }else{
        //开启定时器
        [self.timer_ setFireDate:[NSDate distantPast]];
    }
    
}

- (void) timerAction:(id)sender{


    //-1因为1秒后才开的定时器
    if (timeInterval-1-1 >= limmit  ) {
        NSLog(@"%ld秒后可以继续操作",timeInterval-(long)limmit  -1) ;
        
        limmit+=1;
    }else{
        limmit = 0;
        NSLog(@"可以点了");
        // 计时器可以停了
        if (timer_) {
            //关闭定时器
            [timer_ setFireDate:[NSDate distantFuture]];
   
        }

        if (countDownNum >= maxCountDownNum) {
            UIImage *bimage = [UIImage imageNamed:@"pagebuttondisable.png"];
            [self setBackgroundImage:bimage forState:UIControlStateDisabled];
            [self setTitle:@"" forState:UIControlStateDisabled];
            return;
        }
        
        
        self.enabled = YES;
        
    }
    
}
-(void)dealloc{
    NSLog(@" PublicDynamicPasswordButton dealloc");

//    [timer_ release];
//    [super dealloc];
}

@end
