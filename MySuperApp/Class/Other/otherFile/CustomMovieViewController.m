//
//  CustomMovieViewController.m
//  MySuperApp
//
//  Created by LEE on 14-4-14.
//  Copyright (c) 2014年 zan. All rights reserved.
//

#import "CustomMovieViewController.h"
#import "AppDelegate.h"

@interface CustomMovieViewController ()

@end

@implementation CustomMovieViewController
//@synthesize mp4url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createBackBtn1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickBackButton:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
}

-(void)createBackBtn1{
    UIButton *btnnavback = [[UIButton alloc] initWithFrame:CGRectMake(3, 5, 60, 50)];
    [btnnavback setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btnnavback setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [btnnavback addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnnavback];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏footview
//    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [app.aktabBarRightController hideTabBar:AKShowHideFromLeft animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
//    显示footview
//    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [app.aktabBarRightController showTabBar:AKShowHideFromLeft animated:YES];
}


- (void)viewDidUnload {

    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];

    [super viewDidUnload];
}


-(void)clickBackButton:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -- 屏幕旋转
//iOS 5
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
//iOS 6
- (BOOL)shouldAutorotate
{
	return YES;
}
- (NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskLandscape;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
	return UIInterfaceOrientationLandscapeRight;
}

@end
