//
//  KeyboardViewController.h
//  synth
//
//  Created by nicholas.cardinal on 11/15/15.
//  Copyright © 2015 nicholas.cardinal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMOscillator.h"

@interface KeyboardViewController : UIViewController

@property UIView *keysView;

@property(nonatomic, strong) FMOscillator *fmOscillator;
@property(nonatomic, strong) NSArray *frequency;

@property NSInteger *note;

//@property(nonatomic, strong) FMOscillatorNote *fmOscillatorNote;

@end
