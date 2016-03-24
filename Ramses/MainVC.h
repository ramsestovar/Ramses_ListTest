//
//  MainVC.h
//  Ramses
//
//  Created by Reny Hernandez on 24/3/16.
//  Copyright © 2016 Ramsesa Tovar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *Labeltitulo;
@property (weak, nonatomic) IBOutlet UILabel *LabelAppRights;
@property (weak, nonatomic) IBOutlet UILabel *LabelTituloApp;
@property (weak, nonatomic) IBOutlet UILabel *LabelUpdateApp;

@property (weak, nonatomic) IBOutlet UITableView *listView;

@end
