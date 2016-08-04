//
//  MJLoginPageViewController.m
//  百思不得姐 -- MJ
//
//  Created by 孙梦翔 on 16/7/29.
//  Copyright © 2016年 孙梦翔. All rights reserved.
//

#import "MJLoginPageViewController.h"
#import "MJTextField.h"
@interface MJLoginPageViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet MJTextField *inputRegistPswLabel;

@property (weak, nonatomic) IBOutlet MJTextField *inputPswLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeft;

///* 关闭键盘的 block */
//@property (strong ,nonatomic) <#Class#> * <#name#>;
@end

@implementation MJLoginPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.inputPswLabel.delegate = self;
    self.inputRegistPswLabel.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registClick
{
    
    if (self.loginViewLeft.constant == 0)
    {
        self.loginViewLeft.constant = -MJScreenW;
        self.registBtn.selected = YES;
    }
    
    else
    {
        self.loginViewLeft.constant = 0;
        self.registBtn.selected = NO;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)cancelClick:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
