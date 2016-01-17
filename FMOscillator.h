//
//  FMOscillator.h
//  synth
//
//  Created by Nicholas Cardinal on 11/27/15.
//  Copyright © 2015 nicholas.cardinal. All rights reserved.
//

#import "AKInstrument.h"
#import "AKFoundation.h"

@interface FMOscillator : AKInstrument

//@property (readonly) AKAudio *auxilliaryOutput;
@property AKInstrumentProperty *toneColor;

@property(readonly) AKAudio *auxOutput;

@end

//------------------------------------------

# pragma mark   FMOscialltor Note Properties

//------------------------------------------

@interface FMOscillatorNote : AKNote

@property AKNoteProperty *frequency;
@property AKNoteProperty *amplitude;


-(instancetype)initWithFrequency:(float)frequency;

@end
