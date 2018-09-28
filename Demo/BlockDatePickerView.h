//
//   
//   BlockDatePickerView.h
//
//  Created by yfc on 16/8/27.
//
//

#import <UIKit/UIKit.h>
typedef void(^DatePickerBlock)(id result);

@interface BlockDatePickerView : UIView{
    UIView          *backGroundview;
    UIDatePicker    *datePicker_;
}
@property(nonatomic,copy)DatePickerBlock datePickerBlock;

- (void)show;
- (void)setDoneAction:(DatePickerBlock)block;
@end
