//
//  infoItemVC.m
//  Ramses
//
//  Created by Reny Hernandez on 24/3/16.
//  Copyright © 2016 Ramsesa Tovar. All rights reserved.
//

#import "infoItemVC.h"
#import <QuartzCore/QuartzCore.h>

@interface infoItemVC ()

@end

@implementation infoItemVC

@synthesize imagen, pricelabel, priceamount, pricecurrency, contentType, rights, link, categorylabel, categoryimid, categoryscheme, categoryterm, date, summary, name, tituloapp;

@synthesize itemTitle, itemPrice, itemCompany, itemDate, itemDescription, categoryName, itemImage, backbutton,animationImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.itemImage.hidden=YES;
    NSURL* urlImage = [NSURL URLWithString:imagen];
    
    // Creamos la conexión de datos
    NSURLRequest *request = [NSURLRequest requestWithURL:urlImage cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0];

    NSData *imagenServidor = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    itemImage.image =[UIImage imageWithData:imagenServidor];
    animationImage.image =[UIImage imageWithData:imagenServidor];
    
    
    itemImage.layer.backgroundColor=[[UIColor clearColor] CGColor];
    itemImage.layer.cornerRadius=20;
    itemImage.layer.borderWidth=2.0;
    itemImage.layer.masksToBounds = YES;
    itemImage.layer.borderColor=[[UIColor blueColor] CGColor];
    
    animationImage.layer.backgroundColor=[[UIColor clearColor] CGColor];
    animationImage.layer.cornerRadius=20;
    animationImage.layer.borderWidth=2.0;
    animationImage.layer.masksToBounds = YES;
    animationImage.layer.borderColor=[[UIColor blueColor] CGColor];
    
    backbutton.layer.cornerRadius=20;
    backbutton.layer.masksToBounds = YES;

    itemTitle.text = name;
    itemPrice.text = priceamount;
    itemCompany.text = tituloapp;
    itemDate.text = date;
    itemDescription.text = summary;
    categoryName.text = categorylabel;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    int a = 0;
    int b = 0;
    
    a =screenBounds.size.height*13/100;
    b =screenBounds.size.height*8/100;
    
    // Definimos las opciones de la animación
    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState;
    
    // Translación
    [UIView animateWithDuration:0.7 delay:0 options:options animations:^{
        
        // Obtenemos dos valores x e y aleatorios sobre el tamaño de nuestra vista
        CGFloat x = screenBounds.size.width/2;
        CGFloat y = screenBounds.size.height/2;
        
        
        // Obtenemos una posición aleatoria en pantalla
        CGPoint posicion = CGPointMake(x, y);
        self.animationImage.center = posicion;
        itemPrice.textColor = [UIColor redColor];

        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.6 delay:0 options:options animations:^{
            // Obtenemos dos valores x e y aleatorios sobre el tamaño de nuestra vista
            CGFloat x = screenBounds.size.width/2;
            CGFloat y = screenBounds.size.height/2-a;
            
            
            // Obtenemos una posición aleatoria en pantalla
            CGPoint posicion = CGPointMake(x, y);
            self.animationImage.center = posicion;
            itemPrice.textColor = [UIColor blackColor];

            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.5 delay:0 options:options animations:^{
                // Obtenemos dos valores x e y aleatorios sobre el tamaño de nuestra vista
                CGFloat x = screenBounds.size.width/2;
                CGFloat y = screenBounds.size.height/2;
                
                
                // Obtenemos una posición aleatoria en pantalla
                CGPoint posicion = CGPointMake(x, y);
                self.animationImage.center = posicion;
                itemPrice.textColor = [UIColor redColor];

                
            } completion:^(BOOL finished) {
                
                // De momento nada
                
                
                [UIView animateWithDuration:0.4 delay:0 options:options animations:^{
                    // Obtenemos dos valores x e y aleatorios sobre el tamaño de nuestra vista
                    CGFloat x = screenBounds.size.width/2;
                    CGFloat y = screenBounds.size.height/2-a;
                    
                    // Obtenemos una posición aleatoria en pantalla
                    CGPoint posicion = CGPointMake(x, y+5);
                    self.animationImage.center = posicion;
                    itemPrice.textColor = [UIColor blackColor];

                    
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.3 delay:0 options:options animations:^{
                        // Obtenemos dos valores x e y aleatorios sobre el tamaño de nuestra vista
                        CGFloat x = screenBounds.size.width/2;
                        CGFloat y = screenBounds.size.height/2;
                        
                        // Obtenemos una posición aleatoria en pantalla
                        CGPoint posicion = CGPointMake(x, y);
                        self.animationImage.center = posicion;
                        itemPrice.textColor = [UIColor redColor];

                        
                    } completion:^(BOOL finished) {
                        
                        // De momento nada
                        
                        
                        [UIView animateWithDuration:0.3 delay:0 options:options animations:^{
                            // Obtenemos dos valores x e y aleatorios sobre el tamaño de nuestra vista
                            CGFloat x = screenBounds.size.width/2;
                            CGFloat y = screenBounds.size.height/2-a;
                            
                            // Obtenemos una posición aleatoria en pantalla
                            CGPoint posicion = CGPointMake(x, y+10);
                            self.animationImage.center = posicion;
                            itemPrice.textColor = [UIColor blackColor];

                            
                        } completion:^(BOOL finished) {
                            
                            [UIView animateWithDuration:0.2 delay:0 options:options animations:^{
                                // Obtenemos dos valores x e y aleatorios sobre el tamaño de nuestra vista
                                CGFloat x = screenBounds.size.width/2;
                                CGFloat y = screenBounds.size.height/2;
                                
                                // Obtenemos una posición aleatoria en pantalla
                                CGPoint posicion = CGPointMake(x, y);
                                self.animationImage.center = posicion;
                                itemPrice.textColor = [UIColor redColor];

                                
                            } completion:^(BOOL finished) {
                                
                                
                                [self.animationImage setAlpha:0];
                                self.itemImage.hidden=NO;
                                
                            }];
                            
                        }];
                        
                        
                    }];
                    
                }];
                
            }];
            
        }];
        
        
    }];
    
    
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
