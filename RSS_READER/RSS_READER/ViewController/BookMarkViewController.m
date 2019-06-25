//
//  BookMarkViewController.m
//  RSS_READER
//
//  Created by LeHoangSang on 6/7/19.
//  Copyright © 2019 PhamNgocSon. All rights reserved.
//

#import "BookMarkViewController.h"
#import <UserNotifications/UserNotifications.h>
//#import "CellObject.h"
#import "NewTableViewCell.h"
#import "ViewDetailViewController.h"
#import "SaveNewsViewController.h"
@interface BookMarkViewController (){
NSXMLParser *parser;
NSMutableArray *feeds;//News
NSMutableDictionary *item;
NSMutableString *title;//Title of new
NSMutableString *link;
NSMutableString *pubDate;
NSMutableString *description;//content of description Tag in RSS
NSString *element;
}
@property (weak, nonatomic) IBOutlet UIView *SlideMenu;
@property (weak, nonatomic) IBOutlet UIView *TableUIView;
@property (weak, nonatomic) IBOutlet UITableView *table;
//variable in Slide Menu
//avatar
@property (weak, nonatomic) IBOutlet UIImageView *ImgAvatar;
//buttons in SlideMenu
@property (weak, nonatomic) IBOutlet UIButton *BtnSetting;
@property (weak, nonatomic) IBOutlet UIButton *BtnRecentlyRead;
@property (weak, nonatomic) IBOutlet UIButton *BtnHelp;
@property (weak, nonatomic) IBOutlet UIButton *BtnAbout;
@property (weak, nonatomic) IBOutlet UIButton *BtnNewsDownload;

@end
static NSMutableArray *NewsDownload;
static NSMutableDictionary *DataTransferCellTemp;
@implementation BookMarkViewController

@synthesize SlideMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    //Read DS from Data.plist
    [SaveNewsViewController ReadData];
    //Custom Button In Slide Menu
    [self SetCustomButtonSlideMenu];
    //Set Border Radius Image of Avatar
    [self SetBorderRadiusImage:self.ImgAvatar];
    // Create Tap Action To Close Slide Menu
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HideSlideMenu:)];
    tap.numberOfTapsRequired = 1;
    [self.TableUIView addGestureRecognizer:tap];
    //Firstly: Hide Table Ui View
    [self.TableUIView setHidden:YES];
    //Set Heigh for Row of Button
    self.table.rowHeight = 130;
    //Create RSS
    feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString:@"https://vnexpress.net/rss/the-thao.rss"];//Link RSS: Can Change to new feature
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate: self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    

}


//Set Border Radius of Image
-(void)SetBorderRadiusImage:(UIImageView*)image{
    image.layer.cornerRadius = image.frame.size.height/2;
    image.layer.borderWidth=5;
    image.layer.borderColor = [[UIColor grayColor] CGColor];
    image.layer.masksToBounds=YES;
    
}

