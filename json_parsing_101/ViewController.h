//
//  ViewController.h
//  json_parsing_101
//
//  Created by boxster on 12/26/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController < UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;


- (IBAction)getTop10Button:(id)sender;

@end
