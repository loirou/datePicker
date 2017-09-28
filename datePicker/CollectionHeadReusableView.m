//
//  CollectionHeadReusableView.m
//  datePicker
//
//  Created by 刘东 on 2017/9/26.
//  Copyright © 2017年 xxx. All rights reserved.
//

#import "CollectionHeadReusableView.h"

@implementation CollectionHeadReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)lastClick:(id)sender {
    if (self.lastClick) {
        self.lastClick();
    }
}

- (IBAction)nextClick:(id)sender {
    if (self.nextClick) {
        self.nextClick();
    }
}
@end
