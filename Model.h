//
//  Model.h
//  synth
//
//  Created by Nicholas Cardinal on 12/20/15.
//  Copyright © 2015 nicholas.cardinal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface Model : NSObject <ViewControllerDelegate>

@property BOOL switchOn;

@property(readwrite) NSArray *octaveOne, *octaveTwo;
@property NSMutableArray *frequencies;



-(void)noteOn:(NSInteger)key;
-(void)noteOff:(NSInteger)key;

-(void)setDelayTimeSlider:(float)delayTime;

-(void)setMoogCutoffSlider:(float)cutoff;
-(void)setMoogResonanceSlider:(float)resonance;
-(void)setMoogMixSlider:(float)mix;



+(id) sharedModel;


@end
