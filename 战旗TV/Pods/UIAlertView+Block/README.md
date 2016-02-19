# UIAlertView+Block

UIAlertView category to replace UIAletViewDelegate by block

## Usage

    [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you want to delete this item?"
                      cancelButtonTitle:@"Cancel" otherButtonTitle:@"Delete"]
     showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
         if (buttonIndex == 1) {
             // delete
         }
     }];


    [[[UIAlertView alloc] initWithTitle:@"Alert" message:@"What do you want?"
                      cancelButtonTitle:@"Cancel"
                      otherButtonTitles:@[@"Mark as unread", @"Archive", @"Delete"]]
     showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
         if (buttonIndex == 1) {
             // mark as unread
         } else if (buttonIndex == 2) {
             // archive
         } else if (buttonIndex == 3) {
             // delete
         }
     }];


    [[[UIAlertView alloc] initWithMessage:@"Timer done"
                        cancelButtonTitle:@"Okay"]
     showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        // stop timer sound
     }];
