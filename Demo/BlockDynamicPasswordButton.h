//
//
//  BlockDynamicPasswordButton.h
//
//  Created by yfc on 16/8/29.
//
//

#import <UIKit/UIKit.h>
typedef void(^DynamicBtnBlock)(int touchUpNum);
@interface BlockDynamicPasswordButton : UIButton{
    int         limmit;             //记录秒数
    int         countDownNum;       //点击的次数
    int         maxCountDownNum;    //能够点击总次数
    int         timeInterval;       //时间间隔
}
@property(nonatomic,copy)DynamicBtnBlock    dynamicBtnBlock;
@property(nonatomic,retain)NSTimer          *timer_;

-(instancetype)initWithFrame:(CGRect)frame andMaxTouchDownNum:(int)countDownNum_ andTimeInterval:(int)limit_ andClickedAction:(DynamicBtnBlock)block;

@end
