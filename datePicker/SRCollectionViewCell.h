//
//  SRCollectionViewCell.h
//  datePicker
//
//  Created by 刘东 on 2017/9/26.
//  Copyright © 2017年 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketLabel;

@end
