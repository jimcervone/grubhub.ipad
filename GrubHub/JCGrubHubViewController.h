//
//  JCViewController.h
//  GrubHub
//
//  Created by James Cervone on 2/3/14.
//  Copyright (c) 2014 Jim Cervone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCGrubHubViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIWebView *webView;

- (IBAction)goBack:(id)sender;
- (IBAction)goForward:(id)sender;
- (IBAction)refresh:(id)sender;

@end
