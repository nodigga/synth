//
//  FMOscillator.m
//  synth
//
//  Created by Nicholas Cardinal on 11/27/15.
//  Copyright © 2015 nicholas.cardinal. All rights reserved.
//

#import "FMOscillator.h"

@implementation FMOscillator

-(instancetype)init {
    self = [super init];
    if(self){
    
        FMOscillatorNote *note = [[FMOscillatorNote alloc] init];
        
        _toneColor = [self createPropertyWithValue:0.5 minimum:0.1 maximum:1.0];
        
        // Instrument Definition ==============================================
        
        AKLinearADSREnvelope *adsr = [AKLinearADSREnvelope envelope];
        
        AKFMOscillator *fmOscillator = [AKFMOscillator presetSpaceWobble];
        fmOscillator.baseFrequency = note.frequency;
        fmOscillator.carrierMultiplier = [_toneColor scaledBy:akp(20)];
        fmOscillator.modulatingMultiplier = [_toneColor scaledBy:akp(12)];
        fmOscillator.amplitude = [adsr scaledBy:akp(0.15)];
        
        // EXTERNAL OUTPUTS ====================================================

        //balls test
        
        //Use code below if not routing audio to other effects
        
        AKStereoAudio *output;
        output = [[AKStereoAudio alloc]initWithLeftAudio:fmOscillator rightAudio:fmOscillator];
        [self setAudioOutput:output];
    
        //define outputs available to others
//        
//        _auxOutput = [AKStereoAudio globalParameter];
//        [self assignOutput:_auxOutput to:fmOscillator];
    
    }
    return self;
}
@end

//-------------------------------
#pragma mark - FMOscillator Note
//-------------------------------

@implementation FMOscillatorNote

-(instancetype)init{
    self = [super init];
    if(self){
    
        _frequency = [self createPropertyWithValue:440 minimum:440 maximum:880];
        _amplitude = [self createPropertyWithValue:1 minimum:0 maximum:1];
        _amplitude.value = 1.0;
    }
    return self;
}

-(instancetype)initWithFrequency:(float)frequency{
    self = [self init];
    if(self){
        _frequency.value = frequency;
    }
    return self;
}

@end