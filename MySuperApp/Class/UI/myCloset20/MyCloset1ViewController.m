//
//  MyCloset1ViewController.m
//  MyAimerApp
//
//  Created by yanglee on 15/5/27.
//  Copyright (c) 2015年 aimer. All rights reserved.
//

#import "MyCloset1ViewController.h"
#import "MyCloset2ViewController.h"
#import "MyClosetNan2ViewController.h"
#import "MyClosetKid2ViewController.h"
#import "MyClosetMade2ViewController.h"
#import "MyClosetInfo.h"
#import "MyClosetParser.h"

@interface MyCloset1ViewController ()<ServiceDelegate>
{
    
    MainpageServ *mainSev;
    MyClosetInfo *_closetinfo;

    
    NSInteger selectTag;

    IBOutlet UILabel *nameLab1;
    IBOutlet UILabel *nameLab2;
    IBOutlet UILabel *nameLab3;
    IBOutlet UILabel *nameLab4;
    
    
    IBOutlet UIButton *namebtn1;
    IBOutlet UIButton *namebtn2;
    IBOutlet UIButton *namebtn3;
    IBOutlet UIButton *namebtn4;
}
@end

@implementation MyCloset1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"私人衣橱"];
    [self createBackBtnWithType:0];
    [self NewHiddenTableBarwithAnimated:YES];

    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    [mainSev getHomePage20data];
}


#pragma mark--- Action

- (IBAction)typeSelectAction:(id)sender {
    
    UIButton *btn = (UIButton*)sender;

    switch (btn.tag) {
        case 1:
        {
            btn.selected = !namebtn1.selected;
            namebtn2.selected = NO;
            namebtn3.selected = NO;
            namebtn4.selected = NO;
            
            if (namebtn1.selected) {
                [nameLab1 setTextColor:[UIColor whiteColor]];
                [nameLab1 setBackgroundColor:[UIColor clearColor]];
                
                
                [nameLab2 setTextColor:[UIColor blackColor]];
                [nameLab2 setBackgroundColor:[UIColor whiteColor]];
                
                [nameLab3 setTextColor:[UIColor blackColor]];
                [nameLab3 setBackgroundColor:[UIColor whiteColor]];
                
                [nameLab4 setTextColor:[UIColor blackColor]];
                [nameLab4 setBackgroundColor:[UIColor whiteColor]];
                
                selectTag = btn.tag;

            }else{
                [nameLab1 setTextColor:[UIColor blackColor]];
                [nameLab1 setBackgroundColor:[UIColor whiteColor]];
                nameLab1.alpha = 0.8;
                selectTag = 0;
            }

        }
            break;
            
        case 2:
        {
            btn.selected = !namebtn2.selected;
            namebtn1.selected = NO;
            namebtn3.selected = NO;
            namebtn4.selected = NO;
            
            if (namebtn2.selected) {
                [nameLab2 setTextColor:[UIColor whiteColor]];
                [nameLab2 setBackgroundColor:[UIColor clearColor]];
                
                [nameLab1 setTextColor:[UIColor blackColor]];
                [nameLab1 setBackgroundColor:[UIColor whiteColor]];
                
                [nameLab3 setTextColor:[UIColor blackColor]];
                [nameLab3 setBackgroundColor:[UIColor whiteColor]];
                
                [nameLab4 setTextColor:[UIColor blackColor]];
                [nameLab4 setBackgroundColor:[UIColor whiteColor]];
                
                selectTag = btn.tag;

            }else{
                [nameLab2 setTextColor:[UIColor blackColor]];
                [nameLab2 setBackgroundColor:[UIColor whiteColor]];
                nameLab2.alpha = 0.8;
                selectTag = 0;
            }
        }
            break;
            
        case 3:
        {
            btn.selected = !namebtn3.selected;
            namebtn2.selected = NO;
            namebtn1.selected = NO;
            namebtn4.selected = NO;
            
            if (namebtn3.selected) {
                [nameLab3 setTextColor:[UIColor whiteColor]];
                [nameLab3 setBackgroundColor:[UIColor clearColor]];
                
                [nameLab2 setTextColor:[UIColor blackColor]];
                [nameLab2 setBackgroundColor:[UIColor whiteColor]];
                
                [nameLab1 setTextColor:[UIColor blackColor]];
                [nameLab1 setBackgroundColor:[UIColor whiteColor]];
                
                [nameLab4 setTextColor:[UIColor blackColor]];
                [nameLab4 setBackgroundColor:[UIColor whiteColor]];
                
                selectTag = btn.tag;

            }else{
                [nameLab3 setTextColor:[UIColor blackColor]];
                [nameLab3 setBackgroundColor:[UIColor whiteColor]];
                nameLab3.alpha = 0.8;
                selectTag = 0;
            }
            
        }
            break;
            
        case 4:
        {
            btn.selected = !namebtn4.selected;
            namebtn2.selected = NO;
            namebtn3.selected = NO;
            namebtn1.selected = NO;
            
            if (namebtn4.selected) {
                [nameLab4 setTextColor:[UIColor whiteColor]];
                [nameLab4 setBackgroundColor:[UIColor clearColor]];
                
                
                [nameLab2 setTextColor:[UIColor blackColor]];
                [nameLab2 setBackgroundColor:[UIColor whiteColor]];
                
                [nameLab3 setTextColor:[UIColor blackColor]];
                [nameLab3 setBackgroundColor:[UIColor whiteColor]];
                
                [nameLab1 setTextColor:[UIColor blackColor]];
                [nameLab1 setBackgroundColor:[UIColor whiteColor]];
                
                selectTag = btn.tag;

            }else{
                [nameLab4 setTextColor:[UIColor blackColor]];
                [nameLab4 setBackgroundColor:[UIColor whiteColor]];
                nameLab4.alpha = 0.8;
                selectTag = 0;
            }
        }
            break;
            
        default:
            break;
    }
    
}

