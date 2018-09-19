//
//  AudioPlayViewController.h
//  SanjayMittalBhajan

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface AudioPlayViewController : UIViewController<AVAudioPlayerDelegate>
    {
        dispatch_queue_t queue;
    }
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property(nonatomic,retain)NSString *fileIdStr,*fileNameStr,*indxpath,*bhajanTitleStr;

@property (weak, nonatomic) IBOutlet UIButton *audioListBtn;
@property (weak, nonatomic) IBOutlet UIView *listView;
@property (weak, nonatomic) IBOutlet UILabel *fileName;
@property (weak, nonatomic) IBOutlet UILabel *fileId;
@property (weak, nonatomic) IBOutlet UILabel *bhajanTitle;
@property (weak, nonatomic) IBOutlet UIView *waveView;
@property (weak, nonatomic) IBOutlet UIButton *playPauseBtn;
- (IBAction)progressSliderChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *kimgview;

@property(strong,nonatomic)AVAudioPlayer *audioPlayer;
@property(strong,nonatomic)NSTimer *sliderTimer;
-(NSString *)stringFromInterval:(NSTimeInterval)interval;
-(void)updateSlider;

@property(nonatomic,retain)UIImage *kimg;
@property(nonatomic,retain)NSMutableArray *kimgarray;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@end
