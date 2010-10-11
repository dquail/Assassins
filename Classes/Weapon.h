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
@property (nonatomic, retain) NSArray *attackImageArray;

//The array of images to animate during kill
@property (nonatomic, retain) NSArray *killImageArray;

//This edits the image with the weapons kill effect
- (UIImage*) attack:(UIImage *)image;

//Todo - Add an attack sound
//Todo - Add an kill sound
@end