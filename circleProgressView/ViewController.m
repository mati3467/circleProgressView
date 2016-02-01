//
//  ViewController.m
//  circleProgressView
//
//  Created by Amjad on 2/1/16.
//  Copyright © 2016 Mati. All rights reserved.
//

#import "ViewController.h"
#import "ProgressViewCircle.h"

@interface ViewController ()
{
    ProgressViewCircle *progressViewCircle;
    NSMutableData *bufferData;
    long long unsigned totalDownloadSize,total;
    double currentDownload,progress;
    UIButton *downloadAgain;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDownload];
    
    downloadAgain = [UIButton buttonWithType:UIButtonTypeSystem];
    [downloadAgain setTitle:@"Download Again" forState:UIControlStateNormal];
    [downloadAgain addTarget:self action:@selector(downloadAgainTask) forControlEvents:UIControlEventTouchUpInside];
    [downloadAgain setFrame:CGRectMake(self.view.frame.size.width/2 - 75, self.view.frame.size.height/2-25, 150, 50)];
    [self.view addSubview:downloadAgain];
    [downloadAgain setHidden:YES];
    
}

-(void) setupDownload
{
    progress = 0.0f;
    
    //Adding Progress view
    progressViewCircle = [[ProgressViewCircle alloc] initWithFrame:self.view.frame andRadius:14.0 andStrokeColor:[UIColor greenColor]];//Radius of the animating circle
    [progressViewCircle setprogress:progress];  //Initial progress
    [self.view addSubview:progressViewCircle];
    
    NSString *urladdress= @"https://www.ferc.gov/docs-filing/elibrary/larg-file.pdf";         //Your url goes here
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urladdress]
                                                              cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                          timeoutInterval:60.0];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if (theConnection) {
        bufferData = [[NSMutableData alloc]init];
    }
    
    
    urladdress = nil;
    theRequest = nil;
    theConnection = nil;
    
}

-(void) downloadAgainTask
{
    [downloadAgain setHidden:YES];
    [self setupDownload];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [bufferData setLength:0];
    if(totalDownloadSize == 0)
    {
        totalDownloadSize = [response expectedContentLength];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [bufferData appendData:data];
    currentDownload += [data length];
    total = totalDownloadSize/1.0f;
    progress = currentDownload/total;
    
    [progressViewCircle setprogress:progress*100];
    [progressViewCircle setNeedsDisplay];
}

- (void)connection:(NSURLConnection *)connection  didFailWithError:(NSError *)error
{
    bufferData = nil;
    currentDownload =0;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [bufferData setLength:0];
    totalDownloadSize =0;
    currentDownload =0;
    [progressViewCircle removeFromSuperview];
    progressViewCircle = nil;
    
    [downloadAgain setHidden:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
