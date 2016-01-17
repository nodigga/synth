//
//  ViewController.m
//  synth
//
//  Created by nicholas.cardinal on 11/11/15.
//  Copyright © 2015 nicholas.cardinal. All rights reserved.
//

#import "ViewController.h"
#import "AKFoundation.h"
#import "MoogLadderViewController.h"
#import "ReverbViewController.h"
#import "Model.h"


@interface ViewController ()
{
Model *model;

BOOL inView;
    
}


@end

@implementation ViewController



@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI_2);
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    inView = TRUE;
    
    model = [Model sharedModel];

    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.view.backgroundColor = [UIColor blueColor];
   
    
    // Views
    
    CGRect keyboardFrame = CGRectMake(0, self.screenHeight/2, self.screenWidth, self.screenHeight/2);
    
    self.keyboardViewController = [[KeyboardViewController alloc]init];
    self.keyboardViewController.view.frame = keyboardFrame;
    self.keyboardViewController.view.backgroundColor = [UIColor greenColor];
    
    CGRect effectFrame = CGRectMake(self.screenWidth/2 +500, 0, self.screenWidth/2, self.screenHeight/2);
    
    self.effectView = [[UIView alloc] init];
    self.effectView.frame = effectFrame;
    self.effectView.backgroundColor = [UIColor greenColor];
   
    [self.view addSubview:self.keyboardViewController.view];
    [self.view addSubview:self.effectView];
    //[self.effectView setHidden:YES];
    
    //AKProperty Sliders For Effect View
    
    CGRect delaySliderFrame = CGRectMake(0,80, 100, 30);
    self.delaySlider = [[AKSlider alloc]initWithFrame:delaySliderFrame];
    self.delaySlider.transform = trans;
    [self.delaySlider setBackgroundColor:[UIColor purpleColor]];
    self.delaySlider.minimumValue = -100.0;
    self.delaySlider.maximumValue = 0.0;
    self.delaySlider.continuous = YES;
    
    [self.effectView addSubview:self.delaySlider];
    
    
    
    // FX BUTTONS
    
    //MOOGLADDER BUTTON
    self.moogLadderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moogLadderButton.frame = CGRectMake(10, 50, 100, 30);
    [self.moogLadderButton addTarget:self action:@selector (showMoogLadder) forControlEvents:UIControlEventTouchUpInside];
    [self.moogLadderButton setTitle:@"MoogLadderFilter" forState:UIControlStateNormal];
    [self.moogLadderButton setImage:[UIImage imageNamed:@"moogladder.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.moogLadderButton];
    
    //REVERB BUTTON
    self.reverbButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reverbButton.frame = CGRectMake (10, 150, 100, 30);
    [self.reverbButton addTarget:self action:@selector(showReverb) forControlEvents:UIControlEventTouchUpInside];
    [self.reverbButton setTitle:@"Reverb" forState:UIControlStateNormal];
    [self.reverbButton setImage:[UIImage imageNamed:@"reverb.png"]forState:UIControlStateNormal];
    [self.view addSubview:self.reverbButton];
    
    //DELAY BUTTON
    self.delayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.delayButton.frame = CGRectMake(10, 100, 100, 30);
    [self.delayButton addTarget:self action:@selector(showEffectView) forControlEvents:UIControlEventTouchUpInside];
    [self.delayButton setTitle:@"delay" forState:UIControlStateNormal];
    UIImage *reverb = [UIImage imageNamed:@"test.png"];
    
    [self.delayButton setImage:reverb forState:UIControlStateNormal];
    
    [self.view addSubview:self.delayButton];
    
    //OCTAVE SWITCH
    
    self.octaveSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(self.screenWidth/2-60, self.screenHeight/2 - 50, 0, 0)];
    [self.octaveSwitch addTarget:self action:@selector(octaveSwitchOn:)
    forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.octaveSwitch];
}


-(void)octaveSwitchOn:(id)sender
{
    if([sender isOn])
    {
        NSLog(@"switch on");
        self.switchOn = TRUE;
        model.frequencies = [model.octaveTwo mutableCopy];  //seems to work
        }
   
    else
    {
        NSLog(@"switch off");
        self.switchOn = FALSE;
        model.frequencies = [model.octaveOne mutableCopy];
    }
    
    
   // [self.delegate octaveDelegate:self];
}

//-(void)showEffectView
//{
//    if([self.effectView isHidden])
//    {
//        [self.effectView setHidden:NO];
//    }
//    else
//    {
//        [self.effectView setHidden:YES];
//    }
//}

-(void)showEffectView
{
  CGRect effectFrame = CGRectMake(self.screenWidth/2, 0, self.screenWidth/2, self.screenHeight/2);
  CGRect effectFrameOffScreen = CGRectMake(self.screenWidth/2 +500, 0, self.screenWidth/2, self.screenHeight/2);
   
    if(inView)
    {
        [UIView animateWithDuration:1.0 animations:^{self.effectView.frame = effectFrame;}];
        inView = FALSE;
    }
    else
    {
        [UIView animateWithDuration:1.0 animations:^{self.effectView.frame = effectFrameOffScreen;}];
        inView = TRUE;
    }
    
    
}



-(void)delaySliderValueChanged:(id)sender
{

    


}


- (void)showMoogLadder
{
    self.moogLadderViewController = [[MoogLadderViewController alloc]init];
    self.moogLadderViewController.view.backgroundColor = [UIColor orangeColor];
    [self.navigationController pushViewController:self.moogLadderViewController animated:YES];
}

- (void)showReverb
{
    self.reverbViewController = [[ReverbViewController alloc]init];
    self.reverbViewController.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:self.reverbViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
