//
//
//  BlockPickerView.h
//
//  Created by yfc on 16/8/26.
//
//

#import <UIKit/UIKit.h>

typedef void(^PickerBlock)(id result);

@interface BlockPickerView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>{
    NSArray                                 *pickerArray;
}
@property(nonatomic,copy)UIView             *backGroundview;
@property(nonatomic,copy)PickerBlock        pickerBlock;
@property(nonatomic,retain)UIPickerView     *pickerView;

- (instancetype)initWithFrame:(CGRect)frame doneAction:(PickerBlock)block;

- (void)show;
- (void)setDataSource:(NSDictionary *)dic;

@end
