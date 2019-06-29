//
//  OptionViewController.m
//  RSS_READER
//
//  Created by Son Ngoc Pham on 6/24/19.
//  Copyright © 2019 PhamNgocSon. All rights reserved.
//

#import "OptionViewController.h"

@interface OptionViewController ()
@property (strong, nonatomic) IBOutlet UIView *MainView;
@property (strong,nonatomic) UIColor *darkMode;
@property (strong,nonatomic) UIColor *whiteMode;
@property (weak, nonatomic) IBOutlet UILabel *labelSelectMode;
@property (weak, nonatomic) IBOutlet UILabel *labelSelectFontSize;

@end

@implementation OptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _whiteMode = [UIColor whiteColor];
    _darkMode = [UIColor grayColor];
    // Do any additional setup after loading the view.
}
//Function: Select Dark Mode
- (IBAction)SelectDarkMode:(UIButton *)sender {
    _MainView.backgroundColor = _darkMode;
    _labelSelectMode.textColor = _whiteMode;
    _labelSelectFontSize.textColor = _whiteMode;
}
//Function: Select White Mode
- (IBAction)SelectWhiteMode:(UIButton *)sender {
    _MainView.backgroundColor = _whiteMode;
    _labelSelectMode.textColor = _darkMode;
    _labelSelectFontSize.textColor = _darkMode;
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
