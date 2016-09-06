//
//  CGShoppingCartCell.m
//  CGShoppingCartDemo
//
//  Created by ChrisGaptain on 16/9/6.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "CGShoppingCartCell.h"
#import "CGCommonTool.h"

@implementation CGShoppingCartCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        [self initialSubViews];
    }
    return self;
}

- (void)initialSubViews {
    self.checkImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, (110-20)/2.0, 20, 20)];
    self.checkImg.image = [UIImage imageNamed:@"AllSelect_Selected"];
    [self addSubview:self.checkImg];
    
    self.shopImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxY(self.checkImg.frame)+10,15, 60, 60)];
    self.shopImageView.image = [UIImage imageNamed:@""];
    self.shopImageView.backgroundColor = [UIColor redColor];
    [self addSubview:self.shopImageView];
    
    self.priceLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-90, (110-20)/2.0-20, 80, 20)];
    self.priceLab.textColor = [UIColor redColor];
    self.priceLab.text = @"￥000.00";
    self.priceLab.textAlignment = NSTextAlignmentRight;
    self.priceLab.font = [UIFont systemFontOfSize:16.0];
    [self addSubview:self.priceLab];
    
    
//    self.oldPriceLab = [[LineLabel alloc]initWithFrame:CGRectMake(kScreenWidth-70,self.priceLab.bottom+5, 58, 14)];
//    self.oldPriceLab.textColor = [UIColor grayColor];
//    self.oldPriceLab.text = @"￥200.00";
//    self.oldPriceLab.backgroundColor = [UIColor clearColor];
//    self.oldPriceLab.textAlignment = NSTextAlignmentRight;
//    self.oldPriceLab.font = SYSTEMFONT(13);
//    [self addSubview:self.oldPriceLab];
    
    
    self.shopNameLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.shopImageView.frame)+10,CGRectGetMinY(self.shopImageView.frame)-5,kScreenWidth-CGRectGetMaxX(self.shopImageView.frame)-20-CGRectGetWidth(self.priceLab.frame), 20)];
    self.shopNameLab.text = @"商品名字";
    self.shopNameLab.numberOfLines = 0;
    self.shopNameLab.font = [UIFont systemFontOfSize:16.0];
    [self addSubview:self.shopNameLab];
    
    self.shopTypeLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.shopNameLab.frame),CGRectGetMaxY(self.shopNameLab.frame),CGRectGetWidth(self.shopNameLab.frame), 20)];
    self.shopTypeLab.text = @"商品类型";
    self.shopTypeLab.textColor = [UIColor darkGrayColor];
    self.shopTypeLab.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:self.shopTypeLab];
    
    UILabel *numberTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.shopTypeLab.frame),CGRectGetMaxY(self.shopImageView.frame)-5,35, 16)];
    numberTitleLab.text = @"数量:";
    numberTitleLab.textColor = [UIColor darkGrayColor];
    numberTitleLab.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:numberTitleLab];
    
    
    self.plusView = [[CGPlusView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(numberTitleLab.frame)+5, CGRectGetMinY(numberTitleLab.frame)-2, 93, 22)];
    self.plusView.delegate = self;
    self.plusView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.plusView];
}

- (void)minusBtnAction:(UIButton *)sender addNumberView:(CGPlusView *)view {

    //判断是否选中，选中才能操作
    if (self.selectState == YES) {
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先选中商品" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)plusBtnAction:(UIButton *)sender addNumberView:(CGPlusView *)view {

    //判断是否选中，选中才能操作
    if (self.selectState == YES) {
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先选中商品" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)setShoppingModel:(CGShoppingModel *)shoppingModel{
    
    _shoppingModel = shoppingModel;
    self.shopNameLab.text = shoppingModel.goodsTitle;
    
    if (shoppingModel.selectState)
    {
        self.checkImg.image = [UIImage imageNamed:@"AllSelect_Selected"];
        self.selectState = YES;
        
    }else{
        self.selectState = NO;
        self.checkImg.image = [UIImage imageNamed:@"AllSelect_Normal"];
    }
    self.shopTypeLab.text  = shoppingModel.goodsType;
    
    self.priceLab.text = shoppingModel.goodsPrice;
    self.shopImageView.image = [UIImage imageNamed:shoppingModel.imageName];
    self.plusView.numberString = [NSString stringWithFormat:@"%d",shoppingModel.goodsNum];
}

@end
