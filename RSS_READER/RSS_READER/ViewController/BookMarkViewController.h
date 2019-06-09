//
//  BookMarkViewController.h
//  RSS_READER
//
//  Created by LeHoangSang on 6/7/19.
//  Copyright © 2019 PhamNgocSon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookMarkViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) NSMutableArray *arrayData;



@end

NS_ASSUME_NONNULL_END
