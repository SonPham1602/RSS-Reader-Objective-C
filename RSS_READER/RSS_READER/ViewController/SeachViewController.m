//
//  SeachViewController.m
//  RSS_READER
//
//  Created by LeHoangSang on 6/9/19.
//  Copyright © 2019 PhamNgocSon. All rights reserved.
//

#import "SeachViewController.h"

@interface SeachViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *SearchBar;

@end

@implementation SeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _SearchBar.delegate=self;
    // Do any additional setup after loading the view.
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length == 0)
    {
        
    }
    else
    {
        NSLog(@"%@",searchText);
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
