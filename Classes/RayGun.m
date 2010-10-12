//
//  RayGun.m
//  Assassins
//
//  Created by David Quail on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RayGun.h"
#import "ImageHelper-ImageProcessing.h"

@implementation RayGun

@synthesize image, attackImages, killImages;

- (id) init{
	if (self = [super init]){
		self.image = [UIImage imageNamed:@"RayGun.png"];
		//Todo init all the animation and sounds
		self.attackImages = [NSArray arrayWithObjects:
								  [UIImage imageNamed:@"RayAttack1.png"],
								  [UIImage imageNamed:@"RayAttack2.png"],
								  [UIImage imageNamed:@"RayAttack3.png"],
								  [UIImage imageNamed:@"RayAttack4.png"],
								  [UIImage imageNamed:@"RayAttack5.png"],
								  [UIImage imageNamed:@"RayAttack6.png"],	
								  [UIImage imageNamed:@"RayAttack7.png"],
								  nil];
	}
	return self;
					  
}
//This the image with the weapons kill effect
- (UIImage *) finishAttack:(UIImage *)img{
	NSLog(@"Fucking up the passed in image");
	return [ImageHelper convolveImageWithEdgeDetection: img];
}

- (void) attack{
	//Don't do anything here.  
	//Future we may add a delegate to the Weapon protocol to call back to with attack success etc.
}

- (void) dealloc{
	[super dealloc];
	[image release];
	[attackImages release];
	[killImages release];
}
@end
