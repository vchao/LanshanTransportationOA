//
//  LTStampViewController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/19.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTStampViewController.h"

@interface LTStampViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *listArray;
}

@property (weak, nonatomic) IBOutlet UITableView *stampTableView;

@end

@implementation LTStampViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    listArray = [NSMutableArray new];
    
    [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"leave_approval", @"icon", @"印鉴申请", @"title", @"pushToStampApply", @"action", nil]];
    [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"vacation_apply", @"icon", @"印鉴审批", @"title", @"pushToStampApproval", @"action", nil]];
    [listArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"vacation_consult", @"icon", @"印鉴查询", @"title", @"pushToStampSelect", @"action", nil]];
    
    self.stampTableView.dataSource = self;
    self.stampTableView.delegate = self;
    [self.stampTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LTStampManagerCell"];
    self.stampTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.stampTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LTStampManagerCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    NSDictionary *dict = [listArray objectAtIndex:indexPath.row];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 17, 20, 20)];
    imageView.image = [UIImage imageNamed:[dict objectForKey:@"icon"]];
    [cell.contentView addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 7, _MainScreen_Width-48, 40)];
    titleLabel.font = [UIFont systemFontOfSize:16.f];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = [dict objectForKey:@"title"];
    [cell.contentView addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(12, 53.5, _MainScreen_Width-12, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:232/255.f green:232/255.f blue:232/255.f alpha:1.0];
    [cell.contentView addSubview:lineView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSDictionary *dict = [listArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:[dict objectForKey:@"action"] sender:@"tapCell"];
}

#pragma mark - 导航

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *viewController = segue.destinationViewController;
    if ([sender isEqualToString:@"tapCell"]) {
    }
}

@end
