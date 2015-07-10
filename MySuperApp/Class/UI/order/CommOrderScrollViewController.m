//
//  CommOrderScrollViewController.m
//  MySuperApp
//
//  Created by lee on 14-7-10.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "CommOrderScrollViewController.h"
#import "CommonListCell.h"
#import "StarLevelView.h"
#import "MYCommentAlertView.h"


@interface CommOrderScrollViewController ()
{
    BOOL isNonameComm;

};
@end

@implementation CommOrderScrollViewController
@synthesize co_ID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    self.title = @"我要评价";
    [self createBackBtnWithType:0];
    
    mainSev = [[MainpageServ alloc] init];
    mainSev.delegate = self;
    
    isNonameComm = YES;
    
    sectionCount = 0;
    
    [mainSev getCheckComment:@"" andCo_id:self.co_ID];
    [SBPublicAlert showMBProgressHUD:@"正在请求···" andWhereView:self.view states:NO];

}


#pragma mark -- net request delegate
-(void)serviceStarted:(ServiceType)aHandle{
}

-(void)serviceFailed:(ServiceType)aHandle{
    [SBPublicAlert hideMBprogressHUD:self.view];
    
    [self performSelector:@selector(popBackAnimate:) withObject:nil afterDelay:0.6];
    return;
}

-(void)serviceFinished:(ServiceType)aHandle withmodel:(id)amodel{
    
    [SBPublicAlert hideMBprogressHUD:self.view];
    LBaseModel *model = (LBaseModel *)amodel;
    
    switch (model.requestTag) {
        case Http_CheckCommet_Tag:
        {
            if (!model.errorMessage) {
                [SBPublicAlert hideMBprogressHUD:self.view];
                
                assessModel = (AssessAssessModel *)model;
                sectionCount = assessModel.number;
                
                [self changeScrollV];
                
            }else {
            }
        }
            break;
          
        case Http_addcomment_Tag:
        {
            if (!model.errorMessage) {
                
                if ([(CodeBindBindCodeModel *)model content]) {
                    
                    [MYCommentAlertView showMessage:[(CodeBindBindCodeModel *)model content] target:nil];
                    
                    //[SBPublicAlert showMBProgressHUD:[(CodeBindBindCodeModel *)model content] andWhereView:self.view hiddenTime:0.6];
                }else {
                    [MYCommentAlertView showMessage:@"恭喜您，评论成功" target:nil];
                    //  [SBPublicAlert showMBProgressHUD:@"评价成功" andWhereView:self.view hiddenTime:0.6];
                }
                
                
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [SBPublicAlert showMBProgressHUD:model.errorMessage andWhereView:self.view hiddenTime:0.6];
            }
        }
            break;
        case 10086:
        {
        }
            break;
        default:
        {
            [SBPublicAlert hideMBprogressHUD:self.view];
        }
            break;
    }
}

