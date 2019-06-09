//
//  CellObject.h
//  RSS_READER
//
//  Created by LeHoangSang on 6/7/19.
//  Copyright © 2019 PhamNgocSon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellObject : NSObject
@property (strong,nonatomic) NSString *strTitle;
@property (strong,nonatomic) NSString *strTime;
@property (strong,nonatomic) NSString *strDescription;
-(instancetype) initWithDictionary:(NSDictionary *)dic;
@end

