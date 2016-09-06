//
//  CGPlusView.h
//  CGShoppingCartDemo
//
//  Created by ChrisGaptain on 16/9/6.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PlusViewDelegate;

@interface CGPlusView : UIView
// jian
@property (strong, nonatomic) UIButton *minusBtn;
// jia
@property (strong, nonatomic) UIButton *addBtn;

@property (strong, nonatomic) UILabel *numberLab;

@property (nonatomic,copy) NSString *numberString;

@property (nonatomic, weak)id<PlusViewDelegate>delegate;
@end

@protocol PlusViewDelegate <NSObject>

- (void)minusBtnAction:(UIButton *)sender addNumberView:(CGPlusView *)view;

- (void)plusBtnAction:(UIButton *)sender addNumberView:(CGPlusView *)view;

@end