#pragma mark scrollingView
-(void)changeScrollV{

    int scrollViewHeigh = 0;
    
    
    for (int i = 0; i<[assessModel.detail count]; i++) {
        
        AssessDetail *assessdetail = [assessModel.detail objectAtIndex:i];
        NSLog(@"------%@",assessdetail.nametype);
        
        if ([assessdetail.nametype isEqualToString:@"文胸大类"]) {
            
            CommonListCell* orderCell = [[[NSBundle mainBundle] loadNibNamed:@"CommonListCell" owner:self options:nil] objectAtIndex:0];
            [orderCell setFrame:CGRectMake(0, scrollViewHeigh, 320, 390)];
            orderCell.tag = i;
            [self setUrlImageBtnSuperIndex:orderCell withindex:i];
            [orderCell.imageViewCommodity setImageWithURL:[NSURL URLWithString:assessdetail.imgfilePath] placeholderImage:nil];
            orderCell.labelIntroduce.text = assessdetail.productName;
            orderCell.labelColor.text = assessdetail.product_color;
            orderCell.labelSize.text = assessdetail.product_size;
            orderCell.textcellAccess1.delegate = self;
            [myscrollView addSubview:orderCell];

            //lee999 增加默认值
            orderCell.urlbtn12.selected = YES;
            orderCell.urlbtn15.selected = YES;
            orderCell.urlbtn19.selected = YES;
            assessdetail.sizeSelecttag = 2;
            assessdetail.braSelecttag = 2;
            assessdetail.degressSelecttag = 3;
            //end
            
            scrollViewHeigh = scrollViewHeigh +390;
        }
        else if ([assessdetail.nametype isEqualToString:@"保暖大类"] ||
            [assessdetail.nametype isEqualToString:@"睡衣大类"]) {
            
            CommonListCell* orderCell = [[[NSBundle mainBundle] loadNibNamed:@"CommonListCell" owner:self options:nil] objectAtIndex:1];
            [orderCell setFrame:CGRectMake(0, scrollViewHeigh, 320, +350)];
            orderCell.tag = i;
            [self setUrlImageBtnSuperIndex:orderCell withindex:i];
            [orderCell.imageViewCommodity setImageWithURL:[NSURL URLWithString:assessdetail.imgfilePath] placeholderImage:nil];
            orderCell.labelIntroduce.text = assessdetail.productName;
            orderCell.labelColor.text = assessdetail.product_color;
            orderCell.labelSize.text = assessdetail.product_size;
            orderCell.textcellAccess2.delegate = self;
            [myscrollView addSubview:orderCell];

            //lee999 增加默认值
            orderCell.urlbtn22.selected = YES;
            orderCell.urlbtn25.selected = YES;
            assessdetail.sizeSelecttag = 2;
            assessdetail.braSelecttag = 2;
            //end
        
            scrollViewHeigh = scrollViewHeigh +350;
            
        }else{
            CommonListCell* orderCell = [[[NSBundle mainBundle] loadNibNamed:@"CommonListCell" owner:self options:nil] objectAtIndex:2];
            [orderCell setFrame:CGRectMake(0, scrollViewHeigh, 320, +310)];
            orderCell.tag = i;
            [self setUrlImageBtnSuperIndex:orderCell withindex:i];
            [orderCell.imageViewCommodity setImageWithURL:[NSURL URLWithString:assessdetail.imgfilePath] placeholderImage:nil];
            orderCell.labelIntroduce.text = assessdetail.productName;
            orderCell.labelColor.text = assessdetail.product_color;
            orderCell.labelSize.text = assessdetail.product_size;
            orderCell.textcellAccess3.delegate = self;
            [myscrollView addSubview:orderCell];
            
            //lee999 增加默认值
            orderCell.urlbtn32.selected = YES;
            assessdetail.sizeSelecttag = 2;
            //end

            scrollViewHeigh = scrollViewHeigh +310;
        }
    }
    
//    ([assessdetail.nametype isEqualToString:@"泳衣大类"] ||
//     [assessdetail.nametype isEqualToString:@"内裤大类"] ||
//     [assessdetail.nametype isEqualToString:@"塑身大类"] ||
//     [assessdetail.nametype isEqualToString:@"配饰大类"] ||
//     [assessdetail.nametype isEqualToString:@"运动大类"])
    
    
    CommonListCell* orderCell2 = [[[NSBundle mainBundle] loadNibNamed:@"CommonListCell" owner:self options:nil] objectAtIndex:3];
    [orderCell2 setFrame:CGRectMake(0, scrollViewHeigh, 320, +350)];
    orderCell2.tag = 100098;
    for (int i = 0; i<3; i++) {
        StarLevelView *starView = [[StarLevelView alloc] initWithFrame:CGRectMake(83, 51+i*30, 150, 30)];
        [starView chooseStarLevelAction:5];
        starView.tag = 11130+i;
        [orderCell2 addSubview:starView];
    }
    [myscrollView addSubview:orderCell2];

    scrollViewHeigh = scrollViewHeigh +330;
    //设置高度
    [myscrollView setContentSize:CGSizeMake(320, scrollViewHeigh)];
    
}

