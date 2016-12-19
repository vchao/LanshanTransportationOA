//
//  LTMailViewController.h
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/19.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTMailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate> {
    IBOutlet UITableView *mailTableView;
    IBOutlet UISegmentedControl *segmentedControl;
    IBOutlet UISearchBar *searchBar;
    
    NSArray *shouArray;
    NSArray *faArray;
    NSMutableArray *searchArray;
    
    NSMutableDictionary *openInfo;
}

@end
