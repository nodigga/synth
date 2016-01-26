//
//  Reverb.h
//  synth
//
//  Created by Nicholas Cardinal on 1/25/16.
//  Copyright © 2016 nicholas.cardinal. All rights reserved.
//

#import "AKFoundation.h"

@interface Reverb : AKInstrument

@property(nonatomic) AKParameter *mix;
@property(nonatomic) AKParameter *cutoffFrequency;
@property(nonatomic) AKParameter *feedback;

@property(nonatomic) AKStereoAudio *auxOutput;

-(instancetype)initWithAudioSource:(AKStereoAudio *)audioSource;

@end
