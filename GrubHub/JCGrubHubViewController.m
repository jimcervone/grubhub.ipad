//
//  JCViewController.m
//  GrubHub
//
//  Created by James Cervone on 2/3/14.
//  Copyright (c) 2014 Jim Cervone. All rights reserved.
//

#import "JCGrubHubViewController.h"

NSString * const JCGrubHubURL = @"http://www.grubhub.com/";

typedef NS_ENUM(NSUInteger, JCGrubHubBrowserActionIndicatorType) {
    JCGrubHubBrowserBackActionIndicator,
    JCGrubHubBrowserForwardActionIndicator,
    JCGrubHubBrowserRefreshActionIndicator
};

@interface JCGrubHubViewController () <UIWebViewDelegate, UIGestureRecognizerDelegate>

@end

@implementation JCGrubHubViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:JCGrubHubURL]]];
}

#pragma mark - Browser Functions
- (void)goBack:(id)sender {
    if ([self.webView canGoBack]) {
        [self presentBrowserActionIndicatorOfType:JCGrubHubBrowserBackActionIndicator];

        //  Note: Look into UIWebViews & GCD
        [self.webView goBack];
    }
}

- (void)goForward:(id)sender {
    if ([self.webView canGoForward]) {
        [self presentBrowserActionIndicatorOfType:JCGrubHubBrowserForwardActionIndicator];

        [self.webView goForward];
    }
}

- (void)refresh:(id)sender {
    [self presentBrowserActionIndicatorOfType:JCGrubHubBrowserRefreshActionIndicator];
    [self.webView reload];
}

- (void)presentBrowserActionIndicatorOfType:(JCGrubHubBrowserActionIndicatorType)type {
    UIImage *image;
    switch (type) {
        case JCGrubHubBrowserBackActionIndicator:
            image = [UIImage imageNamed:@"BackArrow"];
            break;

        case JCGrubHubBrowserForwardActionIndicator:
            image = [UIImage imageNamed:@"BackArrow"];
            image = [UIImage imageWithCGImage:image.CGImage
                                        scale:image.scale
                                  orientation:UIImageOrientationUpMirrored];
            break;

        case JCGrubHubBrowserRefreshActionIndicator:
            image = [UIImage imageNamed:@"RefreshArrow"];
            break;

        default:
            return;
    }

    self.browserActionIndicatorView.image = image;
    self.browserActionIndicatorView.hidden = NO;

    __weak JCGrubHubViewController *weakSelf = self;
    [UIView animateWithDuration:1.f
                     animations:^{
                         weakSelf.browserActionIndicatorView.alpha = 1.f;
                     } completion:nil];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [webView.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];

    if (webView.hidden) {
        webView.hidden = NO;

        for (UIView *view in self.view.subviews) {
            if ([view isMemberOfClass:[UIImageView class]] && view == self.backgroundImage) {
                [view removeFromSuperview];
            }
        }
    }

    if (!self.browserActionIndicatorView.hidden) {
        __weak JCGrubHubViewController *weakSelf = self;
        [UIView animateWithDuration:1.f
                              delay:0.f
                            options:UIViewAnimationOptionAllowAnimatedContent
                         animations:^{
                             weakSelf.browserActionIndicatorView.alpha = 0.f;
                         } completion:^(BOOL finished) {
                             weakSelf.browserActionIndicatorView.hidden = YES;
                         }];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
