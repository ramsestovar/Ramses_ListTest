//
//  tableViewCell.h
//  Ramses
//
//  Created by Reny Hernandez on 24/3/16.
//  Copyright © 2016 Ramsesa Tovar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tableViewCell : UITableViewCell

@property(nonatomic) IBOutlet UIImageView * imgIcon;
@property(nonatomic) IBOutlet UILabel * title;
@property(nonatomic) IBOutlet UILabel * category;
@property(nonatomic) IBOutlet UILabel * priceAmount;

@end
