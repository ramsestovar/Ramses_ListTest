//
//  MainVC.m
//  Ramses
//
//  Created by Reny Hernandez on 24/3/16.
//  Copyright © 2016 Ramsesa Tovar. All rights reserved.
//

#import "MainVC.h"
#import "tableViewCell.h"

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

@synthesize LabelAppRights, Labeltitulo, LabelTituloApp, LabelUpdateApp, listView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL * url=[NSURL URLWithString:@"https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json"];
    NSData * data=[NSData dataWithContentsOfURL:url];
    
    NSError * error;

    if (data!=nil)
    {
        jsonServidor = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: &error];
    }

    //Si json == null, toma el json local
    if (jsonServidor==nil)
    {
        //jsonLocal = [arrayJsonLocal copy];
    }else{

    }

    arrayItems = [[jsonServidor objectForKey:@"feed"] objectForKey:@"entry"];
    [listView setDataSource:self];
    [listView setDelegate:self];

    //Extraemos el nombre de la App y detalles generales
    NSString * title = [[[[jsonServidor objectForKey:@"feed"] objectForKey:@"author"] objectForKey:@"name"] valueForKey:@"label"];
    NSString * titleApp = [[[jsonServidor objectForKey:@"feed"] objectForKey:@"title"] valueForKey:@"label"];
    NSString * rights = [[[jsonServidor objectForKey:@"feed"]objectForKey:@"rights"] valueForKey:@"label"];
    NSString * updated = [[[jsonServidor objectForKey:@"feed"]objectForKey:@"updated"] valueForKey:@"label"];

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
    //celda.imgIcon.layer.borderColor=[[UIColor blueColor] CGColor];

    celda.title.text=name;
    celda.category.text=categorylabel;
    celda.priceAmount.text=priceamount;

    return celda;

}//Fin algo


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

- (void)callLocalJson{
    NSArray *pathsInsert = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    NSString * documentsDirectoryInsert = [pathsInsert objectAtIndex:0];
    RespuestaLocal = [NSString stringWithFormat:@"%@/%@", documentsDirectoryInsert,@"json"];
    NSDictionary *arrayJsonLocal = [[NSDictionary alloc] initWithContentsOfFile:RespuestaLocal];
    NSLog(@"%@",arrayJsonLocal);

}//Finaliza callLocalJson

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
