//
//  CGShoppingCartCell.h
//  CGShoppingCartDemo
//
//  Created by ChrisGaptain on 16/9/6.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGPlusView.h"
#import "CGShoppingModel.h"
@protocol ShoppingCarCellDelegate;

@interface CGShoppingCartCell : UITableViewCell<PlusViewDelegate>

@property (nonatomic,strong) UIImageView *checkImg;

@property (nonatomic,strong) UIImageView *shopImageView;

@property (nonatomic,strong) UILabel *shopNameLab;

@property (nonatomic,strong) UILabel *priceLab;

// 商品型号
@property (nonatomic,strong) UILabel *shopTypeLab;
// 减数量按钮
@property (nonatomic,strong) UIButton *jianBtn;
// 加数量按钮
@property (nonatomic,strong) UIButton *addBtn;
// 显示数量
@property (nonatomic,strong) UILabel *numberLab;

@property (nonatomic,strong) CGShoppingModel *shoppingModel;
// 是否选中
@property (assign,nonatomic) BOOL selectState;

@property (nonatomic,strong) CGPlusView *plusView;

@property (nonatomic, weak)id<ShoppingCarCellDelegate>delegate;

@end

@protocol ShoppingCarCellDelegate

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;

@end
