//
//  DetailViewController.h
//  ooyala
//
//  Created by Moon Hayden on 3/10/16.
//  Copyright © 2016 unkown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

