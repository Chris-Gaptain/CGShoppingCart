//
//  CGPlusView.m
//  CGShoppingCartDemo
//
//  Created by ChrisGaptain on 16/9/6.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "CGPlusView.h"

@implementation CGPlusView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self initialSubViews];
    }
    return self;
}

-(void)initialSubViews {
    
    self.minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.minusBtn.frame = CGRectMake(0,0, 26, 22);
    [self.minusBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.minusBtn.tag = 11;
    [self.minusBtn setImage:[UIImage imageNamed:@"Minus_Btn"] forState:UIControlStateNormal];
    [self addSubview:self.minusBtn];
    
    UIImageView *numberBg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.minusBtn.frame)-4, CGRectGetMinY(self.minusBtn.frame), 50,22)];
    numberBg.image = [UIImage imageNamed:@"number_back"];
    [self addSubview:numberBg];
    
    self.numberLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(numberBg.frame), CGRectGetHeight(numberBg.frame))];
    self.numberLab.text = @"1";
    self.numberLab.textAlignment = NSTextAlignmentCenter;
    self.numberLab.textColor = [UIColor darkGrayColor];
    self.numberLab.font = [UIFont systemFontOfSize:12.0];
    [numberBg addSubview:self.numberLab];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(CGRectGetWidth(numberBg.frame)+18,CGRectGetMinY(self.minusBtn.frame), 26, 22);
    self.addBtn.tag = 12;
    [self.addBtn setImage:[UIImage imageNamed:@"Plus_Btn"] forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addBtn];
}

- (void)deleteBtnAction:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(minusBtnAction:addNumberView:)]) {
        [self.delegate minusBtnAction:sender addNumberView:self];
    }
}

- (void)addBtnAction:(UIButton *)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(plusBtnAction:addNumberView:)]) {
        [self.delegate plusBtnAction:sender addNumberView:self];
    }
}


#pragma mark - Getter
-(void)setNumberString:(NSString *)numberString{
    _numberString = numberString;
    
    self.numberLab.text = numberString;
}


@end
