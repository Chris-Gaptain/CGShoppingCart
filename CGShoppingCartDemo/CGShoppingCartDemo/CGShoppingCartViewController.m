//
//  CGShoppingCartViewController.m
//  CGShoppingCartDemo
//
//  Created by ChrisGaptain on 16/9/6.
//  Copyright © 2016年 wolf. All rights reserved.
//

#import "CGShoppingCartViewController.h"
#import "CGCommonTool.h"
#import "CGShoppingCartCell.h"

@interface CGShoppingCartViewController ()<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,ShoppingCarCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *allSelectBtn;

@property (nonatomic, strong) UILabel *totalPriceLabel;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CGShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"ShoppingCart";
    
    self.dataArray = [[NSMutableArray alloc]initWithCapacity:1];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.allSelectBtn];
    [self.view addSubview:self.totalPriceLabel];
    
    [self initialDataSource];
}

- (void)selectAllaction:(UIButton *)sender {
    sender.tag = !sender.tag;
    if (sender.tag) {
        sender.selected = YES;
    } else {
        sender.selected = NO;
    }
}

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    switch (flag) {
        case 11: {
            CGShoppingModel *model = self.dataArray[index.row];
            if (model.goodsNum > 1) {
                model.goodsNum --;
            }
        }
            break;
        case 12: {
            CGShoppingModel *model = self.dataArray[index.row];
            model.goodsNum ++;
        }
            break;
        default:
            break;
    }
    [self.tableView reloadData];

    [self CalculationPrice];
}

-(void)CalculationPrice {
    
    for ( int i =0; i<self.dataArray.count;i++) {
        CGShoppingModel *model = self.dataArray[i];
        if (model.selectState) {
            self.price = self.price + model.goodsNum *[model.goodsPrice intValue];
        }
    }

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",self.price]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0] range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    self.totalPriceLabel.attributedText = str;
    NSLog(@"%f",self.price);
    self.price = 0.0;
}

#pragma mark - tableView dataSource && delgate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIndentifier"];
    
    cell.delegate = self;
    cell.shoppingModel = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CGShoppingModel *model = self.dataArray[indexPath.row];
    if (model.selectState) {
        model.selectState = NO;
    } else {
        model.selectState = YES;
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self CalculationPrice];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 110;
}

- (void)initialDataSource {
    for (int i = 0; i<10; i++) {
        NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
        [infoDict setValue:@"img.png" forKey:@"imageName"];
        [infoDict setValue:@"Goods" forKey:@"goodsTitle"];
        [infoDict setValue:@"Goods_Detail" forKey:@"goodsType"];
        [infoDict setValue:@"40.00" forKey:@"goodsPrice"];
        [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
        [infoDict setValue:[NSNumber numberWithInt:1] forKey:@"goodsNum"];
        
        CGShoppingModel *model = [[CGShoppingModel alloc]initWithShoppingDict:infoDict];
        [self.dataArray addObject:model];
    }
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-40) style:UITableViewStylePlain];
        [_tableView registerClass:[CGShoppingCartCell class] forCellReuseIdentifier:@"cellIndentifier"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIButton *)allSelectBtn {
    if (!_allSelectBtn) {
        _allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allSelectBtn.frame = CGRectMake(10, CGRectGetMaxY(self.tableView.frame)+10, 60, 20);
        [_allSelectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _allSelectBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_allSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectBtn setImage:[UIImage imageNamed:@"AllSelect_Normal"] forState:UIControlStateNormal];
        [_allSelectBtn setImage:[UIImage imageNamed:@"AllSelect_Selected"] forState:UIControlStateSelected];
        _allSelectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [_allSelectBtn addTarget:self action:@selector(selectAllaction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectBtn;
}

- (UILabel *)totalPriceLabel {
    if (!_totalPriceLabel) {
        _totalPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.allSelectBtn.frame)+10, CGRectGetMinY(self.allSelectBtn.frame), kScreenWidth-10-CGRectGetMaxX(self.allSelectBtn.frame), 20)];
        _totalPriceLabel.font = [UIFont systemFontOfSize:13.0];
        _totalPriceLabel.textAlignment = NSTextAlignmentCenter;
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",self.price]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,attributedString.length-4)];
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0] range:NSMakeRange(4,attributedString.length-4)];
        _totalPriceLabel.attributedText = attributedString;
    }
    return _totalPriceLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
