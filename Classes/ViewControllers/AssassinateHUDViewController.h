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
	UIImageView *attackImageView;
	UIImageView *killView;
	BOOL isTargetLocked;
	
	UIImage *targetImage;
	
	NSArray *weapons;
	id<Weapon> currentWeapon;
	
	//Temp variable for tracking attack count.  move to game model in future
	int tmpAttackCount;
}
@property (nonatomic, retain) IBOutlet UIView *overlay;
@property (nonatomic, retain) IBOutlet UIImageView *targetPhotoView;
@property (nonatomic, retain) IBOutlet UIImageView *weaponView;
@property (nonatomic, retain) IBOutlet UIImageView *attackImageView;
@property (nonatomic, retain) IBOutlet UIImageView *killView;

@property (nonatomic, retain) UIImage *targetImage;

- (IBAction) onLockTarget; 
//Temporary until we trigger an attack via shake
- (IBAction) onAttackButtonPressed;

- (void) attack;
- (void) finishAttack;
@end
