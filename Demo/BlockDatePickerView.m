//
//
//   BlockDatePickerView.m
//
//  Created by yfc on 16/8/27.
//
//

#import "BlockDatePickerView.h"
#import "config.h"
@implementation BlockDatePickerView

- (id)initWithFrame:(CGRect)frame {
    
//    frame.origin.y = [GlobalVariables sharedGlobalVariables].Screen_Height;
    
    if(self = [super initWithFrame:frame]){
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        datePicker_ = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 40.0, SCREEN_WIDTH_NEW, 180)];
        datePicker_.datePickerMode = UIDatePickerModeDate;
        datePicker_.timeZone = [NSTimeZone systemTimeZone];
        [self addSubview:datePicker_];
        
        UIImageView *bar = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH_NEW, 45.0)];
        bar.backgroundColor = [UIColor redColor];
        [self addSubview:bar];
//        [bar release];
        
        UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        
        [confirmButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        confirmButton.frame = CGRectMake(251, 6, 63, 34);
        confirmButton.right = SCREEN_WIDTH_NEW - 10;
        [self addSubview:confirmButton];
//        [confirmButton release];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton  setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.frame = CGRectMake(10, 6, 63, 34);
        [self addSubview:cancelButton];
//        [cancelButton release];
    }
    return self;
}
//确定按钮
- (void)doneAction:(id)sender
{
//    NSString *dateString = [NSString stringWithFormat:@"%@",datePicker_.date];
//    dateString = [dateString substringToIndex:10];
//    
//    self.datePickerBlock(dateString);
//    [self cancelAction:nil];
    
    
    
    
    //20161108 生活 3 testin
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:datePicker_.date];
    NSInteger iYear    = [comps year];
    NSInteger imonth   = [comps month];
    NSInteger iDay     = [comps day];
    NSString *dateString = [NSString stringWithFormat:@"%4ld-%02ld-%02ld",(long)iYear,(long)imonth,(long)iDay];
    self.datePickerBlock(dateString);
    [self cancelAction:nil];
}
//取消按钮
- (void)cancelAction:(UIButton *)sender
{
    [backGroundview removeFromSuperview];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    CGRect rect = self.frame;
    rect.origin.y  = SCREEN_HEIGHT_NEW;
    self.frame = rect;
    
    [UIView commitAnimations];
}
- (void)show{
    kWeakObject(self);
    
    if (!backGroundview) {
        backGroundview = [[UIView alloc]initWithFrame:APPLICATION.window.bounds];
        backGroundview.backgroundColor = [UIColor blackColor];
        backGroundview.alpha = 0.5;
        [backGroundview setTapActionWithBlock:^{
            [weakObject cancelAction:nil];
        }];
    }
    
    [APPLICATION.window addSubview:backGroundview];
    
    [APPLICATION.window addSubview:self];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    
    CGRect rect = self.frame;
    rect.origin.y  = SCREEN_HEIGHT_NEW - self.height;
    self.frame = rect;
    
    [UIView commitAnimations];

}
- (void)setDoneAction:(DatePickerBlock)block;
{

    self.datePickerBlock = block;
}

-(void)dealloc{
    NSLog(@"PublicDatePickerView  dealloc");

//    [backGroundview release];
//    [datePicker_ release];
//    [super dealloc];
}
@end
