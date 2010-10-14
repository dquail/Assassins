//
//  AssassinateHUD.m
//  Assassins
//
//  Created by David Quail on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AssassinateHUDViewController.h"

@interface AssassinateHUDViewController (Private)
- (void) onChangeWeapon:(id<Weapon>) weapon;
@end

@implementation AssassinateHUDViewController

@synthesize targetPhotoView, overlay, targetImage, weaponView, attackImageView;
#pragma mark -
#pragma mark ViewController lifecycle

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		//TODO - Set all the weapons, not just the current weapon.
		currentWeapon = [[RayGun alloc] init];
		self.weaponView.image = currentWeapon.image;
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];		
	self.targetPhotoView.image = self.targetImage;
	self.weaponView.image = currentWeapon.image;	
	
	if (!isTargetLocked){
		camera  = [[UIImagePickerController alloc] init];
		camera.sourceType =  UIImagePickerControllerSourceTypeCamera;
		camera.delegate = self;
		camera.allowsEditing = NO;
		camera.showsCameraControls = NO;
		camera.toolbarHidden = YES;
		camera.wantsFullScreenLayout = YES;
		camera.cameraOverlayView = self.overlay;
	}

}

- (void) viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	if (!isTargetLocked	)
		[self presentModalViewController:camera animated:YES];
	
	
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[camera release];
	[overlay release];
	[targetImage release]; 
	[weaponView release]; 
	[attackImageView release];	
}

#pragma mark CameraOverlay callbacks 
- (IBAction) onLockTarget{
	//Take a photo of the target.  
	self.overlay.alpha = 0.0f;
	[camera takePicture];
}

#pragma mark -
#pragma mark UIImagePickerController delegate
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo; 
{
	if (!error) 
		NSLog(@"Image written to photo album");
	else
		NSLog(@"Error writing to photo album: %@", [error localizedDescription]);
	self.overlay.alpha = 1.0f;
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	self.targetImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
	self.targetPhotoView.image = self.targetImage;
	
	[self.view setNeedsDisplay];
	isTargetLocked = YES;
	[self dismissModalViewControllerAnimated:YES];
	//UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark - 
#pragma mark Attack callbacks

- (IBAction) onAttackButtonPressed{
	[self attack];
}

- (void) attack{

	
	//Triggering finishAttack will have to be based on the success of the attack.
	//For now, we'll just manually finish the Attack after the first attack attempt
	
	self.attackImageView.animationImages = currentWeapon.attackImages;
	self.attackImageView.animationDuration = 0.5f;
	self.attackImageView.animationRepeatCount = 2;
	[self.attackImageView startAnimating];
	
	//[self finishAttack];
}

- (void) finishAttack{
	self.targetPhotoView.image = [currentWeapon finishAttack:self.targetImage];
	[self.view setNeedsDisplay];	
}

#pragma mark -
#pragma mark Menu callbacks
- (void) onChangeWeapon:(id<Weapon>) weapon{
	currentWeapon = weapon;
	self.weaponView.image = currentWeapon.image;
	[self.view setNeedsDisplay];
}
@end
