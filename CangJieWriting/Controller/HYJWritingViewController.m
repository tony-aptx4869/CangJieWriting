//
//  HYJMainViewController.m
//  CangJieWriting
//
//  Created by 张文峰 on 15/9/4.
//  Copyright © 2015年 皓月君. All rights reserved.
//

#import "HYJWritingViewController.h"
#import "HYJDrawingView.h"
#import "HYJResourceManager.h"

@interface HYJWritingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mattBackgroundImageView;
@property (weak, nonatomic) IBOutlet HYJDrawingView *writingView;
@end

@implementation HYJWritingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpMattImageBackgroundView];
}

- (void)setUpMattImageBackgroundView {
    UIImage *mattImage = [HYJResourceManager mattImageForScreenSize:[[UIScreen mainScreen] bounds].size];
    [_mattBackgroundImageView setImage:mattImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearCurrentWriting:(UIButton *)sender {
    [_writingView clear];
}


@end
