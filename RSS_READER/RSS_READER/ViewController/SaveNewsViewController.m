//
//  SaveNewsViewController.m
//  RSS_READER
//
//  Created by LeHoangSang on 6/9/19.
//  Copyright © 2019 PhamNgocSon. All rights reserved.
//

#import "SaveNewsViewController.h"
#import "CellObject.h"
#import "NewTableViewCell.h"
#import "BookMarkViewController.h"
#import "ViewDetailViewController.h"
//  View
static NSMutableArray *itemList;
@interface SaveNewsViewController ()

//@property(strong,nonatomic) NSMutableArray *itemList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SaveNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self ReadDataPrivate];
    //set up height of row in table
    self.tableView.rowHeight = 130;
    [self.tableView delegate];
    [self.tableView dataSource];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    //self.itemList = [BookMarkViewController test];
    [self.tableView reloadData];
}


-(void)ReadDataPrivate{
    NSLog(@"Da read");
    itemList = [[NSMutableArray alloc]init];
    NSString *filepathBundle = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:filepathBundle];
    NSArray *newsDowload = [root objectForKey:@"NewsDownload"];
    for(NSDictionary * dic in newsDowload){
        //CellObject *cell = [[CellObject alloc]initWithDictionary:dic];
        
        [itemList addObject:[dic copy]];
    }
    NSLog(@"%@",itemList);
    NSLog(@"Done read");
    
    
}
//read data from Data.plist
+(void)ReadData{
    itemList = [[NSMutableArray alloc]init];
    NSString *filepathBundle = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    NSDictionary *root = [NSDictionary dictionaryWithContentsOfFile:filepathBundle];
    NSArray *newsDowload = [root objectForKey:@"NewsDownload"];
    for(NSDictionary * dic in newsDowload){
       
        [itemList addObject:[dic copy]];
    }
    
    
}
+(void)AddNewsToDownloadPlist:(NSDictionary*)dic{
    [itemList addObject:dic];
    NSLog(@"%@",itemList);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [itemList removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }
}

+ (void)SaveData {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *docfilePath = [basePath stringByAppendingPathComponent:@"Data.plist"];
    
    // getting path to Data.plist
  
    NSString *documentsDirectory = [paths firstObject];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    // saving values
    //NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:@"" forKey:@"DoNotEverChangeMe"];
  
    // writing to GameData.plist
    [itemList writeToFile:docfilePath atomically:YES];
    
    NSDictionary *resultDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"Saved GameData.plist file in Documents Direcotry is --> %@", [resultDictionary description]);
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return _arrayData.count;
    if(itemList != nil)
    {
        NSLog(@"%lu",(unsigned long)itemList.count);
    }
    return itemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Bat day");
    //CellObject *cellOject = [itemList objectAtIndex:indexPath.row];
     NSLog(@"1");
    NewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     NSLog(@"2");
    cell.NoiDung.text = [[itemList objectAtIndex:indexPath.row] objectForKey:@"title"];
    NSLog(@"3");
    NSString * des= [[itemList objectAtIndex:indexPath.row] objectForKey:@"description"];
    NSArray *ArrayDescription = [des componentsSeparatedByString:@"\""];
    NSString *linkImage =[ArrayDescription objectAtIndex:3];
    //NSLog(@"%@",[ArrayDescription objectAtIndex:3]);
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:linkImage]];
    cell.Hinh.image = [UIImage imageWithData: imageData];
    cell.ThoiGian.text = [[itemList objectAtIndex:indexPath.row] objectForKey:@"pubDate"];
    NSLog(@"reREead");
    return cell;
    
}

-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"Close");
    // getting path to Data.plist
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Data.plist"];
    // saving values
    
    // writing to GameData.plist
    [itemList writeToFile:path atomically:YES];
    
    NSDictionary *resultDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    NSLog(@"Saved GameData.plist file in Documents Direcotry is --> %@", [resultDictionary description]);
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //   [self performSegueWithIdentifier:@"ShowDetail" sender:tableView];
    //
    NSString * storyboardIdentifier = @"Main";// for example "Main.storyboard" then you have to take only "Main"
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardIdentifier bundle: [NSBundle mainBundle]];
    ViewDetailViewController* UIVC = [storyboard instantiateViewControllerWithIdentifier:@"ShowDetail"];
    UIVC.curren = [itemList objectAtIndex:indexPath.row];
    
    NSString * des=  [[itemList objectAtIndex:indexPath.row] objectForKey: @"description"];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
