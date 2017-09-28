//
//  CollectionHeadReusableView.h
//  datePicker
//
//  Created by 刘东 on 2017/9/26.
//  Copyright © 2017年 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickBlock)(void);

@interface CollectionHeadReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *lastBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)lastClick:(id)sender;
- (IBAction)nextClick:(id)sender;

@property(nonatomic,copy)ClickBlock lastClick;
@property(nonatomic,copy)ClickBlock nextClick;

@end
