//
//  Model.m
//  synth
//
//  Created by Nicholas Cardinal on 12/20/15.
//  Copyright © 2015 nicholas.cardinal. All rights reserved.
//

#import "Model.h"
#import "KeyboardViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "FMOscillator.h"
#import "VariableDelay.h"


@implementation Model
{
    //Declaring Oscillator and all fx  (these are my class definitions)
    
    FMOscillator *fmOscillator;
    NSMutableDictionary *currentNotes;
    VariableDelay *variableDelay;
    
    
}


    //Making the Model Singleton

+(id)sharedModel
{
    static Model *sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedModel = [[self alloc] init];
    });
    return sharedModel;
}

-(instancetype)init
{
    self = [super init];
    
    if(self)
    {
        self.octaveOne = @[@523.25, @554.37, @587.33, @622.25, @659.26, @698.46, @739.99, @783.99, @830.61, @880.00, @932.33, @987.77, @1046.5];
        self.octaveTwo = @[@1046.5, @1108.73, @1174.66, @1244.51, @1318.51, @1396.91, @1479.98, @1567.98, @1661.22, @1760.00, @1864.66, @1975.53, @2093.00];
        
        
        self.frequencies = [[NSMutableArray alloc]init];
        self.frequencies = [self.octaveOne mutableCopy];
        
        currentNotes = [NSMutableDictionary dictionary];
        
        // Instantiate Instruments
        fmOscillator = [[FMOscillator alloc]init];
        variableDelay = [[VariableDelay alloc]initWithAudioSource:[AKStereoAudio stereoFromMono:fmOscillator.auxOutput]];
        
        // Add Instruments to the Orchestra

        [AKOrchestra addInstrument:fmOscillator];
        [AKOrchestra addInstrument:variableDelay];
        
        [variableDelay play];
        
    }
    return self;
}


- (void)setDelayTimeSlider:(float)delayTime
{
    variableDelay.delayTime.value = delayTime;
}


-(void)octaveDelegate:(ViewController *)sender
{
    NSLog(@"delegate test");
}

-(void)noteOn: (NSInteger)key
{
    
    float freq = [[self.frequencies objectAtIndex:key]floatValue];
    
    FMOscillatorNote *note = [[FMOscillatorNote alloc]initWithFrequency:freq];
    [fmOscillator playNote:note];
    [currentNotes setObject:note forKey:[NSNumber numberWithInt:(int)key]];
}

-(void)noteOff: (NSInteger)key
{
    FMOscillatorNote *noteToRelease = [currentNotes objectForKey:[NSNumber numberWithInt:(int)key]];
    [noteToRelease stop];
    [currentNotes removeObjectForKey:[NSNumber numberWithInt:(int)key]];
}

@end
