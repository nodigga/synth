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

@property(nonatomic, strong) AKSlider *delaySlider;

@property(nonatomic, strong) KeyboardViewController *keyboardViewController;
@property(nonatomic, strong) MoogLadderViewController *moogLadderViewController;
@property(nonatomic, strong) ReverbViewController *reverbViewController;

@property(nonatomic, strong) UIButton *moogLadderButton, *reverbButton, *octaveButton, *delayButton;
@property(nonatomic, strong) UISwitch *octaveSwitch;

//INSTRUMENT PROPERTIES

@property(nonatomic, strong) AKInstrumentProperty  *feedback, *mix, *time;


@property UIView *effectView;
@property BOOL switchOn;


@end

