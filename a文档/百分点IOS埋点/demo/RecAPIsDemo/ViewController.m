//
//  ViewController.m
//  SimpleProject
//
//  Created by wanghuan on 13-3-9.
//  Copyright (c) 2013年 Neil. All rights reserved.
//

#import "ViewController.h"





@interface ViewController ()

@end

@implementation ViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *namestr;

    switch (indexPath.row) {
        case 0:
            namestr = @"onAddCart";
            break;
        case 1:
            namestr = @"onAddItem";
            break;
        case 2:
            namestr = @"onAddUser";
            break;
        case 3:
            namestr = @"onFeedback";
            break;
        case 4:
            namestr = @"onOrder";
            break;
        case 5:
            namestr = @"onPageStart";
            break;
        case 6:
            namestr = @"onPageEnd";
            break;
        case 7:
            namestr = @"onPay";
            break;
        case 8:
            namestr = @"onPosition";
            break;
        case 9:
            namestr = @"onRmCart";
            break;
        case 10:
            namestr = @"onRmItem";
            break;
        case 11:
            namestr = @"onSearch";
            break;
        case 12:
            namestr = @"onVisit";
            break;
        case 13:
            namestr = @"recommend";
            break;
        case 14:
            namestr = @"recommendP";
            break;
        default:
            break;
    }
    // Configure the cell...
    cell.textLabel.text = namestr;
    
    return cell;
}
//
//---------------------------------------------------------------------------------------------------------------
//
-(void) mobidea_Recs:(NSError*) error feedback:(id)feedback{
    NSLog(@"mobidea_Recs: domain(%@) code(%d) method(%@) feedback:(%@)", [error domain], [error code], [[error userInfo] objectForKey:NSLocalizedDescriptionKey], feedback);

    //
    [[[UIAlertView alloc] initWithTitle:[error domain] message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil] show];
}
//
//---------------------------------------------------------------------------------------------------------------
//
-(void)onPay{
    
    NSDictionary *buylist1 = @{@"i":@"1024763", @"p":[NSNumber numberWithDouble:19.99f], @"n":[NSNumber numberWithInt:10]};
    NSDictionary *buylist2 = @{@"i":@"1024764", @"p":[NSNumber numberWithDouble:1999], @"n":[NSNumber numberWithInt:5]};
    NSArray *buylists = [NSArray arrayWithObjects:buylist1, buylist2, nil];

    //
    //  membership
    //
    [BfdAgent pay:self orderId: @"20141023155157970143" options: @{@"total":[NSNumber numberWithDouble: 100.0f], @"uid":@"301358", @"lst": buylists}];
}

