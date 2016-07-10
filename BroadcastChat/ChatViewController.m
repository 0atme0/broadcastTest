//
//  ViewController.m
//  BroadcastChat
//
//  Created by Andrey Ildyakov on 10.07.16.
//  Copyright © 2016 111. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create and configure the broadcaster
    self.broadcaster = [AsyncBroadcaster new];
    self.broadcaster.port = 50001;
    self.broadcaster.ignoreSelf = YES;
    self.broadcaster.delegate = self;
    
    // start the broadcaster
    [self.broadcaster start];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendAction:(UIButton *)sender {
    
    // get and encode the message from the text field
    NSString *message = self.sendText.text;
    NSData *encodedMessage = [message dataUsingEncoding:NSUTF8StringEncoding];
    
    // broadcast the encoded message
    [self.broadcaster broadcast:encodedMessage];
    
    // log
    self.chatText.text = [self.chatText.text stringByAppendingFormat:@">> %@\n", message];
    
    // clear the input text field
    self.sendText.text = @"";

}

- (IBAction)keyboardHide:(id)sender {
    
    [self.view endEditing:YES];
}

- (IBAction)endTapp:(id)sender {
    
    [self.view endEditing:YES];

}


#pragma mark - AsyncBroadcasterDelegate

- (void)broadcaster:(AsyncBroadcaster *)theBroadcaster didReceiveData:(NSData *)data fromHost:(NSString *)host;
{
    // decode and display the message
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    self.chatText.text = [self.chatText.text stringByAppendingFormat:@"<< [%@:%ld] %@\n", host, theBroadcaster.port, message];
}

- (void)broadcaster:(AsyncBroadcaster *)theBroadcaster didFailWithError:(NSError *)error;
{
    self.chatText.text = [self.chatText.text stringByAppendingFormat:@"[error] %@\n", error.localizedDescription];
}



@end
