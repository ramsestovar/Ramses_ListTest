//
//  infoItemVC.m
//  Ramses
//
//  Created by Reny Hernandez on 24/3/16.
//  Copyright © 2016 Ramsesa Tovar. All rights reserved.
//

#import "infoItemVC.h"

@interface infoItemVC ()

@end

@implementation infoItemVC

@synthesize imagen, pricelabel, priceamount, pricecurrency, contentType, rights, link, categorylabel, categoryimid, categoryscheme, categoryterm, date, summary, name, tituloapp;

@synthesize itemTitle, itemPrice, itemCompany, itemDate, itemDescription, categoryName, itemImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL* urlImage = [NSURL URLWithString:imagen];
    
    // Creamos la conexión de datos
    NSURLRequest *request = [NSURLRequest requestWithURL:urlImage cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0];

    NSData *imagenServidor = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    itemImage.image =[UIImage imageWithData:imagenServidor];
    itemImage.layer.backgroundColor=[[UIColor clearColor] CGColor];
    itemImage.layer.cornerRadius=20;
    itemImage.layer.borderWidth=2.0;
    itemImage.layer.masksToBounds = YES;
    itemImage.layer.borderColor=[[UIColor blueColor] CGColor];

    itemTitle.text = name;
    itemPrice.text = priceamount;
    itemCompany.text = tituloapp;
    itemDate.text = date;
    itemDescription.text = summary;
    categoryName.text = categorylabel;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
