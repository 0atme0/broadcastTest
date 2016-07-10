//
//  PreLoadViewController.m
//  BroadcastChat
//
//  Created by Andrey Ildyakov on 10.07.16.
//  Copyright © 2016 111. All rights reserved.
//

#import "PreLoadViewController.h"

@interface PreLoadViewController ()

@end

@implementation PreLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([[segue identifier] isEqualToString:@"nickSegue"])
    {
        ChatViewController *vc = [segue destinationViewController];
        vc.nick = _nickText.text;
    }
    
}


- (IBAction)nickAction:(id)sender {
    
}
@end
