//
//  VariableDelay.m
//  synth
//
//  Created by Nicholas Cardinal on 1/14/16.
//  Copyright © 2016 nicholas.cardinal. All rights reserved.
//

#import "VariableDelay.h"

@implementation VariableDelay

-(instancetype)initWithAudioSource:(AKStereoAudio *)audioSource
{
    self = [super init];
    if(self)
    {
        //Instrument Control
        _delayTime = [self createPropertyWithValue:0.5 minimum:0 maximum:5];
        _mix = [self createPropertyWithValue:0.5 minimum:0.0 maximum:1.0];
        
        //Instrument Definition
        
        AKVariableDelay *leftVariableDelay = [AKVariableDelay delayWithInput:audioSource.leftOutput];
        leftVariableDelay.delayTime = _delayTime;
        [self connect:leftVariableDelay];
        
        AKVariableDelay *rightVariableDelay = [AKVariableDelay delayWithInput:audioSource.rightOutput];
        rightVariableDelay.delayTime  = _delayTime;
        [self connect:rightVariableDelay];
        
        //Mixing Dry Signal With
        
        AKMix *leftMix = [[AKMix alloc]initWithInput1:audioSource.leftOutput
                                               input2:leftVariableDelay
                                              balance:_mix];
        
        AKMix *rightMix = [[AKMix alloc]initWithInput1:audioSource.rightOutput
                                                input2:rightVariableDelay
                                               balance:_mix];
        
//      //Output to global effects Processing
//    
//        _auxOutput = [AKStereoAudio globalParameter];
//        
//        [self assignOutput:_auxOutput to:[[AKStereoAudio alloc]initWithLeftAudio:leftMix rightAudio:rightMix]];
//        
        
        // Main Audio Output
        
        AKAudioOutput *audio = [[AKAudioOutput alloc]initWithLeftAudio:leftMix rightAudio:rightMix];
        [self connect:audio];
        
        
        
    // Reset Inputs
        [self resetParameter:audioSource];
    }


    return self;
}


@end
