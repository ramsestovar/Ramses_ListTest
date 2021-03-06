//
//  MainVC.m
//  Ramses
//
//  Created by Reny Hernandez on 24/3/16.
//  Copyright © 2016 Ramsesa Tovar. All rights reserved.
//

#import "MainVC.h"
#import "tableViewCell.h"
#import "infoItemVC.h"
#import <CommonCrypto/CommonDigest.h>

@interface MainVC ()

@end

@implementation MainVC{
    NSDictionary *jsonServidor;
    NSString *RespuestaLocal;
    NSDictionary *jsonLocal;
    NSArray *arrayItems;
    NSArray *arrayDataApp;
    NSData*imagenServidor;
}

@synthesize LabelAppRights, Labeltitulo, LabelTituloApp, LabelUpdateApp, listView, servicio;

- (void)viewDidLoad {
    [super viewDidLoad];

    if (servicio==nil) {
   
        NSURL * url=[NSURL URLWithString:@"https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"];
        NSData * data=[NSData dataWithContentsOfURL:url];
        NSError * error;

        if (data!=nil)
            {
                jsonServidor = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: &error];
            }
     }
    //obtengo array local
    NSArray *pathsInsert = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectoryInsert = [pathsInsert objectAtIndex:0];
    RespuestaLocal = [NSString stringWithFormat:@"%@/%@", documentsDirectoryInsert,@"json"];
    NSDictionary *arrayJsonLocal = [[NSDictionary alloc] initWithContentsOfFile:RespuestaLocal];
    NSLog(@"%@",arrayJsonLocal);
    
    //encripto en md5 para luego comparar con la respuesta del servidor y saber si ha tenido cambios
    const char *cStr = [RespuestaLocal UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];

    //Si json == null, toma el json local
    if (jsonServidor==nil)
    {
        jsonLocal = [arrayJsonLocal copy];
    }else{
        NSArray *pathsInsert = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * documentsDirectoryInsert = [pathsInsert objectAtIndex:0];
        NSString* filePath2 = [NSString stringWithFormat:@"%@/%@", documentsDirectoryInsert,@"json"];
        [jsonServidor writeToFile:filePath2 atomically:YES];
        //NSLog(@"%@",filePath2);

        const char *cStr = [filePath2 UTF8String];
        unsigned char digest[16];
        CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
        NSMutableString *output2 = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
            [output2 appendFormat:@"%02x", digest[i]];

        if ([output isEqualToString:output2]) {
            jsonLocal = [arrayJsonLocal copy];//en caso de ser igual uso es local
        }else{
            jsonLocal=jsonServidor;
        }
    }

    if (jsonLocal==nil) {//cubro margen de error, no debe llegar nunca nill
        jsonLocal=jsonServidor;
    }

    arrayItems = [[jsonLocal objectForKey:@"feed"] objectForKey:@"entry"];
    [listView setDataSource:self];
    [listView setDelegate:self];

    //Extraemos el nombre de la App y detalles generales
    NSString * title = [[[[jsonLocal objectForKey:@"feed"] objectForKey:@"author"] objectForKey:@"name"] valueForKey:@"label"];
    NSString * titleApp = [[[jsonLocal objectForKey:@"feed"] objectForKey:@"title"] valueForKey:@"label"];
    NSString * rights = [[[jsonLocal objectForKey:@"feed"]objectForKey:@"rights"] valueForKey:@"label"];
    NSString * updated = [[[jsonLocal objectForKey:@"feed"]objectForKey:@"updated"] valueForKey:@"label"];

    Labeltitulo.text = title;
    LabelTituloApp.text = titleApp;
    LabelAppRights.text = rights;
    LabelUpdateApp.text = updated;

}//Finaliza viewDidLoad

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger c= [arrayItems count];
    return c;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableViewCell *celda = (tableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"celda" forIndexPath:indexPath];

    //si la celda no existe, la creamos con su respectivo identificador
    if (!celda)
    {
        celda = [[tableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"celda"];
    }

    NSDictionary *dict = [arrayItems  objectAtIndex:indexPath.row];

    NSString*imagen =[[[dict valueForKey:@"im:image"]valueForKey:@"label" ]objectAtIndex:0];

    NSString*priceamount =[[[dict valueForKey:@"im:price"]valueForKey:@"attributes"]valueForKey:@"amount"];

    if([priceamount isEqualToString:@"0.00000"])
    {
        priceamount = @"Free";
    }

    NSString*categorylabel =[[[dict valueForKey:@"category"]valueForKey:@"attributes"]valueForKey:@"label"];

    NSString*name =[[dict valueForKey:@"im:name"]valueForKey:@"label"];

    NSURL* urlImage = [NSURL URLWithString:imagen];

    // Creamos la conexión de datos
    NSURLRequest *request = [NSURLRequest requestWithURL:urlImage cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0];

    imagenServidor = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    celda.imgIcon.image =[UIImage imageWithData:imagenServidor];

    celda.imgIcon.layer.backgroundColor=[[UIColor clearColor] CGColor];
    celda.imgIcon.layer.cornerRadius=20;
    celda.imgIcon.layer.borderWidth=2.0;
    celda.imgIcon.layer.masksToBounds = YES;
    celda.imgIcon.layer.borderColor=[[UIColor blueColor] CGColor];

    celda.title.text=name;
    celda.category.text=categorylabel;
    celda.priceAmount.text=priceamount;

    return celda;

}//Fin cellForRowAtIndexPath



