//
//  AppDelegate.h
//  synth
//
//  Created by nicholas.cardinal on 11/11/15.
//  Copyright © 2015 nicholas.cardinal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIViewController *viewController;

@property BOOL test;

@end

