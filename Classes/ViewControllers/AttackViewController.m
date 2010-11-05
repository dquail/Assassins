//
//  AttackViewController.m
//  Accelerometer
//
//  Created by Dwayne Mercredi on 10/29/10.
//  Copyright 2010 Invisible Software Inc. All rights reserved.
//

#import "AttackViewController.h"
#import "AttackCompletedViewController.h"

@implementation AttackViewController

#define MAX_PAST_ACCELERATION_EVENTS 2

#define NONSHAKE_DELTA 0.4
#define SHAKE_DELTA 2.0

- (void) completeInitialization {
	shakeEventSource = [[ShakeEventSource alloc] init];
	
	[shakeEventSource addDelegate: self];

	slapClips = [[SoundClipPool alloc] init];
	
	NSString *slapURLs[] = {
		@"sounds/slap.caf",
		@"sounds/slap7.caf",
		@"sounds/slap2.caf",
		@"sounds/slap3.caf",
		@"sounds/slap6.caf",
		@"sounds/slap4.caf",
		@"sounds/slap5.caf",
	};
	
	for (int i = 0; i < (sizeof(slapURLs) / sizeof(slapURLs[0])); i++) {
		NSURL *slapURL = [[[NSBundle mainBundle] bundleURL] URLByAppendingPathComponent: slapURLs[i]];
		
		AVAudioPlayer *slapSound = [[AVAudioPlayer alloc] initWithContentsOfURL: slapURL error: NULL];
		[slapClips addSoundClip: slapSound];
	}
	
	lastSlapTime = CACurrentMediaTime();
	
	responseClips = [[SoundClipPool alloc] init];
	responseClips.delegate = self;
	
	NSString *responseURLs[] = {
		@"sounds/oof.caf",
		@"sounds/uhh.caf",
		@"sounds/ah.caf",
		@"sounds/thathurts.caf",
		@"sounds/hey.caf",
		@"sounds/ow.caf",
		@"sounds/stop.caf",
		@"sounds/stopit.caf",
		@"sounds/whatthehell.caf",
		@"sounds/isthatachicken.caf",
//		@"sounds/threat.caf",
	};
	
	for (int i = 0; i < (sizeof(responseURLs) / sizeof(responseURLs[0])); i++) {
		NSURL *url = [[[NSBundle mainBundle] bundleURL] URLByAppendingPathComponent: responseURLs[i]];
		
		AVAudioPlayer *clip = [[AVAudioPlayer alloc] initWithContentsOfURL: url error: NULL];
		[responseClips addSoundClip: clip];
	}
	
	[NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(checkIfStillSlapping) userInfo: nil repeats: YES];
}

- (id) initWithTargetImage:(UIImage *)image{
	targetImage = [image retain];
	return [self initWithNibName:nil bundle:nil];
}

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		[self completeInitialization];
    }
	
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
		[self completeInitialization];
    }
	
    return self;
}

- (void)dealloc {
	[NSTimer cancelPreviousPerformRequestsWithTarget: self];
	
	responseClips.delegate = nil;
	[responseClips release];
	
	[shakeEventSource removeDelegate: self];
	[shakeEventSource release];
	
	[targetImage release];
	
    [super dealloc];
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void) slap {
	//TODO - Temporray solution to finish an attack after 10 slaps
	if (slapCount++ > 10){
		AttackCompletedViewController *completedController = [[AttackCompletedViewController alloc] initWithTargetImage:targetImage];
		[self.view removeFromSuperview];
		[[[UIApplication sharedApplication] keyWindow] addSubview:completedController.view];
	}
	double currentTime = CACurrentMediaTime();
	if ((currentTime - lastSlapTime) >= 0.15) {
		lastSlapTime = currentTime;
		
		[slapClips playRandomClip];
		
		if (!slapping) {
			[responseClips playRandomClip];
			slapping = YES;
		}
	}
}

- (void) checkIfStillSlapping {
	double currentTime = CACurrentMediaTime();
	
	if ((currentTime - lastSlapTime) >= 0.5) {
		NSLog(@"%lf %lf", currentTime, lastSlapTime);
		slapping = NO;
	}
}

- (void) shake: (int) direction {
	if (direction & AccelerometerShakeDirectionLeft) {
		NSLog(@"AccelerometerShakeDirectionLeft");
	}
	
	if (direction & AccelerometerShakeDirectionRight) {
		NSLog(@"AccelerometerShakeDirectionRight");
	}
	
	if (direction & AccelerometerShakeDirectionUp) {
		[self slap];
		
		NSLog(@"AccelerometerShakeDirectionUp");
	}
	
	if (direction & AccelerometerShakeDirectionDown) {
		[self slap];
		
		NSLog(@"AccelerometerShakeDirectionDown");
	}
	
	if (direction & AccelerometerShakeDirectionPush) {
		NSLog(@"AccelerometerShakeDirectionPush");
	}
	
	if (direction & AccelerometerShakeDirectionPull) {
		NSLog(@"AccelerometerShakeDirectionPull");
	}
}

- (void) playNextResponse {
	if (slapping) {
		[responseClips playRandomClip];
	}
}

- (void) soundClipPoolDidFinishPlaying: (SoundClipPool *) pool {
	// 0.5 - 1.5 second delay
	double delay = 1.5 + (double) (arc4random() % 10) / 10.0;
	
	[NSTimer scheduledTimerWithTimeInterval: delay target: self selector: @selector(playNextResponse) userInfo: nil repeats: NO];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


@end
