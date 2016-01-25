//
//  MoogLadderFilter.h
//  synth
//
//  Created by Nicholas Cardinal on 1/24/16.
//  Copyright © 2016 nicholas.cardinal. All rights reserved.
//

#import "AKFoundation.h"

@interface MoogLadderFilter : AKInstrument

@property(nonatomic) AKInstrumentProperty *cutoffFrequency;
@property(nonatomic) AKInstrumentProperty *resonance;
@property(nonatomic) AKInstrumentProperty *mix;

@property(nonatomic) AKStereoAudio *auxOutput;

-(instancetype)initWithAudioSource:(AKStereoAudio*)audiosource;

@end