-(void)onPageStart{
    [BfdAgent beginPageView:self pageName: @"ViewController" options: nil];
}
-(void)onPageEnd{

    [BfdAgent endPageView:self pageName: @"ViewController" options: nil];

    //
    //  membership
    //
    [BfdAgent endPageView:self pageName: @"ViewController" options: @{@"uid":@"301358"}];
}
//
//
-(void)onAddUser{

    NSDictionary *json = @{@"a1": [NSNumber numberWithInt: 199], @"a2": @"Rec", @"a3": [NSNumber numberWithBool: NO]};
    NSData *attribute = [NSJSONSerialization dataWithJSONObject: json options:NSJSONWritingPrettyPrinted error:nil];
    NSString *attr = [[NSString alloc] initWithData: attribute encoding:NSUTF8StringEncoding];

    [BfdAgent addUser:self userId:@"301358" options: nil];
    [BfdAgent addUser:self userId:@"301358" options: @{@"em":@"baifendiantest@163.com", @"qq":@"", @"wb":@"刘明_机器学习", @"addr":@"", @"img": [NSNumber numberWithBool: NO], @"name": @"", @"cp": @"+8613800138000", @"attr": attr}];
}
//
//
-(void)onRmItem{

    [BfdAgent rmItem:self itemId:@"1024763" options: nil];

    //
    //  membership
    //
    [BfdAgent rmItem:self itemId:@"1024763" options: @{@"uid":@"301358", @"del": [NSNumber numberWithBool: YES]}];
}
//
//
-(void)onAddItem{

    [BfdAgent addItem:self itemId:@"1024763" options: nil];

    //
    //  membership
    //
    NSDictionary *json = @{@"a1": [NSNumber numberWithInt: 199], @"a2": @"Rec", @"a3": [NSNumber numberWithBool: NO]};
    NSData *attribute = [NSJSONSerialization dataWithJSONObject: json options:NSJSONWritingPrettyPrinted error:nil];
    NSString *attr = [[NSString alloc] initWithData: attribute encoding:NSUTF8StringEncoding];

    [BfdAgent addItem:self itemId:@"1024763" options: @{@"uid":@"301358", @"dis": [NSNumber numberWithDouble: 0.85f], @"num": [NSNumber numberWithUnsignedInt: 1], @"p_fee": [NSNumber numberWithDouble: 0.01], @"url": @"http://www.taobao.cn/product-1050242.html", @"salecnt":[NSNumber numberWithBool: NO], @"title": @"title", @"bc": @"中关村|国贸", @"attr": attr}];
}
-(void)onVisit{
    //
    //  anonymous
    //
    [BfdAgent visit:self itemId:@"1024763" options:nil];

    //
    //  membership
    //
    [BfdAgent visit:self itemId:@"1024763" options: @{@"uid":@"301358"}];
}
//
//
-(void)onAddCart{
    //
    //
    //
    NSDictionary *buylist = @{@"i":@"1024763", @"p":[NSNumber numberWithDouble:19.90], @"n":[NSNumber numberWithInt:1]};
    NSArray *buylists = [NSArray arrayWithObjects:buylist,nil];
    
    [BfdAgent addCart:self lst:buylists options:nil];

    //
    //  membership
    //
    [BfdAgent addCart:self lst:buylists options:@{@"uid":@"301358"}];
}
//
//
-(void)onRmCart{

    [BfdAgent rmCart:self itemId:@"1024763" options:nil];

    //
    //  membership
    //
    [BfdAgent rmCart:self itemId:@"1024763" options: @{@"uid":@"301358"}];
}
//
-(void)onOrder{
    //
    //
    //
    NSDictionary *buylist1 = @{@"i":@"1024763", @"p":[NSNumber numberWithDouble:19.99f], @"n":[NSNumber numberWithInt:10]};
    NSDictionary *buylist2 = @{@"i":@"1024764", @"p":[NSNumber numberWithDouble:1999], @"n":[NSNumber numberWithInt:5]};
    NSArray *buylists = [NSArray arrayWithObjects:buylist1, buylist2, nil];


    NSError * err = [BfdAgent order:self lst:buylists orderId:@"20141023155157970143" options: @{@"total":[NSNumber numberWithDouble:100.00]}];

    
    //
    //  membership
    //
    err = [BfdAgent order:self lst:buylists orderId:@"20141023155157970143" options:@{@"uid":@"301358", @"total": [NSNumber numberWithDouble:100.00]}];
}
//
-(void)onSearch{
    [BfdAgent search:self queryString:@"iPhone 6+" options: nil];

    //
    //  membership
    //
    [BfdAgent search:self queryString:@"iPhone 6+" options: @{@"uid":@"301358"}];
}
//
//
-(void)onFeedback{
    [BfdAgent feedback:self recommendId:@"rec_F7734668_xxxx_yyyy_zzzz_EA8B6728E394" itemId:@"1024763" options:nil];

    //
    //  membership
    //
    [BfdAgent feedback:self recommendId:@"rec_F7734668_xxxx_yyyy_zzzz_EA8B6728E394" itemId:@"1024763" options: @{@"uid":@"301358"}];
}
//
//
-(void)onPosition{
    [BfdAgent position:self latitude:39.92 longitude:116.23 options:nil];

    //
    //  membership
    //
    [BfdAgent position:self latitude:39.92 longitude:116.23 options: @{@"uid":@"301358"}];
}
//
//
-(void)recommend{
    NSError* error = [BfdAgent recommend:self recommendId:@"rec_F7734668_CC49_8C4F_24C5_EA8B6728E394" options: @{@"iid":@"1024763"}];
    
    //
    //  membership
    //
    error = [BfdAgent recommend:self recommendId:@"rec_F7734668_CC49_8C4F_24C5_EA8B6728E394" options: @{@"iid":@"1024763", @"uid":@"301358"}];
}
//
//
-(void)recommendP{
    [BfdAgent recommendP:self recommendIds:@[@"rec_F7734668_CC49_8C4F_24C5_EA8B6728E394", @"rec_70401884_9D14_7852_B127_DFFF04D1F613", @"rec_127BD48C_69EF_7D70_748D_B43F3F567152"] options: @{@"iid":@"1024763", @"uid":@"301358", @"cid":@"Cxxxxxx"}];
}
#if 0
(
 "rec_F7734668_CC49_8C4F_24C5_EA8B6728E394",
 (
  {
      iid = 974917;
      img = "http://p4.maiyaole.com/img/974/974917/330_330.jpg";
      mktp = "72.5";
      name = "\U8fea\U5de7 \U7ef4D\U9499\U5480\U56bc\U7247 300mg*60\U7247";
      price = 33;
      url = "http://www.111.com.cn/product/974917.html";
  },
  {
      iid = 987630;
      img = "http://p2.maiyaole.com/img/987/987630/330_330.jpg?a=56305356";
      mktp = 152;
      name = "\U7231\U4e50\U7ef4 \U590d\U5408\U7ef4\U751f\U7d20\U7247 30\U7247";
      price = "59.9";
      url = "http://www.111.com.cn/product/987630.html";
  },
  {
      iid = 975155;
      img = "http://p3.maiyaole.com/img/975/975155/330_330.jpg?a=1195667341";
      mktp = 995;
      name = "\U4e1c\U963f \U963f\U80f6 250g";
      price = 650;
      url = "http://www.111.com.cn/product/975155.html";
  },
  {
      iid = 974726;
      img = "http://p4.maiyaole.com/img/974/974726/330_330.jpg?a=19202102";
      mktp = 45;
      name = "\U987a\U5c14\U5b81 \U5b5f\U9c81\U53f8\U7279\U94a0\U7247 10mg*5\U7247";
      price = "42.8";
      url = "http://www.111.com.cn/product/974726.html";
  },
  {
      iid = 50074464;
      img = "http://p1.maiyaole.com/img/50074/50074464/330_330.JPG?a=1261492453";
      mktp = 25;
      name = "3  M  9002V\U578b \U81ea\U5438\U8fc7\U6ee4\U5f0f\U9632\U9897\U7c92\U53e3\U7f69(\U5e26\U547c\U6c14\U9600) 3\U53ea\U88c5";
      price = 25;
      url = "http://www.111.com.cn/product/50074464.html";
  }
  )
 ),
