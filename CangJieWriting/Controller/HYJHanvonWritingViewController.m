//
//  HYJHanvonWritingViewController.m
//  CangJieWriting
//
//  Created by 张文峰 on 15/9/4.
//  Copyright © 2015年 皓月君. All rights reserved.
//

#import "HYJHanvonWritingViewController.h"
#import "HYJDrawingView.h"
#import "HYJResourceManager.h"
#import "HWCloudsdk.h"
#import "HYJCharacter.h"
#import "UIAlertView+HYJAlertView.h"

@interface HYJHanvonWritingViewController () <HYJDrawingViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *mattBackgroundImageView;
@property (weak, nonatomic) IBOutlet HYJDrawingView *writingView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *characterButtons;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *pinyinLabels;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfLabelsButtonsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfCharacterButton;
@property (weak, nonatomic) IBOutlet UIView *labelsButtonsView;
@property (assign, nonatomic) int selectedCharacterButtonTag;
@property (strong, nonatomic) HWCloudsdk *hwSDK;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation HYJHanvonWritingViewController

- (HWCloudsdk *)hwSDK {
    if (!_hwSDK) {
        _hwSDK = [[HWCloudsdk alloc] init];
    }
    return _hwSDK;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_writingView setDelegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self selectCharacterButtonWithTag:1];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUpMattImageBackgroundView];
    [self setUpLabelsButtonsView];
}

- (void)setUpMattImageBackgroundView {
    UIImage *mattImage = [HYJResourceManager mattImageForScreenSize:[[UIScreen mainScreen] bounds].size];
    [_mattBackgroundImageView setImage:mattImage];
}

- (void)setUpLabelsButtonsView {
    [self setUpLabels];
    [self setUpButtons];
}

- (void)setUpLabels {
    
}

- (void)setUpButtons {
    [_heightOfCharacterButton setConstant:[HYJResourceManager heightOfCharacterButtonForScreenSize:[[UIScreen mainScreen]bounds].size]];
    [_heightOfLabelsButtonsView setConstant:_heightOfCharacterButton.constant + 20];
    for (UIButton *button in _characterButtons) {
        UIImage *image = [HYJResourceManager smallMattImageForScreenSize:[[UIScreen mainScreen] bounds].size isSelected:NO];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        image = [HYJResourceManager smallMattImageForScreenSize:[[UIScreen mainScreen] bounds].size isSelected:YES];
        [button setBackgroundImage:image forState:UIControlStateSelected];
        [button setTitle:@" " forState:UIControlStateNormal];
        [button setTitle:@" " forState:UIControlStateHighlighted];
        [button.titleLabel setFont:[UIFont systemFontOfSize:_heightOfCharacterButton.constant * 0.66]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchCharacterButton:(UIButton *)sender {
    _selectedCharacterButtonTag = (int)sender.tag;
    [sender setSelected:YES];
    for (UIButton *button in _characterButtons) {
        if (sender.tag == button.tag) {
            continue;
        }
        [button setSelected:NO];
    }
    [self clearCurrentWriting:nil];
}

- (void)selectCharacterButtonWithTag:(NSInteger)tag {
    UIButton *button = (UIButton *)[_labelsButtonsView viewWithTag:tag];
    [self touchCharacterButton:button];
}

- (void)setTitle:(NSString *)title ForButtonWithTag:(NSInteger)tag {
    UIButton *button = (UIButton *)[_labelsButtonsView viewWithTag:tag];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
}

- (IBAction)clearCurrentWriting:(UIButton *)sender {
    [_writingView clear];
    [_writingView setUserInteractionEnabled:YES];
}

#pragma mark - <HYJDrawingViewDelegate>

- (void)drawingView:(HYJDrawingView *)view willBeginDrawUsingTool:(id<HYJDrawingTool>)tool {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)drawingView:(HYJDrawingView *)view didEndDrawUsingTool:(id<HYJDrawingTool>)tool {
    if (_selectedCharacterButtonTag >= 1
        && _selectedCharacterButtonTag <= 4) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(didEndWritingACharacter:) userInfo:nil repeats:NO];
    }
}

- (void)didEndWritingACharacter:(NSTimer *)timer {
    NSLog(@"Did End!");
    NSString *handSingleData = [HYJCharacter handSingleDataForCharacterPathArray:_writingView.allPath];
    NSData *resultData = [self requestDataFromServerWithHandSingleData:handSingleData];
    if (resultData) {
        [self doSomethingWhenGotValidResultData:resultData];
    }else {
        [UIAlertView showAnAlertViewForNoNetworkAccess];
    }
}

- (NSData *)requestDataFromServerWithHandSingleData:(NSString *)handSingleData {
    NSString *responseString = [self.hwSDK type:@"1"
                                           lang:@"chns"
                                 handSingleData:handSingleData
                                         apiKey:@"a8593d5b-ffcb-41a7-9de9-e000a63f127c"];
    return [responseString dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)doSomethingWhenGotValidResultData:(NSData *)resultData {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@", dict);
    int code = [dict[@"code"] intValue];
    if (!code) {
        NSString *charactersString = [HYJCharacter stringWithUTF8CodeString:dict[@"result"]];
        NSString *first = [HYJCharacter firstCharacterInCharactersString:charactersString];
        NSLog(@"%@", first);
        [self setTitle:first ForButtonWithTag:_selectedCharacterButtonTag];
        [self selectCharacterButtonWithTag:_selectedCharacterButtonTag + 1];
        if (_selectedCharacterButtonTag < 1
            || _selectedCharacterButtonTag > 4 ) {
            [_writingView setUserInteractionEnabled:NO];
        }
    }else if (code == 2030){
        [self alertWhenGot2030ErrorCode];
    }else {
        [self alertWhenGotUnknownErrorCode];
    }
}

- (void)alertWhenGot2030ErrorCode {
    NSDictionary *options = @{
                              @"title":@"识别异常",
                              @"message":@"很抱歉，我们并不能识别您的书写，请重试！",
                              @"cancel":@"好的"
                              };
    [UIAlertView showAnAlertViewWithOptions:options];
}

- (void)alertWhenGotUnknownErrorCode {
    NSDictionary *options = @{
                              @"title":@"未知错误",
                              @"message":@"很抱歉，发生了未知错误，我们的工程师们会尽快排查！给您的使用造成了不便，敬请谅解！",
                              @"cancel":@"好的"
                              };
    [UIAlertView showAnAlertViewWithOptions:options];
}

@end