-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;

    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;

    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);

    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueItem"])
    {
        UIButton * button = (UIButton *)sender;
        UITableViewCell *cellx = (UITableViewCell *)[button superview];
        UITableView *tabla = (UITableView *)[cellx superview];
        NSIndexPath * auxRow = [tabla indexPathForCell:sender];
        NSDictionary *dict = [arrayItems objectAtIndex:[auxRow row]];

        NSString*title =[[dict valueForKey:@"title"]valueForKey:@"label"];
        NSString*imagen =[[[dict valueForKey:@"im:image"]valueForKey:@"label" ]objectAtIndex:2];

        NSString*pricelabel =[[dict valueForKey:@"im:price"]valueForKey:@"label"];

        NSString*name =[[dict valueForKey:@"im:name"]valueForKey:@"label"];

        NSString*priceamount =[[[dict valueForKey:@"im:price"]valueForKey:@"attributes"]valueForKey:@"amount"];

        if([priceamount isEqualToString:@"0.00000"])
        {
            priceamount = @"Free";
        }
        
        NSString*pricecurrency =[[[dict valueForKey:@"im:price"]valueForKey:@"attributes"]valueForKey:@"currency"];
        
        NSString*contentType =[[dict valueForKey:@"im:contentType"]valueForKey:@"label" ];
        
        NSString*rights =[[dict valueForKey:@"rights"]valueForKey:@"label"];
        
        NSString*link =[[dict valueForKey:@"link"]valueForKey:@"label" ];
        
        NSString*categorylabel =[[[dict valueForKey:@"category"]valueForKey:@"attributes"]valueForKey:@"label"];

        NSString*categoryimid =[[[dict valueForKey:@"category"]valueForKey:@"attributes"]valueForKey:@"im:id"];

        NSString*categoryterm =[[[dict valueForKey:@"category"]valueForKey:@"attributes"]valueForKey:@"term"];

        NSString*categoryhref =[[[dict valueForKey:@"category"]valueForKey:@"attributes"]valueForKey:@"scheme"];

        NSString*imreleaseDate =[[[dict valueForKey:@"im:releaseDate"]valueForKey:@"attributes"]valueForKey:@"label"];

        NSString*categoryscheme =[[[dict valueForKey:@"category"]valueForKey:@"attributes"]valueForKey:@"scheme"];

        NSString*summary =[[dict valueForKey:@"summary"]valueForKey:@"label"];

        infoItemVC *parametros = [segue destinationViewController];

        parametros.tituloapp = title;
        parametros.imagen = imagen;
        parametros.pricelabel = pricelabel;
        parametros.priceamount = priceamount;
        parametros.pricecurrency = pricecurrency;
        parametros.contentType = contentType;
        parametros.rights = rights;
        parametros.link = link;
        parametros.categorylabel = categorylabel;
        parametros.categoryimid = categoryimid;
        parametros.categoryterm = categoryterm;
        parametros.categoryscheme = categoryscheme;
        parametros.summary=summary;
        parametros.name=name;
        parametros.link=categoryhref;
        parametros.date=imreleaseDate;

    }

}//Fin prepareForSegue

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
