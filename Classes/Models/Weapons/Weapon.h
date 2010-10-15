//
//  Weapon.h
//  Assassins
//
//  Created by David Quail on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol Weapon <NSObject>

//The static image of the weapon
@property (nonatomic, retain) UIImage *image;

//The array of images to animate during attack
@property (nonatomic, retain) NSArray *attackImages;

//The array of images to animate during kill
@property (nonatomic, retain) NSArray *killImages;

//The image to overlay after kill is done
@property (nonatomic, retain) UIImage *killOverlayImage;

//This edits the image with the weapons kill effect
- (UIImage*) finishAttack:(UIImage *)image;

//This just attacks.  Not really used now since attack annimations are controlled by the attackImageArray
- (void) attack;

//Todo - Add an attack sound
//Todo - Add an kill sound
@end