//Set Custom Button Slide Menu With Border Radius and Color
-(void)SetCustomButtonSlideMenu{
    [self CustomButton:self.BtnSetting];
    [self CustomButton:self.BtnHelp];
    [self CustomButton:self.BtnRecentlyRead];
     [self CustomButton:self.BtnAbout];
    [self CustomButton:self.BtnNewsDownload];
}
// Hide Slide Menu with animation
-(void) HideSlideMenu:(UITapGestureRecognizer *)gesturn{
    //Hide Table UI View
    [self.TableUIView setHidden:YES];
    //Then Start Animation With Duration 0.2
   [UIView transitionWithView:SlideMenu duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect frame = self.SlideMenu.frame;
        frame.origin.x = -self.SlideMenu.frame.size.width;
        self.SlideMenu.frame = frame;
        
    }
                    completion:nil];
    
    
}
//Start Read RSS
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    //If Link RSS equal "item" to init variables
    if ([element isEqualToString:@"item"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
        pubDate   = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
       
    }
    
}
//Found String Item IN RSS String
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    }
    else if([element isEqualToString:@"pubDate"])
    {
        [pubDate appendString:string];
    }
    else if([element isEqualToString:@"description"]){
        [description appendString:string];
        
        
    }
    
    
}
//End REad RSS Link Then Add NSDictionary to NSArray
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:pubDate forKey:@"pubDate"];
        [item setObject:description forKey:@"description"];
        
        [feeds addObject:[item copy]];
        
    }
    
}
//Show Slide MEnu
- (IBAction)SlideMenuLeft:(UIScreenEdgePanGestureRecognizer *)sender {
    [self.TableUIView setHidden:NO];
    [UIView transitionWithView:SlideMenu duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect frame = self.SlideMenu.frame;
        frame.origin.x = 0;
        self.SlideMenu.frame = frame;
        
    }
                    completion:nil];
    
}
//Custom Button With Border And COlor
- (void)CustomButton:(UIButton *)button {
    button.backgroundColor = [UIColor whiteColor];
    button.layer.borderWidth = 1.0;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5.0;
    button.layer.borderColor =  [[UIColor grayColor]CGColor];
}
// Crate Mark News Want to Download
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Mark as Unread" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        NSDictionary *dic = [self->feeds objectAtIndex:indexPath.row];
        [SaveNewsViewController AddNewsToDownloadPlist:dic];
        //This is a code that show message to notify user
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Download Successful"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil,nil];
        [alert show];
        //[alert release];
    }];
    editAction.backgroundColor = [UIColor grayColor];
    // Can Add Other Button
    
    return @[editAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.table reloadData];
    
}
//Number Of Section Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//Number OF ROw
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _arrayData.count;
    return feeds.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.NoiDung.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];
    NSString * des=  [[feeds objectAtIndex:indexPath.row] objectForKey: @"description"];
    //Spitting string to get Link Image
    NSArray *ArrayDescription = [des componentsSeparatedByString:@"\""];
    NSString *linkImage =[ArrayDescription objectAtIndex:3];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:linkImage]];
    cell.Hinh.image = [UIImage imageWithData: imageData];
    cell.ThoiGian.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"pubDate"];
  
    return cell;
    
    
}
//Function: Click on Row in Table
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    NSString * storyboardIdentifier = @"Main";// for example "Main.storyboard" then you have to take only "Main"
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardIdentifier bundle: [NSBundle mainBundle]];
        ViewDetailViewController* UIVC = [storyboard instantiateViewControllerWithIdentifier:@"ShowDetail"];
    UIVC.curren = [feeds objectAtIndex:indexPath.row];
    
    NSString * des=  [[feeds objectAtIndex:indexPath.row] objectForKey: @"description"];
    NSArray *ArrayDescription = [des  componentsSeparatedByString:@"</br>"];
    NSString *str =[ArrayDescription objectAtIndex:1];
    UIVC.sortContent = str;
    
    
    ArrayDescription = [des  componentsSeparatedByString:@"\""];
    str =[ArrayDescription objectAtIndex:1];
    UIVC.UrlOfNew = str;
    
    
   ArrayDescription = [des componentsSeparatedByString:@"\""];
    str =[ArrayDescription objectAtIndex:3];
    UIVC.UrlImage=str;
    //[self presentViewController:UIVC animated:YES completion:nil];
    [self.navigationController pushViewController:UIVC animated:true];
//    ViewDetailViewController * viewDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"ShowDetail"];
//
//    [self.navigationController pushViewController:viewDetail animated:true];
//    NSInteger row = [indexPath row];
//    if (self.vailViewController == nil) {
//        ViewDetailViewController *vailView = [[ViewDetailViewController alloc]  initWithNibName:@"ViewDetail" bundle:nil];
//        self.inputViewController = vailView;
//        [vailView release];
//    }
//
//    self.vailViewController.title = [NSString stringWithFormat:@"%@", [resortsArray  objectAtIndex:row]];
//    Ski_AdvisorAppDelegate *delegate = (Ski_AdvisorAppDelegate *)[[UIApplication  sharedApplication] delegate];
//    [delegate.resortsNavController pushViewController:self.vailViewController animated:YES];
}


- (void)viewDidAppear:(BOOL)animated{
    
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