-(void)setUrlImageBtnSuperIndex:(CommonListCell*)sender withindex:(int)index{

    sender.urlbtn11.cellIndex = index;
    sender.urlbtn12.cellIndex = index;
    sender.urlbtn13.cellIndex = index;
    sender.urlbtn14.cellIndex = index;
    sender.urlbtn15.cellIndex = index;
    sender.urlbtn16.cellIndex = index;
    sender.urlbtn17.cellIndex = index;
    sender.urlbtn18.cellIndex = index;
    sender.urlbtn19.cellIndex = index;

    sender.urlbtn21.cellIndex = index;
    sender.urlbtn22.cellIndex = index;
    sender.urlbtn23.cellIndex = index;
    sender.urlbtn24.cellIndex = index;
    sender.urlbtn25.cellIndex = index;
    sender.urlbtn26.cellIndex = index;

    sender.urlbtn31.cellIndex = index;
    sender.urlbtn32.cellIndex = index;
    sender.urlbtn33.cellIndex = index;
    
    sender.textcellAccess1.tag = index;
    sender.textcellAccess2.tag = index;
    sender.textcellAccess3.tag = index;
    
    sender.textcellAccess1.returnKeyType = UIReturnKeyDone;
    sender.textcellAccess2.returnKeyType = UIReturnKeyDone;
    sender.textcellAccess3.returnKeyType = UIReturnKeyDone;

}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    if ([textView.text isEqualToString:@"写点评价吧，对其他亲们帮助很大呦！"]) {
        textView.text = @"";
    }
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    
    CGPoint oldpoint = myscrollView.contentOffset;
    oldpoint.y = oldpoint.y + 80;
    [myscrollView setContentOffset:oldpoint];
    
    if ([textView.text isEqualToString:@"写点评价吧，对其他亲们帮助很大呦！"]) {
        textView.text = @"";
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        AssessDetail *assessdetail = [assessModel.detail objectAtIndex:textView.tag];
        assessdetail.userInput = textView.text;
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{

    AssessDetail *assessdetail = [assessModel.detail objectAtIndex:textView.tag];
    assessdetail.userInput = textView.text;
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
}


#pragma mark-- 选择尺码  厚薄  罩杯
-(IBAction)SelectSize:(UrlImageButton*)sender{
    
//    NSLog(@"sender的行是：%d------sender的索引是：%d-----buttonLast的行是:%d-----buttonLast的索引：%d",sender.cellIndex,sender.tag,buttonLast.cellIndex,buttonLast.tag);
    
    CommonListCell *mycellV = (CommonListCell*)[myscrollView viewWithTag:sender.cellIndex];
    UrlImageButton *btn11 = (UrlImageButton*)[mycellV viewWithTag:71];
    btn11.selected = NO;
    UrlImageButton *btn12 = (UrlImageButton*)[mycellV viewWithTag:72];
    btn12.selected = NO;
    UrlImageButton *btn13 = (UrlImageButton*)[mycellV viewWithTag:73];
    btn13.selected = NO;

//    if (buttonLast.cellIndex == sender.cellIndex) {
//        buttonLast.selected = NO;
//    }
//    buttonLast = sender;
    sender.selected = YES;
    
    AssessDetail *assessdetail = [assessModel.detail objectAtIndex:sender.cellIndex];
    assessdetail.sizeSelecttag = sender.tag-70;
    //NSLog(@"SelectSize选中的tag是：%d",sender.tag);
    
}
//罩杯薄厚  面料厚度
-(IBAction)SelectBra:(UrlImageButton*)sender{
    
    CommonListCell *mycellV = (CommonListCell*)[myscrollView viewWithTag:sender.cellIndex];
    UrlImageButton *btn11 = (UrlImageButton*)[mycellV viewWithTag:81];
    btn11.selected = NO;
    UrlImageButton *btn12 = (UrlImageButton*)[mycellV viewWithTag:82];
    btn12.selected = NO;
    UrlImageButton *btn13 = (UrlImageButton*)[mycellV viewWithTag:83];
    btn13.selected = NO;
    
//    if (buttonBra!=nil) {
//        buttonBra.selected = NO;
//    }
//    buttonBra = sender;
    sender.selected = YES;
    
    AssessDetail *assessdetail = [assessModel.detail objectAtIndex:sender.cellIndex];
    assessdetail.braSelecttag = sender.tag-80;
    //NSLog(@"SelectBra选中的tag是：%d",sender.tag);
    
}
//聚拢度
-(IBAction)SelectDegress:(UrlImageButton*)sender{
    
    CommonListCell *mycellV = (CommonListCell*)[myscrollView viewWithTag:sender.cellIndex];
    UrlImageButton *btn11 = (UrlImageButton*)[mycellV viewWithTag:91];
    btn11.selected = NO;
    UrlImageButton *btn12 = (UrlImageButton*)[mycellV viewWithTag:92];
    btn12.selected = NO;
    UrlImageButton *btn13 = (UrlImageButton*)[mycellV viewWithTag:93];
    btn13.selected = NO;
    
//    if (buttonDegree!=nil) {
//        buttonDegree.selected = NO;
//    }
//    buttonDegree = sender;
    sender.selected = YES;
    
    AssessDetail *assessdetail = [assessModel.detail objectAtIndex:sender.cellIndex];
    assessdetail.degressSelecttag = sender.tag-90;
    //NSLog(@"SelectDegress选中的tag是：%d",sender.tag);
    
}

//是否匿名评价
-(IBAction)isNoName:(id)sender{

    UIButton *btn = (UIButton*)sender;
    
    if (isNonameComm) {
        [btn setImage:[UIImage imageNamed:@"select_no.png"] forState:UIControlStateNormal];
        isNonameComm = NO;
    }else{
        [btn setImage:[UIImage imageNamed:@"select_yes.png"] forState:UIControlStateNormal];
        isNonameComm = YES;
    }
}


-(IBAction)SubmmitCommon:(id)sender{
    
    
//    NSLog(@"assessModel.detail----%@",assessModel.detail);
    
    CommonListCell *mycellV = (CommonListCell*)[myscrollView viewWithTag:100098];
    NSString *scre0 = [(StarLevelView *)[mycellV viewWithTag:11130] starLevel];
    NSString *scre1 = [(StarLevelView *)[mycellV viewWithTag:11131] starLevel];
    NSString *scre2 = [(StarLevelView *)[mycellV viewWithTag:11132] starLevel];
    
    NSString* str_common = @"";
    
    for (int i = 0; i<[assessModel.detail count]; i++) {
        AssessDetail *assessdetail = [assessModel.detail objectAtIndex:i];
        NSString* tempstr = [NSString stringWithFormat:@"{\"goods_id\":\"%@\",\"productid\":\"%@\",\"score3\":\"%d\",\"score4\":\"%d\",\"score5\":\"%d\",\"content\":\"%@\"}",assessdetail.goodsid,assessdetail.productid,assessdetail.sizeSelecttag,assessdetail.braSelecttag,assessdetail.degressSelecttag,assessdetail.userInput];
        
//        NSString* tempstr = [NSString stringWithFormat:@"{goods_id:%@,productid:%@,score3:%d,score4:%d,score5:%d,content:%@}",assessdetail.goodsid,assessdetail.productid,assessdetail.sizeSelecttag,assessdetail.braSelecttag,assessdetail.degressSelecttag,assessdetail.userInput];

        if (i==0) {
            str_common = [NSString stringWithFormat:@"%@",tempstr];
        }
        
        if (i > 0) {
            str_common = [NSString stringWithFormat:@"%@,%@",str_common,tempstr];
        }else{
        }
    }
    str_common = [NSString stringWithFormat:@"[%@]",str_common];
    NSLog(@"str_common----%@",str_common);
    
    
    [mainSev getAddOrdercomments:str_common co_id:co_ID andScore0:scre0 andScore1:scre1 andScore2:scre2 anonymous:isNonameComm?@"true":@"false"];
    
    [SBPublicAlert showMBProgressHUD:@"正在提交···" andWhereView:self.view states:NO];
    
    
//    NSString *scre3 = [NSString stringWithFormat:@"%d",buttonLast.tag-70];
//    NSString *scre4 = [NSString stringWithFormat:@"%d",buttonBra.tag-80];
//    NSString *scre5 = [NSString stringWithFormat:@"%d",buttonLast.tag-90];
//    
//    
//    [mainSev getAddcommentGoods_Id:self.goodId andProduct_Id:self.productID andCo_Id:self.co_ID andScore0:scre0 andScore1:scre1 andScore2:scre2 andScore3:scre3 andScore4:scre4 andScore5:scre5 andContent:textAccess.text];
//    [SBPublicAlert showMBProgressHUD:@"正在提交···" andWhereView:self.view states:NO];

}




#pragma mark -- 按钮事件
- (void)popBackAnimate:(UIButton *)sender//返回
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
