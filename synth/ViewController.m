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

BOOL delayInView, moogLadderInView, reverbInView;

}

@property(nonatomic, strong) UILabel *delaySliderLabel;

@end

@implementation ViewController



@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI_2);
    // Do any additional setup after loading the view, typically from a nib.
    
    delayInView = TRUE;
    moogLadderInView = TRUE;
    reverbInView = TRUE;
    
    model = [Model sharedModel];

    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.view.backgroundColor = [UIColor blueColor];
   
    
    // KEYBOARD VIEW
    
    CGRect keyboardFrame = CGRectMake(0, self.screenHeight/2, self.screenWidth, self.screenHeight/2);
    
    self.keyboardViewController = [[KeyboardViewController alloc]init];
    self.keyboardViewController.view.frame = keyboardFrame;
    self.keyboardViewController.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.keyboardViewController.view];
    
    //EFFECT VIEW
    
    CGRect effectFrame = CGRectMake(self.screenWidth/2 +500, 0, self.screenWidth/2, self.screenHeight/2);
    
    self.effectView = [[UIView alloc] init];
    self.effectView.frame = effectFrame;
    self.effectView.backgroundColor = [UIColor greenColor];
   
    [self.view addSubview:self.effectView];
    
    //MOOGLADDER VIEW
    
    CGRect moogFrame = CGRectMake(self.screenWidth/2 +500, 0, self.screenWidth/2, self.screenHeight/2);
    
    self.moogLadderView = [[UIView alloc] init];
    self.moogLadderView.frame = moogFrame;
    self.moogLadderView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.moogLadderView];
    
    
    //REVERB VIEW
    
    CGRect reverbFrame = CGRectMake(self.screenWidth/2 +500, 0, self.screenWidth/2, self.screenHeight/2);
    
    self.reverbView = [[UIView alloc] init];
    self.reverbView.frame = reverbFrame;
    self.reverbView.backgroundColor = [UIColor brownColor];
    
    [self.view addSubview:self.reverbView];
    
    
    //AKProperty Sliders For Effect View
    
    CGRect delaySliderFrame = CGRectMake(0,80, 100, 30);
    self.delaySlider = [[AKSlider alloc]initWithFrame:delaySliderFrame];
    //self.delaySlider.transform = trans;
    [self.delaySlider setBackgroundColor:[UIColor purpleColor]];
    self.delaySlider.minimumValue = 0.0;
    self.delaySlider.maximumValue = 4.0;
    self.delaySlider.continuous = YES;
    [self.delaySlider addTarget:self action:@selector(setDelayTimeSlider:) forControlEvents:UIControlEventValueChanged];
    
    
    CGRect delaySliderLabelFrame = CGRectMake(0, 40, 100, 30);
    self.delaySliderLabel = [[UILabel alloc]initWithFrame:delaySliderLabelFrame];
    [self.effectView addSubview:self.delaySlider];
    [self.effectView addSubview:self.delaySliderLabel];
    
  
    //AKProperty Sliders For MoogLadder
    
    CGRect moogLadderCutoffFrame = CGRectMake(0,40, 100, 30);
    self.cutoffSlider = [[AKSlider alloc]initWithFrame:moogLadderCutoffFrame];
    [self.cutoffSlider setBackgroundColor:[UIColor purpleColor]];
    self.cutoffSlider.minimumValue = 0.0;
    self.cutoffSlider.maximumValue = 20000;
    self.cutoffSlider.continuous = YES;
    [self.cutoffSlider addTarget:self action:@selector(setMoogLadderCutoffSlider:) forControlEvents:UIControlEventValueChanged];
    
    CGRect moogLadderResonanceFrame = CGRectMake(0,80, 100, 30);
    self.resonanceSlider = [[AKSlider alloc]initWithFrame:moogLadderResonanceFrame];
    [self.resonanceSlider setBackgroundColor:[UIColor purpleColor]];
    self.resonanceSlider.minimumValue = 0.0;
    self.resonanceSlider.maximumValue = 1;
    self.resonanceSlider.continuous = YES;
    [self.resonanceSlider addTarget:self action:@selector(setMoogLadderResonanceSlider:) forControlEvents:UIControlEventValueChanged];
    
    CGRect moogLadderMixFrame = CGRectMake(0,120, 100, 30);
    self.moogMixSlider = [[AKSlider alloc]initWithFrame:moogLadderMixFrame];
    [self.moogMixSlider setBackgroundColor:[UIColor purpleColor]];
    self.moogMixSlider.minimumValue = 0.0;
    self.moogMixSlider.maximumValue = 1;
    self.moogMixSlider.continuous = YES;
    [self.moogMixSlider addTarget:self action:@selector(setMoogLadderMixSlider:) forControlEvents:UIControlEventValueChanged];
    
    
    //CGRect delaySliderLabelFrame = CGRectMake(0, 40, 100, 30);
   // self.cutoffSlider = [[UILabel alloc]initWithFrame:moogLadderCutoffFrame];
    [self.moogLadderView addSubview:self.cutoffSlider];
    [self.moogLadderView addSubview:self.resonanceSlider];
    [self.moogLadderView addSubview:self.moogMixSlider];
    
    
    //[self.effectView addSubview:self.delaySliderLabel];
    
    
    
    
    // FX BUTTONS
    
    //MOOGLADDER BUTTON
    self.moogLadderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moogLadderButton.frame = CGRectMake(10, 50, 100, 30);
    [self.moogLadderButton addTarget:self action:@selector (showMoogLadderView) forControlEvents:UIControlEventTouchUpInside];
    [self.moogLadderButton setTitle:@"MoogLadderFilter" forState:UIControlStateNormal];
    [self.moogLadderButton setImage:[UIImage imageNamed:@"moogladder.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.moogLadderButton];
    
    //REVERB BUTTON
    self.reverbButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reverbButton.frame = CGRectMake (10, 150, 100, 30);
    [self.reverbButton addTarget:self action:@selector(showReverbView) forControlEvents:UIControlEventTouchUpInside];
    [self.reverbButton setTitle:@"Reverb" forState:UIControlStateNormal];
    [self.reverbButton setImage:[UIImage imageNamed:@"reverb.png"]forState:UIControlStateNormal];
    [self.view addSubview:self.reverbButton];
    
    //DELAY BUTTON
    self.delayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.delayButton.frame = CGRectMake(10, 100, 100, 30);
    [self.delayButton addTarget:self action:@selector(showEffectView) forControlEvents:UIControlEventTouchUpInside];
    [self.delayButton setTitle:@"delay" forState:UIControlStateNormal];
    UIImage *reverb = [UIImage imageNamed:@"delay.png"];
    
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
}



-(void)showEffectView
{
  CGRect effectFrame = CGRectMake(self.screenWidth/2, 0, self.screenWidth/2, self.screenHeight/2);
 // CGRect effectFrameOffScreen = CGRectMake(self.screenWidth/2 +500, 0, self.screenWidth/2, self.screenHeight/2);
   
    if(delayInView)
    {
        [UIView animateWithDuration:1.0 animations:^{self.effectView.frame = effectFrame;}];
        delayInView = FALSE;
    }
    else
    {
//        [UIView animateWithDuration:1.0 animations:^{self.effectView.frame = effectFrameOffScreen;}];
//        delayInView = TRUE;
       [self hideAllEffects];
    }
}

-(void)showMoogLadderView
{
    CGRect effectFrame = CGRectMake(self.screenWidth/2, 0, self.screenWidth/2, self.screenHeight/2);
   // CGRect effectFrameOffScreen = CGRectMake(self.screenWidth/2 +500, 0, self.screenWidth/2, self.screenHeight/2);
    
    if(moogLadderInView)
    {
        [UIView animateWithDuration:1.0 animations:^{self.moogLadderView.frame = effectFrame;}];
        moogLadderInView = FALSE;
    }
    else
    {
//        [UIView animateWithDuration:1.0 animations:^{self.moogLadderView.frame = effectFrameOffScreen;}];
//        moogLadderInView = TRUE;
        [self hideAllEffects];
        
    }
    
}


-(void)showReverbView
{
    CGRect effectFrame = CGRectMake(self.screenWidth/2, 0, self.screenWidth/2, self.screenHeight/2);
   // CGRect effectFrameOffScreen = CGRectMake(self.screenWidth/2 +500, 0, self.screenWidth/2, self.screenHeight/2);
    
    if(reverbInView)
    {
        [UIView animateWithDuration:1.0 animations:^{self.reverbView.frame = effectFrame;}];
        reverbInView = FALSE;
    }
    else
    {
//        [UIView animateWithDuration:1.0 animations:^{self.reverbView.frame = effectFrameOffScreen;}];
//        reverbInView = TRUE;

        [self hideAllEffects];
    }
}


-(void)setDelayTimeSlider:(UISlider*)sender
{
    NSLog(@"%f", sender.value);
    
    self.delaySliderLabel.text = [@((float)sender.value) stringValue];
    [model setDelayTimeSlider:sender.value];
}

-(void)setMoogLadderCutoffSlider:(UISlider*)sender
{
    NSLog(@"%f", sender.value);
    [model setMoogCutoffSlider:sender.value];
}

-(void)setMoogLadderResonanceSlider:(UISlider*)sender
{
    NSLog(@"%f", sender.value);
    [model setMoogResonanceSlider:sender.value];
}

-(void)setMoogLadderMixSlider:(UISlider*)sender
{
    NSLog(@"%f", sender.value);
    [model setMoogMixSlider:sender.value];
}

-(void)hideAllEffects
{
   // CGRect effectFrame = CGRectMake(self.screenWidth/2, 0, self.screenWidth/2, self.screenHeight/2);
    CGRect effectFrameOffScreen = CGRectMake(self.screenWidth/2 +500, 0, self.screenWidth/2, self.screenHeight/2);
    
    [UIView animateWithDuration:1.0 animations:^{self.reverbView.frame = effectFrameOffScreen;}];
    [UIView animateWithDuration:1.0 animations:^{self.moogLadderView.frame = effectFrameOffScreen;}];
    [UIView animateWithDuration:1.0 animations:^{self.effectView.frame = effectFrameOffScreen;}];
    
    reverbInView = TRUE;
    moogLadderInView = TRUE;
    delayInView = TRUE;
    
}

//
//- (void)showMoogLadder
//{
//    self.moogLadderViewController = [[MoogLadderViewController alloc]init];
//    self.moogLadderViewController.view.backgroundColor = [UIColor orangeColor];
//    [self.navigationController pushViewController:self.moogLadderViewController animated:YES];
//}
//
//- (void)showReverb
//{
//    self.reverbViewController = [[ReverbViewController alloc]init];
//    self.reverbViewController.view.backgroundColor = [UIColor purpleColor];
//    [self.navigationController pushViewController:self.reverbViewController animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
