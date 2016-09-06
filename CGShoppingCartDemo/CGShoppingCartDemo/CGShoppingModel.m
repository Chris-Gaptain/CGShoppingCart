//
//  CGShoppingModel.m
//  CGShoppingCartDemo
//
//  Created by ChrisGaptain on 16/9/6.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "CGShoppingModel.h"

@implementation CGShoppingModel

-(instancetype)initWithShoppingDict:(NSDictionary *)dict {
    
    self.imageName = dict[@"imageName"];
    self.goodsTitle = dict[@"goodsTitle"];
    self.goodsPrice = dict[@"goodsPrice"];
    self.goodsNum = [dict[@"goodsNum"]intValue];
    self.goodsType = dict[@"goodsType"];
    self.selectState = [dict[@"selectState"]boolValue];
    
    return self;
}

@end
