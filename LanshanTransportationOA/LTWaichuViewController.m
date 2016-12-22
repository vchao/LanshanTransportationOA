//
//  LTWaichuViewController.m
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/22.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import "LTWaichuViewController.h"

@interface LTWaichuViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *listArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LTWaichuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LTWaichuManagerCell"];
    
    listArray = [NSMutableArray new];
    
    NSArray *array1 = [NSArray arrayWithObjects:
                       [NSDictionary dictionaryWithObjectsAndKeys:@"vacation_apply", @"icon", @"休假申请", @"title", @"pushToVacationApply", @"action", @"vacation", @"type", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"vacation_approval", @"icon", @"休假审批", @"title", @"pushToVacationApproval", @"action", @"vacation", @"type", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"vacation_consult", @"icon", @"休假查阅", @"title", @"pushToVacationConsult", @"action", @"vacation", @"type", nil], nil];
    [listArray addObject:array1];
    
    NSArray *array2 = [NSArray arrayWithObjects:
                       [NSDictionary dictionaryWithObjectsAndKeys:@"leave_apply", @"icon", @"请假申请", @"title", @"pushToVacationApply", @"action", @"leave", @"type", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"leave_approval", @"icon", @"请假审批", @"title", @"pushToVacationApproval", @"action", @"leave", @"type", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"leave_consult", @"icon", @"请假查阅", @"title", @"pushToVacationConsult", @"action", @"leave", @"type", nil], nil];
    [listArray addObject:array2];
    
    NSArray *array3 = [NSArray arrayWithObjects:
                       [NSDictionary dictionaryWithObjectsAndKeys:@"business_apply", @"icon", @"出差申请", @"title", @"pushToBusinessApply", @"action", @"business", @"type", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"business_approval", @"icon", @"出差审批", @"title", @"pushToBusinessApproval", @"action", @"business", @"type", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"business_consult", @"icon", @"出差查阅", @"title", @"pushToBusinessConsult", @"action", @"business", @"type", nil], nil];
    [listArray addObject:array3];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [listArray objectAtIndex:section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LTWaichuManagerCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
    }
    NSArray *array = [listArray objectAtIndex:indexPath.section];
    NSDictionary *dict = [array objectAtIndex:indexPath.row];
    
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
    NSArray *array = [listArray objectAtIndex:indexPath.section];
    NSDictionary *dict = [array objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:[dict objectForKey:@"action"] sender:[dict objectForKey:@"type"]];
}

#pragma mark - 导航

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *viewController = segue.destinationViewController;
    if ([sender isEqualToString:@"business"]) {
    }else if ([sender isEqualToString:@"vacation"] || [sender isEqualToString:@"leave"]) {
        if ([viewController respondsToSelector:@selector(setPageType:)]) {
            [viewController setValue:sender forKey:@"pageType"];
        }
    }
}

@end
