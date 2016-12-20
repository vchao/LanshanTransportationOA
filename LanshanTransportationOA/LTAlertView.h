//
//  LTAlertView.h
//  LanshanTransportationOA
//
//  Created by 任维超 on 2016/12/15.
//  Copyright © 2016年 任维超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTAlertView : UIView

@property (nonatomic, copy) void(^contactButtonClicked)(void);
@property (nonatomic, copy) void(^cancelButtonClicked)(void);
@property (nonatomic, copy) void(^sendMsgButtonClicked)(void);

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

@interface LTLiuchengAlertView : UIView

@property (nonatomic, copy) void(^cancelButtonClicked)(void);

- (instancetype)initWithArray:(NSArray *)array;

@end

@interface LTListAlertView : UIView

@property (nonatomic, copy) void(^checkItemClicked)(NSDictionary *item);
@property (nonatomic, copy) void(^cancelButtonClicked)(void);

- (instancetype)initWithArray:(NSArray *)array title:(NSString *)title;

@end

//多选alertView
@interface LTMultiSelectAlertView : UIView

@property (nonatomic, copy) void(^confirmButtonClicked)(NSArray *array);
@property (nonatomic, copy) void(^cancelButtonClicked)(void);

- (instancetype)initWithArray:(NSArray *)array title:(NSString *)title;

@end
