//
//  JCViewController.m
//  GrubHub
//
//  Created by James Cervone on 2/3/14.
//  Copyright (c) 2014 Jim Cervone. All rights reserved.
//

#import "JCGrubHubViewController.h"

NSString * const JCGrubHubURL = @"http://www.grubhub.com/";

@interface JCGrubHubViewController () <UIWebViewDelegate>

@end

@implementation JCGrubHubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:JCGrubHubURL]]];
}

- (void)goBack:(id)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

- (void)goForward:(id)sender {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}

- (void)refresh:(id)sender {
    [self.webView reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];
}

@end
