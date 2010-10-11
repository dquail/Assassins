//
//  AssassinateHUD.h
//  Assassins
//
//  Created by David Quail on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weapon.h"
#import "RayGun.h"

@interface AssassinateHUDViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
	UIImagePickerController *camera;
	UIView *overlay;
	UIImageView *targetPhotoView;
	UIImageView *weaponView;
	
	BOOL isTargetLocked;
	
	UIImage *targetImage;
	
	NSArray *weapons;
	id<Weapon> currentWeapon;
}
@property (nonatomic, retain) IBOutlet UIView *overlay;
@property (nonatomic, retain) IBOutlet UIImageView *targetPhotoView;
@property (nonatomic, retain) IBOutlet UIImageView *weaponView;

@property (nonatomic, retain) UIImage *targetImage;

- (IBAction) onLockTarget; 
//Temporary until we trigger an attack via shake
- (IBAction) onAttackButtonPressed;

- (void) attack;
- (void) finishAttack;
@end
