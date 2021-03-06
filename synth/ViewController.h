//
//  ViewController.h
//  synth
//
//  Created by nicholas.cardinal on 11/11/15.
//  Copyright © 2015 nicholas.cardinal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "MoogLadderViewController.h"
#import "ReverbViewController.h"
#import "FMOscillator.h"
#import "AKFoundation.h"

@class ViewController;  //define class, so protocol can see MyClass

@protocol ViewControllerDelegate <NSObject>  //define delegate protocol

    -(void)octaveDelegate:(ViewController *)sender;  //define delegate method to be implemented within another class

@end // end protocol


@interface ViewController : UIViewController


@property (nonatomic, weak) id<ViewControllerDelegate> delegate; //define ViewControllerSwitchDelegate as delegate

@property(nonatomic) float screenWidth;
@property(nonatomic) float screenHeight;

//Delay Slider
@property(nonatomic, strong) AKSlider *delaySlider;

//MoogLadder Slider
@property(nonatomic, strong) AKSlider *cutoffSlider;
@property(nonatomic, strong) AKSlider *resonanceSlider;
@property(nonatomic, strong) AKSlider *moogMixSlider;

//Reverb Slider
@property(nonatomic, strong) AKSlider *cutoffReverbSlider;
@property(nonatomic, strong) AKSlider *feedbackSlider;
@property(nonatomic, strong) AKSlider *reverbMixSlider;

@property(nonatomic, strong) KeyboardViewController *keyboardViewController;
@property(nonatomic, strong) MoogLadderViewController *moogLadderViewController;
@property(nonatomic, strong) ReverbViewController *reverbViewController;

@property(nonatomic, strong) UIButton *moogLadderButton, *reverbButton, *octaveButton, *delayButton;
@property(nonatomic, strong) UISwitch *octaveSwitch;

//INSTRUMENT PROPERTIES

@property(nonatomic, strong) AKInstrumentProperty  *feedback, *mix, *time;
@property(nonatomic, strong) AKSlider *attack, *decay, *sustain, *released;



@property UIView *effectView, *moogLadderView, *reverbView;
@property BOOL switchOn;


@end

