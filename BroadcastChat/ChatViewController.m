//
//  ViewController.m
//  BroadcastChat
//
//  Created by Andrey Ildyakov on 10.07.16.
//  Copyright © 2016 111. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()
{

}

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
}

- (IBAction)sendAction:(UIButton *)sender {
    
    // get and encode the message from the text field
    NSString *message = self.sendText.text;
    
    NSDictionary *jsonObject = @{@"nick": self.nick,
                                 @"message":message};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];

 
    // broadcast message
    [self.broadcaster broadcast:jsonData];
    
    // log
    self.chatText.text = [self.chatText.text stringByAppendingFormat:@"%@>> %@\n", self.nick, message];

    
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

    
    NSDictionary *parsedJSONObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

    if ([[parsedJSONObject objectForKey:@"nick"] isEqualToString:@""]) {
        
            self.chatText.text = [self.chatText.text stringByAppendingFormat:@"<< [%@] %@\n",host,[parsedJSONObject objectForKey:@"message"]];
    }  else {
            self.chatText.text = [self.chatText.text stringByAppendingFormat:@"<< [%@] %@\n",[parsedJSONObject objectForKey:@"nick"],[parsedJSONObject objectForKey:@"message"]];
    }


}

- (void)broadcaster:(AsyncBroadcaster *)theBroadcaster didFailWithError:(NSError *)error;
{
    self.chatText.text = [self.chatText.text stringByAppendingFormat:@"[error] %@\n", error.localizedDescription];
}



@end
