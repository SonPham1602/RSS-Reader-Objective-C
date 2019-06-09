//
//  SaveNewsViewController.h
//  RSS_READER
//
//  Created by LeHoangSang on 6/9/19.
//  Copyright © 2019 PhamNgocSon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaveNewsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

+(void)ReadData;
+(void)SaveData;
+(void)AddNewsToDownloadPlist:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
