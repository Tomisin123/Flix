//
//  TrailerViewController.m
//  Flix
//
//  Created by tomisin on 6/24/21.
//

#import "TrailerViewController.h"
#import "YTPlayerView.h"

@interface TrailerViewController ()

@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;
@property (nonatomic, strong) NSString *video_key;

@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getVideoId];
    
}

- (void) getVideoId {
    NSNumber *movie_id = self.movie[@"id"]; //TODO: Change this
    //TODO: what to do when failed to find an id
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US", movie_id]];
    NSLog(@"%@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"Unsuccessful request!");
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSLog(@"Successful request!");
               
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                
               NSLog(@"%@", dataDictionary);
               
               NSDictionary *result = dataDictionary[@"results"][0];
               
               self.video_key = result[@"key"]; //TODO: WARNING, no real logic, only picks first video
               [self.playerView loadWithVideoId: [NSString stringWithFormat:@"%@", self.video_key]];
           }

       }];
    [task resume];
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




