//
//  CGShoppingModel.h
//  CGShoppingCartDemo
//
//  Created by ChrisGaptain on 16/9/6.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGShoppingModel : NSObject

// 图片
@property(copy,nonatomic) NSString *imageName;
// 标题
@property(copy,nonatomic) NSString *goodsTitle;
// 类型
@property(copy,nonatomic) NSString *goodsType;
// 单价
@property(copy,nonatomic) NSString *goodsPrice;
// 是否选中状态
@property(assign,nonatomic) BOOL selectState;
// 个数
@property(assign,nonatomic) int goodsNum;

-(instancetype)initWithShoppingDict:(NSDictionary *)dict;

@end
