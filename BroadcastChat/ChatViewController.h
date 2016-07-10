//
//  ViewController.h
//  BroadcastChat
//
//  Created by Andrey Ildyakov on 10.07.16.
//  Copyright © 2016 111. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncNetwork.h"

@interface ChatViewController : UIViewController <AsyncBroadcasterDelegate>

@property (strong) AsyncBroadcaster *broadcaster;
@property (weak, nonatomic) IBOutlet UITextView *chatText;
@property (weak, nonatomic) IBOutlet UITextField *sendText;
- (IBAction)sendAction:(UIButton *)sender;
- (IBAction)keyboardHide:(id)sender;
- (IBAction)endTapp:(id)sender;

@end

