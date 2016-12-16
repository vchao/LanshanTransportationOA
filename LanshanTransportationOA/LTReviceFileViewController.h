//
//  LTReviceFileViewController.h
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/16.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTReviceFileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    IBOutlet UITableView *workTableView;
    IBOutlet UISegmentedControl *segmentedControl;
    IBOutlet UISearchBar *searchBar;
    
    NSArray *doArray;
    NSArray *listArray;
    NSMutableArray *searchArray;
    
    NSMutableDictionary *openInfo;
    NSString *liuchengID;
}

@end
