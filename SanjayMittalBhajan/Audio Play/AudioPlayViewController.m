//
//  AudioPlayViewController.m
//  SanjayMittalBhajan
//
//  Created by Punit on 06/08/18.
//  Copyright © 2018 Eshiksa. All rights reserved.
//

#import "AudioPlayViewController.h"
#import "Base.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface AudioPlayViewController ()
{
    NSString *finalUrl;
}
@end

@implementation AudioPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _listView.hidden=YES;
    _waveView.hidden=NO;
    
    self.fileName.text=self.fileNameStr;
    self.fileId.text=self.fileIdStr;
    self.bhajanTitle.text=self.bhajanTitleStr;
    
    
    NSLog(@"ffffile id=%@",self.fileId.text);
    NSLog(@"ffffile nameee%@ bhajan title=%@",self.fileName.text,self.bhajanTitle.text);
     int i=[_indxpath intValue];
   NSLog(@" kimgarray  %@",[_kimgarray objectAtIndex:i]);
    NSLog(@"image  %@",_kimg);
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = _backgroundView.bounds;
    gradient.colors = @[(id)[UIColor colorWithRed:(225.0/225.0) green:(0.0/225.0) blue:(84.0/255.0)alpha:1.0].CGColor,(id)[UIColor colorWithRed:(244.0/225.0) green:(219.0/225.0) blue:(72.0/255.0)alpha:1.0].CGColor];
    
    [_backgroundView.layer insertSublayer:gradient atIndex:0];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_backgroundView.bounds
                                                   byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                         cornerRadii:CGSizeMake(0.0, 0.0)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _backgroundView.bounds;
    maskLayer.path = maskPath.CGPath;
    _backgroundView.layer.mask = maskLayer;
  
    NSString *username = @"admin";
    NSString *password = @"Adm1n@123";
    
    NSString *unpw = [NSString stringWithFormat:@"%@:%@",username,password];
    NSData *updata = [unpw dataUsingEncoding:NSASCIIStringEncoding];
    
    NSString *base64str = [NSString stringWithFormat:@"Basic %@", [updata base64Encoding]];
    NSDictionary *headers = @{ @"content-type": @"json/application",
                               @"authorization": base64str };
    
    NSString *str1=[@"/" stringByAppendingFormat:@"%@",self.fileId.text];
    NSLog(@"***str1***%@",str1);
    NSString *str2=[@"/" stringByAppendingFormat:@"%@",self.fileName.text];
    NSLog(@"***str2***%@",str2);
    NSString *str3=[str1 stringByAppendingFormat:@"%@",str2];
    NSLog(@"***str3***%@",str3);
    NSString *str4=[mainUrl stringByAppendingFormat:@"%@",audio];
    NSLog(@"***str4***%@",str4);
    finalUrl=[str4 stringByAppendingFormat:@"%@",str3];
    NSLog(@"***finalUrl***%@",finalUrl);
    
   /* NSMutableURLRequest *url = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:finalUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [url setHTTPMethod:@"GET"];
    [url setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        }
        else {
            
            NSLog(@"Success: %@", data);
            
            NSError *err;
            
            NSArray *jsonArray  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
            NSLog(@"JSON DATA%@",jsonArray);
            
            NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:[NSURLConnection sendSynchronousRequest:url returningResponse:nil error:nil] options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"response data:%@",maindic);
            
        }
    }];*/
    
    //http://192.168.1.219:8082/Sanjay_Mittal_Bhajans/apis/audio/5/Hanuman_Chalisa
   //NSURL *url=[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"SampleAudio_0.4mb" ofType:@"mp3"]];
    NSURL *url=[NSURL URLWithString:finalUrl];
    
    NSLog(@"url***%@",url);
    NSError*error;
    self.audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    if (error) {
        NSLog(@"FAILURE:%@",error.localizedDescription);
    }
    else{
        self.audioPlayer.delegate=self;
        self.progressSlider.value=0.0;
        self.durationTimeLabel.text=[self stringFromInterval:self.audioPlayer.duration];
        
        if (self.audioPlayer.duration <= 3600) {
            self.currentTimeLabel.text=[NSString stringWithFormat:@"00:00"];
        }
        else{
            self.currentTimeLabel.text=[NSString stringWithFormat:@"0:00:00"];
        }
        [self.currentTimeLabel sizeToFit];
        [self.audioPlayer prepareToPlay];
    }
    
    //[self audioPlayBtnClicked];
}
-(void)viewWillAppear:(BOOL)animated
{
    int i=[_indxpath intValue];
    NSString *tempimgstr=[_kimgarray objectAtIndex:i];
    
    [_kimgview sd_setImageWithURL:[NSURL URLWithString:tempimgstr]placeholderImage:[UIImage imageNamed:@"default.png"]];
    
    
}
-(NSString *)stringFromInterval:(NSTimeInterval)interval{
    
    NSInteger ti=(NSInteger)interval;
    int seconds=ti % 60;
    int minutes=(ti/60)%60;
    long int hourss=(ti / 3600);
    if (ti <= 3600) {
        return [NSString stringWithFormat:@"%02d:%02d",minutes,seconds];
    }
    return [NSString stringWithFormat:@"%ld:%02d:%02d",hourss,minutes,seconds];
    
    return 0;
}
- (IBAction)playPauseAudio:(id)sender {
    if (!self.audioPlayer.playing) {
        self.progressSlider.maximumValue=self.audioPlayer.duration;
        
        self.sliderTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
        
        [self.progressSlider addTarget:self action:@selector(progressSliderChanged:) forControlEvents:UIControlEventValueChanged];
        
        [self.audioPlayer play];
        
        //[self.playPauseBtn setTitle:@"Pause" forState:UIControlStateNormal];
       [self.playPauseBtn setImage:[UIImage imageNamed:@"playBtn.png"] forState:UIControlStateNormal];
        
    }else if (self.audioPlayer.playing){
        [self.audioPlayer pause];
       // [self.playPauseBtn setTitle:@"Play" forState:UIControlStateNormal];
          [self.playPauseBtn setImage:[UIImage imageNamed:@"pauseBtn.png"] forState:UIControlStateNormal];
    }
}
-(void)updateSlider{
    self.progressSlider.value=self.audioPlayer.currentTime;
    self.currentTimeLabel.text=[self stringFromInterval:self.audioPlayer.currentTime];
    
}
- (IBAction)audioListBtnClicked:(id)sender {
    _listView.hidden=NO;
    _waveView.hidden=YES;
}
- (IBAction)stopAudio:(id)sender {
    if (self.audioPlayer.isPlaying) {
        [self.audioPlayer stop];
    }
    [self.audioPlayer setCurrentTime:0.0];
    [self.sliderTimer invalidate];
    self.progressSlider.value=0.0;
    
    if (self.audioPlayer.duration <= 3600) {
        self.currentTimeLabel.text=[NSString stringWithFormat:@"00:00"];
    }
    else{
        self.currentTimeLabel.text=[NSString stringWithFormat:@"0:00:00"];
    }
    [self.currentTimeLabel sizeToFit];
    [self.playPauseBtn setTitle:@"Play" forState:UIControlStateNormal];
}
- (IBAction)adjustVolume:(id)sender {
    if (self.audioPlayer!=nil) {
        self.audioPlayer.volume=self.volumeSlider.value;
    }
}
-(void)audioPlayBtnClicked{
    

        NSString *username = @"admin";
        NSString *password = @"Adm1n@123";
        
        NSString *unpw = [NSString stringWithFormat:@"%@:%@",username,password];
        NSData *updata = [unpw dataUsingEncoding:NSASCIIStringEncoding];
        
        NSString *base64str = [NSString stringWithFormat:@"Basic %@", [updata base64Encoding]];
        NSDictionary *headers = @{ @"content-type": @"json/application",
                                   @"authorization": base64str };
    
    NSString *str1=[@"/" stringByAppendingFormat:@"%@",self.fileId.text];
    NSLog(@"***str1***%@",str1);
    NSString *str2=[@"/" stringByAppendingFormat:@"%@",self.fileName.text];
    NSLog(@"***str2***%@",str2);
    NSString *str3=[str1 stringByAppendingFormat:@"%@",str2];
    NSLog(@"***str3***%@",str3);
    NSString *str4=[mainUrl stringByAppendingFormat:@"%@",audio];
    NSLog(@"***str4***%@",str4);
    finalUrl=[str4 stringByAppendingFormat:@"%@",str3];
    NSLog(@"***finalUrl***%@",finalUrl);
    
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:finalUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
        [request setHTTPMethod:@"GET"];
        [request setAllHTTPHeaderFields:headers];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                NSLog(@"%@", error);
            }
            else {
                
                NSLog(@"Success: %@", data);
                
                NSError *err;
                
                NSArray *jsonArray  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
                NSLog(@"JSON DATA%@",jsonArray);
                
                NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil] options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"response data:%@",maindic);
                
              }
        }];
        
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)progressSliderChanged:(id)sender {
    [self.audioPlayer stop];
    [self.audioPlayer setCurrentTime:self.progressSlider.value];
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
}
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    if (flag) {
        [self stopAudio:nil];
    }
}
-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error{
    NSLog(@"dECODER FAILED:%@",error.localizedDescription);
}
-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
//audio play begin
}
-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags{
    if (flags==AVAudioSessionInterruptionOptionShouldResume && self.audioPlayer!=nil) {
        [self.audioPlayer play];
    }
}
@end
