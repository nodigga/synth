//
//  VariableDelay.h
//  synth
//
//  Created by Nicholas Cardinal on 1/14/16.
//  Copyright © 2016 nicholas.cardinal. All rights reserved.
//

#import "AKInstrument.h"
#import "AKFoundation.h"

@interface VariableDelay : AKInstrument

@property (nonatomic, strong)AKInstrumentProperty *delayTime, *mix, *maximumDelayTime;
@property(readonly) AKStereoAudio *auxOutput;

//@property AKParameter *delayTime, *mix, *maximumDelayTime;;

-(instancetype)initWithAudioSource:(AKStereoAudio*)audioSource;


@end
