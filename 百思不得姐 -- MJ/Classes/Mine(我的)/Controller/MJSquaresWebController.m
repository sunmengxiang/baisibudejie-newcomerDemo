//
//  MJSquaresWebController.m
//  
//
//  Created by 孙梦翔 on 16/8/3.
//
//

#import "MJSquaresWebController.h"

@interface MJSquaresWebController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButtonItem;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation MJSquaresWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backClick:(id)sender
{
    self.backButtonItem.enabled = self.webView.canGoBack;
    [self.webView goBack];
}
- (IBAction)forwardClick:(id)sender
{
    self.forwardButtonItem.enabled = self.webView.canGoForward;
    [self.webView goForward];
}
- (IBAction)refreshClick:(id)sender
{
    [self.webView reload];
}

@end
