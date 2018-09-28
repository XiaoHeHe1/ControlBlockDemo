//
//
//  BlockPickerView.m
//
//  Created by yfc on 16/8/26.
//
//

#import "BlockPickerView.h"
#import "config.h"
@implementation BlockPickerView

-(instancetype)initWithFrame:(CGRect)frame doneAction:(PickerBlock)block{
    if (self = [super initWithFrame:frame]) {
        //
        //确定取消按钮下面的白条+紫条
        //
        UIImageView *purpleLineView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH_NEW, 45)];
        purpleLineView.backgroundColor = [UIColor redColor];
        purpleLineView.userInteractionEnabled = YES;
        //
        //取消
        //
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton  setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.frame = CGRectMake(10, 5, 63, 32);
        //
        //确定
        //
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(250, 6, 63, 34);
        rightButton.right = SCREEN_WIDTH_NEW - 10;
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitle:@"确定" forState:UIControlStateNormal];
        
        [purpleLineView addSubview:cancelButton];
        [purpleLineView addSubview:rightButton];
        //
        //选取框
        //
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH_NEW, 180)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];

        //是否展示中间的选中状态
        _pickerView.showsSelectionIndicator = YES;

        [self addSubview:purpleLineView];
        [self addSubview:_pickerView];
        
        
        self.pickerBlock = block;


    }
    return self;
}
//确定按钮
- (void)doneAction:(id)sender
{
    NSInteger row = [_pickerView selectedRowInComponent:0];
    self.pickerBlock(pickerArray[row]);
    [self cancelAction:nil];
}
//取消按钮
- (void)cancelAction:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = self.frame;
        rect.origin.y  = SCREEN_HEIGHT_NEW;
        self.frame = rect;
    } completion:^(BOOL finished) {
        [self.backGroundview removeFromSuperview];
        //
        //这行如果不写，此控件将不会被释放.如果不写延迟，则没有下收的效果
        //
        [self removeFromSuperview];
    }];
    
}
- (void)show;{
    kWeakObject(self);
    
    if (!_backGroundview) {
        _backGroundview = [[UIView alloc]initWithFrame:APPLICATION.window.bounds];
        _backGroundview.backgroundColor = [UIColor blackColor];
        _backGroundview.alpha = 0.5;
        [_backGroundview setTapActionWithBlock:^{
            [weakObject cancelAction:nil];
        }];
    }
    _backGroundview.userInteractionEnabled = NO;
    [APPLICATION.window addSubview:_backGroundview];
    
    
    [APPLICATION.window addSubview:self];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = self.frame;
        rect.origin.y  = SCREEN_HEIGHT_NEW - self.frame.size.height;
        self.frame = rect;
    } completion:^(BOOL finished) {
        _backGroundview.userInteractionEnabled = YES;
        
    }];

}


- (void)setDataSource:(NSDictionary *)dic;
{
    if(((NSArray*)[dic objectForKey:@"array"]).count > 0){
        NSLog(@"不是空数组");
        pickerArray = [[NSArray alloc]initWithArray:[dic objectForKey:@"array"]];
        
    }else{
        NSLog(@"是空数组");
        
    }
    [_pickerView reloadAllComponents];

}

-(void)dealloc{
    NSLog(@"PublicPickerView dealloc");

//    [pickerArray release];
//    [_backGroundview release];
//    [_pickerView release];
//    [super dealloc];
}
#pragma mark - pickerdelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return pickerArray.count;
}
//- (NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    //这个不居中
//    return [pickerArray[row] objectForKey:@"valueForShow"];
//}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *viewToUse = nil;
    if (component == 0)
    {
        NSString *text = [pickerArray[row] objectForKey:@"valueForShow"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 260.0, 40.0)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = text;
        label.font = [UIFont boldSystemFontOfSize:18.0];
        
        
        return label;
    }
    return viewToUse;
}

@end
