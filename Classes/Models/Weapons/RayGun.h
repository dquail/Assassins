//
//  RayGun.h
//  Assassins
//
//  Created by David Quail on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Weapon.h"

@interface RayGun : NSObject <Weapon> {
	UIImage *image;
	NSArray *attackImages;
	NSArray *killImages;
}

@property (nonatomic, retain) UIImage *image;

//The array of images to animate during attack
@property (nonatomic, retain) NSArray *attackImages;

//The array of images to animate during kill
@property (nonatomic, retain) NSArray *killImages;

//This edits the image with the weapons kill effect
- (UIImage *) finishAttack:(UIImage *)img;
- (void) attack;
@end
