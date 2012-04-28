//
//  LLWebReaderViewController.m
//  LectorLibro
//
//  Created by Sergio del Amo Caballero on 4/28/12.
//  Copyright (c) 2012 Softamo S.L.U. All rights reserved.
//

#import "LLWebReaderViewController.h"
#import "ImageDemoViewController.h"

@interface LLWebReaderViewController ()
@property (nonatomic, strong) NSString *html;
@end

@implementation LLWebReaderViewController
@synthesize html = _html;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Inside View Did Load");
    self.view = [[UIWebView alloc] init];
    [self renderView];
}


- (void)setHtml:(NSString *)newHTML {
    if(newHTML != _html) {
        _html =  newHTML;
    }
}

- (void)renderView {
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [[self webView] loadHTMLString:self.html baseURL:baseURL];   
}

- (UIWebView *)webView {
    UIWebView *webView = self.view;
    return webView;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
