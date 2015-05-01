//
//  SettingsViewController.m
//  getDone
//
//  Created by Wagner Pinto on 3/29/15.
//  Copyright (c) 2015 weeblu.co LLC. All rights reserved.
//

#import "SettingsViewController.h"
#import "TaskController.h"
#import "User.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end

@implementation SettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //set the view controller properties:
    [self setupViewController];
    //check if the device has a camera.
    [self checkDevice];
    
}

- (void)setupViewController {
    self.userPictureView.layer.cornerRadius = self.userPictureView.frame.size.height / 2;
    self.userPictureView.clipsToBounds = YES;
    self.userPictureView.layer.borderColor = [UIColor grayColor].CGColor;
    self.userPictureView.layer.borderWidth = 0.5f;
    
    PFUser *user = [PFUser currentUser];
    
    self.userNameLabel.text = user[@"userFullName"];
    self.emailLabel.text = user[@"email"];
    
    if (user[@"userPic"] != nil) {
        self.userPictureView.image = user[@"userPic"];
    }else {
        [user[@"UserPicture"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                self.userPictureView.image = image;
            }
        }];
    }
    
}
- (IBAction)logout:(id)sender {
    [PFUser logOut];
}
- (IBAction)takePicture:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Choose Source" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //code
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES; //if you want to edit you need to change the delegate method to allow save the edit image
        picker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //code
        UIImagePickerController *cameraPicker = [[UIImagePickerController alloc]init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES){
            cameraPicker.delegate = self;
            cameraPicker.allowsEditing = YES;
            cameraPicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
            cameraPicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            
            [self presentViewController:cameraPicker animated:YES completion:nil];
        }
    }];
    
    [alertController addAction:libraryAction];
    [alertController addAction:cameraAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)checkDevice {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
}

- (void)savePicture: (UIImage *)picture {

    PFFile *image = [PFFile fileWithData:UIImageJPEGRepresentation(picture,0.9)];
    [image saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            if (succeeded) {
                PFUser *user = [PFUser currentUser];
                user[@"UserPicture"] = image;
                [user saveInBackground];
            }
        } else {
            NSLog(@"%@",error);
        }        
    }];
}

#pragma mark - PICKERVIEW DELEGATE
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.userPictureView.image = chosenImage;
    [self savePicture:self.userPictureView.image];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
