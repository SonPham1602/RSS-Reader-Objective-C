//
//  ViewDetailViewController.m
//  RSS_READER
//
//  Created by LeHoangSang on 6/8/19.
//  Copyright © 2019 PhamNgocSon. All rights reserved.
//

#import "ViewDetailViewController.h"
#import "BookMarkViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SaveNewsViewController.h"

@interface ViewDetailViewController ()

@end

@implementation ViewDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.ImageOfNews.layer setBorderColor: [[UIColor grayColor] CGColor]];
//    [self.ImageOfNews.layer  setBorderWidth: 2.0];
//    
    
    self.ImageOfNews.layer.cornerRadius = 5;
   self.ImageOfNews.clipsToBounds = YES;
    
   self.ImageOfNews.layer.shadowRadius  = 5;
    self.ImageOfNews.layer.shadowColor   = [[UIColor blackColor] CGColor];
   self.ImageOfNews.layer.shadowOffset  = CGSizeMake(5, 5);
    self.ImageOfNews.layer.shadowOpacity = 0.8f;
    self.ImageOfNews.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(self.ImageOfNews.bounds, shadowInsets)];
   self.ImageOfNews.layer.shadowPath    = shadowPath.CGPath;
    
    
    self.TitleOfNew.text = [self.curren objectForKey:@"title"];
    //self.UrlOfNew = [self.curren objectForKey:@"link"];
    self.SortContentOfNews.text = self.sortContent;
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:self.UrlImage]];
    self.ImageOfNews.image=[UIImage imageWithData: imageData];
    // Do any additional setup after loading the view.
}
- (IBAction)ShareNew:(UIButton *)sender {
    NSString *textToShare = @"Look at this awesome News!";
    NSURL *myWebsite = [NSURL URLWithString:self.UrlOfNew];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
    
}
- (IBAction)Setting:(UIBarButtonItem *)sender {
}
- (IBAction)ShareNews:(UIBarButtonItem *)sender {
    NSString *textToShare = @"Look at this awesome News!";
    NSURL *myWebsite = [NSURL URLWithString:self.UrlOfNew];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}
- (IBAction)SaveNewsOffline:(UIBarButtonItem *)sender {
    
    [SaveNewsViewController AddNewsToDownloadPlist:self.curren];
}
- (IBAction)VisitToWebsite:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.UrlOfNew]];
    
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
