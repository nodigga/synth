//
//  KeyboardViewController.m
//  synth
//
//  Created by nicholas.cardinal on 11/15/15.
//  Copyright © 2015 nicholas.cardinal. All rights reserved.
//

#import "KeyboardViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "Model.h"


@interface KeyboardViewController ()
{
    Model *model;
}
@end

@implementation KeyboardViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    model = [Model sharedModel];

    float keyboardHeight = [UIScreen mainScreen].bounds.size.height;
    float keyboardWidth = [UIScreen mainScreen].bounds.size.height;
    
    int keys = 12;
    
    NSLog(@"%f", keyboardWidth);
    UIView *keysButtonView = [[UIView alloc] initWithFrame:CGRectMake(0.0,0.0, 667, keyboardHeight/2)];
    
    keysButtonView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:keysButtonView];
   // [self.view addSubview:testbutton];
    
    for (int x = 0; x<keys; x++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(667/keys *x  , 0, 53, keyboardHeight/2- 10);
        [button setTag:x];
        
        if(x==1 || x == 3 || x==6 || x == 8 || x==10 )
        {
            button.backgroundColor = [UIColor blackColor];
        }
        else
        {
            button.backgroundColor = [UIColor whiteColor];
        }
        
        [button addTarget:self action:@selector(keyPressed:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(keyReleased:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchUpInside];
        [keysButtonView addSubview:button];
    }
    // Synth Instantiation
    // Create and add instruments to the Orchestra
    
    self.fmOscillator = [[FMOscillator alloc]init];
    [AKOrchestra addInstrument:self.fmOscillator];
}

-(void)keyPressed: (UIButton *)button
{
    [button setBackgroundColor:[UIColor yellowColor]];
    NSInteger index = button.tag;
    [model noteOn:index];
}

-(void)keyReleased: (UIButton *)button
{
    NSInteger index = button.tag;
   [model noteOff:index];
    if(button.tag ==1 || button.tag == 3 || button.tag ==6 || button.tag == 8 || button.tag==10 )
       [button setBackgroundColor:[UIColor blackColor]];
   else
   {
       [button setBackgroundColor:[UIColor whiteColor]];
   }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
