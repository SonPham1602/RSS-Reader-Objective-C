//
//  NewTableViewCell.h
//  RSS_READER
//
//  Created by LeHoangSang on 6/7/19.
//  Copyright © 2019 PhamNgocSon. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewTableViewCell : UITableViewCell{
    NSString *NoiDung;
}
@property (weak, nonatomic) IBOutlet UIImageView *Hinh;
@property (strong, nonatomic) IBOutlet UILabel *NoiDung;
@property (strong, nonatomic) IBOutlet UILabel *ThoiGian;

@end

NS_ASSUME_NONNULL_END
