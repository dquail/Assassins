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

@synthesize image, attackImageArray, killImageArray;

- (id) init{
	if (self = [super init]){
		self.image = [UIImage imageNamed:@"RayGun.png"];
		//Todo init all the animation and sounds
	}
	return self;
					  
}
//This the image with the weapons kill effect
- (UIImage *) attack:(UIImage *)img{
	NSLog(@"Fucking up the passed in image");
	return [ImageHelper convolveImageWithEdgeDetection: img];
}

- (void) dealloc{
	[super dealloc];
	[image release];
	[attackImageArray release];
	[killImageArray release];
}
@end