(
 "rec_70401884_9D14_7852_B127_DFFF04D1F613",
 (
  {
      iid = 1250866;
      img = "http://p3.maiyaole.com/img/1250/1250866/330_330.jpg";
      mktp = 78;
      name = "\U8fbe\U8299\U6587 \U963f\U8fbe\U5e15\U6797\U51dd\U80f6 0.1%:30g";
      price = 58;
      url = "http://www.111.com.cn/product/1250866.html?tracker_u=1087398633&hmsr=baidu&hmmd=cpc&hmpl=bdc037&hmkw=abd00069166&hmci=pc";
  },
  {
      iid = 1797627;
      img = "http://p4.maiyaole.com/img/1797/1797627/330_330.jpg?a=829360255";
      mktp = 118;
      name = "\U5188\U672c\U907f\U5b55\U5957 003\U767d\U91d1 10\U7247";
      price = "81.90000000000001";
      url = "http://www.111.com.cn/product/1797627.html";
  },
  {
      iid = 2605592;
      img = "http://p4.maiyaole.com/img/2605/2605592/330_330.jpg";
      mktp = 38;
      name = "\U4f0a\U53ef\U65b0 \U7ef4\U751f\U7d20AD\U6ef4\U5242 \Uff080-1\U5c81\Uff0930\U7c92";
      price = 22;
      url = "http://www.111.com.cn/product/2605592.html";
  },
  {
      iid = 974902;
      img = "http://p1.maiyaole.com/img/974/974902/330_330.jpg?a=231223502";
      mktp = 128;
      name = "\U4e07\U827e\U53ef \U67b8\U6a7c\U9178\U897f\U5730\U90a3\U975e\U7247\Uff08\U4f1f\U54e5\Uff09 100mg*1\U7247";
      price = 108;
      url = "http://www.111.com.cn/product/974902.html";
  },
  {
      iid = 1915790;
      img = "http://p4.maiyaole.com/img/1915/1915790/330_330.jpg?a=1844618666";
      mktp = "39.8";
      name = "\U5bff\U724c \U84b2\U5730\U84dd\U6d88\U708e\U53e3\U670d\U6db2 10ml*6\U652f";
      price = 32;
      url = "http://www.111.com.cn/product/1915790.html?tracker_u=1087398633&hmsr=baidu&hmmd=cpc&hmpl=bdc037&hmkw=abd00066857&hmci=pc";
  }
  )
 ),
(
 "rec_127BD48C_69EF_7D70_748D_B43F3F567152",
 (
  {
      iid = 1003588;
      img = "http://p4.maiyaole.com/img/1003/1003588/330_330.jpg?a=602050065";
      mktp = 79;
      name = "\U60e0\U6c0f \U5584\U5b58 \U4f73\U7ef4\U7247 60\U7247";
      price = 52;
      url = "http://www.111.com.cn/product/1003588.html";
  },
  {
      iid = 972419;
      img = "http://p1.maiyaole.com/img/972/972419/330_330.jpg?a=1973274717";
      mktp = 15;
      name = "999\U724c \U611f\U5192\U7075\U9897\U7c92 10g*9\U5305";
      price = "10.5";
      url = "http://www.111.com.cn/product/972419.html";
  },
  {
      iid = 1003606;
      img = "http://p3.maiyaole.com/img/1003/1003606/330_330.jpg?a=416979159";
      mktp = 46;
      name = "\U5eb7\U7f8e\U83ca\U7687\U8336130g(6.5g*20\U5305)";
      price = "19.9";
      url = "http://www.111.com.cn/product/1003606.html";
  }
  )
 )
))
#endif

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self onAddCart];
            break;
        case 1:
            [self onAddItem];
            break;
        case 2:
            [self onAddUser];
            break;
        case 3:
            [self onFeedback];
            break;
        case 4:
            [self onOrder];
            break;
        case 5:
            [self onPageStart];
            break;
        case 6:
            [self onPageEnd];
            break;
        case 7:
            [self onPay];
            break;
        case 8:
            [self onPosition];
            break;
        case 9:
            [self onRmCart];
            break;
        case 10:
            [self onRmItem];
            break;
        case 11:
            [self onSearch];
            break;
        case 12:
            [self onVisit];
            break;
        case 13:
            [self recommend];
            break;
        case 14:
            [self recommendP];
            break;
        default:
            break;
    }
}

@end