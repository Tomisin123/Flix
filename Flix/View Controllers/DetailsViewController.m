//
//  DetailsViewController.m
//  Flix
//
//  Created by tomisin on 6/23/21.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TrailerViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (strong, nonatomic) NSNumber *movieRating;
@property (weak, nonatomic) IBOutlet UIImageView *ratingIcon;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;



@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterView setImageWithURL:posterURL];
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    [self.backdropView setImageWithURL:backdropURL];
    
    self.titleLabel.text = self.movie[@"title"];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.minimumScaleFactor = 20/25;
    self.synopsisLabel.text = self.movie[@"overview"];
    self.movieRating = (NSNumber *) self.movie[@"vote_average"];
    
    if ([self.movieRating doubleValue] < 7){
        self.ratingIcon.image = [UIImage imageNamed:@"imageedit_2_2124752195.png"]; //splat
    }
    else{
        self.ratingIcon.image = [UIImage imageNamed:@"imageedit_3_9883478176.png"];//fresh tomato
        
    }
    
    self.ratingLabel.text = [NSString stringWithFormat:@"Rating: %.0f%%", self.movieRating.floatValue * 10];
    
    self.releaseDateLabel.text = [NSString stringWithFormat:@"Released: %@", self.movie[@"release_date"]];
    
    
    [self.titleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
    [self.ratingLabel sizeToFit];
    [self.releaseDateLabel sizeToFit];
    
    [self.posterView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [self.posterView.layer setBorderWidth: 3.0];
    
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    NSDictionary *movie = self.movie;
    
    TrailerViewController *trailerViewController = [segue destinationViewController];
    trailerViewController.movie = movie;
    
    NSLog(@"Going to movie trailer!");
}


@end
