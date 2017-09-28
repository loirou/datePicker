//
//  ViewController.m
//  datePicker
//
//  Created by 刘东 on 2017/9/26.
//  Copyright © 2017年 xxx. All rights reserved.
//

#import "ViewController.h"
#import "SRCollectionViewCell.h"
#import "CollectionHeadReusableView.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger dayNumber;
    NSInteger firstDaySign;
    
    NSInteger currentYear;
    NSInteger currentMonth;
    
}
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong) NSArray *weekdays;
@property (nonatomic,strong) NSDate *currentDate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dayNumber = 0;
    firstDaySign = 0;
    _weekdays = [NSArray arrayWithObjects: [NSNull null],@"星期日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    //    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    //    [calendar setTimeZone: timeZone];
    //    NSDate *date = [NSDate date];
    //    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    //    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    //    NSLog(@"%@", [_weekdays objectAtIndex:theComponents.weekday]);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 500) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"SRCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SRCollectionViewCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionHeadReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeadReusableView"];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];

    [self refreshData:0];
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section == 0){
        return 7;
    }else{
        return dayNumber;
    }
}

//每个Cell展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SRCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRCollectionViewCell" forIndexPath:indexPath];
    cell.dateLabel.text = @"";
    cell.moneyLabel.text = @"";
    cell.ticketLabel.text = @"";
    cell.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.section ==0) {
        cell.moneyLabel.text = _weekdays[indexPath.row+1];
    }else{
        
        if (indexPath.row< firstDaySign) {
            
        }else{
            cell.dateLabel.text = [NSString stringWithFormat:@"%02ld",indexPath.row-firstDaySign+1];
            cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:0.6];
            if (indexPath.row%3==1) {
                cell.moneyLabel.text = [NSString stringWithFormat:@"¥%ld",indexPath.row*100];
                cell.ticketLabel.text = [NSString stringWithFormat:@"余%ld",indexPath.row*2];
                
            }
        }
    }
    return cell;
}

//指定 cell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/7, self.view.frame.size.width/7);
}

//定义页眉的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return  CGSizeMake(0, 0);
    }
    return CGSizeMake(self.view.frame.size.width, 50);
}

//为collection view添加一个补充视图(页眉或页脚),可自定义,对应表视图的section头和尾视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader &&indexPath.section ==0) {
        CollectionHeadReusableView * myHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier: @"CollectionHeadReusableView" forIndexPath: indexPath];
        myHeadView.titleLabel.text = [NSString stringWithFormat:@"-   %ld年%ld月   -",currentYear,currentMonth];
        
        myHeadView.lastClick = ^{
            [self refreshData:-1];
        };
        myHeadView.nextClick = ^{
            [self refreshData:1];
        };
        return myHeadView;
    }else{
        return nil;
    }
}

- (void)refreshData:(NSInteger)index{
    //1.初始化,现在date
    if (index == 0||!self.currentDate) {
        self.currentDate =  [NSDate date];
    }
    //2.获取当前选择的date
    NSDate *currentDate = self.currentDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:index];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    self.currentDate  = newdate;
    
    NSString *dateStr = [formatter stringFromDate:newdate];
    NSLog(@"date str = %@", dateStr);
    
    //记录当前选择年,月,为了刷新头部
    unsigned unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self.currentDate];
    currentYear = (long)components.year;
    currentMonth = (long)components.month;
    
    //3.获取这个月总天数,填充数据源
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.currentDate];
    NSUInteger numberOfDaysInMonth = range.length;
    NSLog(@"%lu", (unsigned long)numberOfDaysInMonth);
    
    //4.获取这个月的第一天为周几
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal
                               components:NSCalendarUnitYear | NSCalendarUnitMonth
                               fromDate:self.currentDate];
    lastMonthComps.day = 1;
    NSDate *firstDay = [cal dateFromComponents:comps];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *firsComponents = [cal components:calendarUnit fromDate:firstDay];
    
    NSLog(@"%@", [_weekdays objectAtIndex:firsComponents.weekday]);
    
    firstDaySign = firsComponents.weekday -1;
    dayNumber = numberOfDaysInMonth + firstDaySign;
    
    [_collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
