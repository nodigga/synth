//
//  MoogLadderFilter.m
//  synth
//
//  Created by Nicholas Cardinal on 1/24/16.
//  Copyright © 2016 nicholas.cardinal. All rights reserved.
//

#import "MoogLadderFilter.h"

@implementation MoogLadderFilter


-(instancetype)initWithAudioSource:(AKStereoAudio*)audioSource
{
    self = [super init];
    if(self)
    {
        //Instrument Controls
        
        _cutoffFrequency = [self createPropertyWithValue:200 minimum:0 maximum:20000];
        _resonance = [self createPropertyWithValue:0.5 minimum:0 maximum:.99];
        _mix = [self createPropertyWithValue:0.0 minimum:0 maximum:1.0];
        
        AKMoogLadder *leftMoogLadder = [AKMoogLadder filterWithInput:audioSource.leftOutput];
        leftMoogLadder.cutoffFrequency = _cutoffFrequency;
        leftMoogLadder.resonance = _resonance;
        [self connect:leftMoogLadder];
        
        AKMoogLadder *rightMoogLadder = [AKMoogLadder filterWithInput:audioSource.rightOutput];
        rightMoogLadder.cutoffFrequency = _cutoffFrequency;
        rightMoogLadder.resonance = _resonance;
        [self connect:rightMoogLadder];
        
        AKMix *leftMix = [[AKMix alloc]initWithInput1:audioSource.leftOutput
                                               input2:audioSource.rightOutput
                                              balance:_mix];
        AKMix *rightMix = [[AKMix alloc]initWithInput1:audioSource.leftOutput
                                                input2:audioSource.rightOutput
                                               balance:_mix];
        
        // Output to global effects processing
        _auxOutput = [AKStereoAudio globalParameter];
        
        [self assignOutput:_auxOutput to:[[AKStereoAudio alloc]initWithLeftAudio:leftMix
                                                                      rightAudio:rightMix]];
                          
        [self resetParameter:audioSource];
        
        AKAudioOutput *audio = [[AKAudioOutput alloc]initWithLeftAudio:leftMix rightAudio:rightMix];
        [self connect:audio];  //this needs to be placed on the last fx on the signal chain
        
    }

    return self;
}
@end