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

//The image overlayed after a kill
@property (nonatomic, retain) UIImage *killOverlayImage;

//This edits the image with the weapons kill effect
//DQ - Probably won't use these 2 methods in future.  we'll have a game controller
// responsible for attack logic.  Weapon will just be a data source for attack %, and attack and finish images
- (UIImage *) finishAttack:(UIImage *)img;
- (void) attack;
@end
