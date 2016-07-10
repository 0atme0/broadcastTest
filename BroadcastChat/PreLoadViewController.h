//
//  PreLoadViewController.h
//  BroadcastChat
//
//  Created by Andrey Ildyakov on 10.07.16.
//  Copyright © 2016 111. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatViewController.h"
#import "AsyncNetwork.h"



@interface PreLoadViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nickText;
- (IBAction)nickAction:(id)sender;



@end
