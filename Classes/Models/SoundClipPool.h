//
//  SoundClipPool.h
//  Accelerometer
//
//  Created by Dwayne Mercredi on 11/4/10.
//  Copyright 2010 Invisible Software Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@protocol SoundClipPoolDelegate;

@interface SoundClipPool : NSObject <AVAudioPlayerDelegate> {
	NSMutableArray *availableClips;
	NSMutableArray *activeClips;
	id<SoundClipPoolDelegate> delegate;
}

- (void) playRandomClip;
- (void) addSoundClip: (AVAudioPlayer *) clip;

@property (nonatomic, assign) id<SoundClipPoolDelegate> delegate;

@end

@protocol SoundClipPoolDelegate<NSObject>

- (void) soundClipPoolDidFinishPlaying: (SoundClipPool *) pool;

@end