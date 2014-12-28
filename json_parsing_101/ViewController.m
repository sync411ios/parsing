//
//  ViewController.m
//  json_parsing_101
//
//  Created by boxster on 12/26/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableData *responseJsonData;
    NSURLConnection *connection;
    NSMutableArray *array;
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.myTableView setDelegate:self];
    [self.myTableView setDataSource:self];
    array = [[NSMutableArray alloc] init];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseJsonData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseJsonData appendData:data];
}




//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    NSLog(@"Connection Error!");
//}



-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
//    NSError *error;
    
    NSDictionary *allJsonDataDict = [NSJSONSerialization JSONObjectWithData:responseJsonData options:0 error:nil];
    NSDictionary  *feed = [allJsonDataDict objectForKey:@"feed"];
    NSArray *arrayOfEntry = [feed objectForKey:@"entry"];
    
    for (NSDictionary *diction in arrayOfEntry)
    {
        NSDictionary *title = [diction objectForKey:@"title"];
        NSString *label = [title objectForKey:@"label"];
        
        [array addObject:label];
    }
    [self.myTableView reloadData];
    
}


- (IBAction)getTop10Button:(id)sender
{
    
    [array removeAllObjects];
    
    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/us/rss/topmusicvideos/limit=50/json"];
    
//    NSURL *url = [NSURL URLWithString:@"http://itunes.apple.com/us/rss/topmovies/limit=50/genre=4401/json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (connection)
    {
        responseJsonData = [[NSMutableData alloc]init];
    }
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setBackgroundColor:[UIColor grayColor]];
    }
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    
    return cell;
}





@end