- (IBAction)nextBtnAction:(id)sender {
    
    if (selectTag == 0) {
        
        [MYCommentAlertView showMessage:@"您还未选择类型" target:nil];
        return;
    }
    
    
    NSString *strtype = @"";
    switch (selectTag) {
        case 1:
        strtype = @"woman";
            break;
            
        case 2:
            strtype = @"man";

            break;
            
        case 3:
            strtype = @"kids";

            break;
            
        case 4:
#warning -----
            strtype = @"";

            break;
            
        default:
            break;
    }
    
    [mainSev getCloset2Data:strtype];

    
    
    
    switch (selectTag) {
        case 1:
        {
            MyCloset2ViewController *clv2 = [[MyCloset2ViewController alloc] initWithNibName:@"MyCloset2ViewController" bundle:nil];
            clv2.selectType = selectTag;
            [self.navigationController pushViewController:clv2 animated:YES];
        
        }
            break;
            
        case 2:
        {
            MyClosetNan2ViewController *clv2 = [[MyClosetNan2ViewController alloc] initWithNibName:@"MyClosetNan2ViewController" bundle:nil];
            [self.navigationController pushViewController:clv2 animated:YES];
            
        }
            break;
            
        case 3:
        {
            MyClosetKid2ViewController *clv2 = [[MyClosetKid2ViewController alloc] initWithNibName:@"MyClosetKid2ViewController" bundle:nil];
            [self.navigationController pushViewController:clv2 animated:YES];
            
        }
            break;
            
        case 4:
        {
            MyClosetMade2ViewController *clv2 = [[MyClosetMade2ViewController alloc] initWithNibName:@"MyClosetMade2ViewController" bundle:nil];
            [self.navigationController pushViewController:clv2 animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark--- Severvice
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    LBaseModel *model = (LBaseModel *)amodel;
    _closetinfo = [[MyClosetParser alloc] init];
}

//-(void)createView{
//
//    int countNum = 4;
//    int sep = 13;
//    int H = 100;
//
//    NSArray *imageArr = [NSArray arrayWithObjects:@"sryc_img_woman.png",@"sryc_img_man.png",@"sryc_img_girl.png",@"sryc_img_dz.png", nil];
//    for (int i = 0; i<countNum; i++) {
//
//        if (i==2) {
//            H += 180+sep;
//        }
//
//        UIImageView *imagev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imageArr objectAtIndex:i]]];
//        [imagev setFrame:CGRectMake((i|2)==0?sep:sep*2+140, H, 140, 180)];
//        [self.view addSubview:imagev];
//
//
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
