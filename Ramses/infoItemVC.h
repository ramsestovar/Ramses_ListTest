//
//  infoItemVC.h
//  Ramses
//
//  Created by Reny Hernandez on 24/3/16.
//  Copyright © 2016 Ramsesa Tovar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface infoItemVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;
@property (weak, nonatomic) IBOutlet UITextView *itemDescription;
@property (weak, nonatomic) IBOutlet UILabel *itemCompany;
@property (weak, nonatomic) IBOutlet UILabel *itemDate;
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;


//Variables enviadas por el Segue
@property(nonatomic,strong) NSString * imagen;
@property(nonatomic, strong) NSString *pricelabel;
@property(nonatomic,strong) NSString * priceamount;
@property(nonatomic, strong) NSString *pricecurrency;
@property(nonatomic,strong) NSString * contentType;
@property(nonatomic, strong) NSString *rights;
@property(nonatomic,strong) NSString * link;
@property(nonatomic, strong) NSString *categorylabel;
@property(nonatomic,strong) NSString * categoryimid;
@property(nonatomic, strong) NSString *categoryterm;
@property(nonatomic,strong) NSString * categoryscheme;
@property(nonatomic,strong) NSString * date;
@property(nonatomic,strong) NSString * summary;
@property(nonatomic,strong) NSString * name;
@property(nonatomic,strong) NSString * tituloapp;
@property(nonatomic,strong) NSData * imagenServidor;

@end
