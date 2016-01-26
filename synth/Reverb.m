//
//  Reverb.m
//  synth
//
//  Created by Nicholas Cardinal on 1/25/16.
//  Copyright © 2016 nicholas.cardinal. All rights reserved.
//

#import "Reverb.h"

@implementation Reverb

-(instancetype)initWithAudioSource:(AKStereoAudio *)audioSource
{
    self = [super init];
    if(self)
    
    {
        _cutoffFrequency = [self createPropertyWithValue:4000 minimum:0 maximum:20000];
        _feedback = [self createPropertyWithValue:0.5 minimum:0 maximum:1];
        _mix = [self createPropertyWithValue:0.5 minimum:0 maximum:1];
        
        AKReverb *reverb = [[AKReverb alloc]initWithLeftAudio:audioSource.leftOutput rightAudio:audioSource.rightOutput];
        
        _cutoffFrequency = reverb.cutoffFrequency;
        _feedback = reverb.feedback;
        [self connect:reverb];
        
        
        AKMix *leftMix = [[AKMix alloc]initWithInput1:audioSource.leftOutput input2:reverb balance:akp(0.5)];
        AKMix *rightMix = [[AKMix alloc]initWithInput1:audioSource.rightOutput input2:reverb balance:akp(0.5)];
        
    
        _auxOutput = [AKStereoAudio globalParameter];
        
       [self assignOutput:_auxOutput to:[[AKStereoAudio alloc]initWithLeftAudio:leftMix
                                                                      rightAudio:rightMix]];
        
        [self resetParameter:audioSource];
    
        
    }

    return self;
}



@end
