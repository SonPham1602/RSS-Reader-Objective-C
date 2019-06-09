//
//  CellObject.m
//  RSS_READER
//
//  Created by LeHoangSang on 6/7/19.
//  Copyright © 2019 PhamNgocSon. All rights reserved.
//

#import "CellObject.h"
//#import "BookMarkViewController.h"
@implementation CellObject
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self.strTitle = [dic objectForKey:@"title"];
    self.strDescription = [dic objectForKey:@"description"];
    self.strTime = [dic objectForKey:@"pubDate"];
    return self;
}
@end
