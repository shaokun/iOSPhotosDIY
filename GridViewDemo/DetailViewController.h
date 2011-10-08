@interface DetailViewController : UIViewController <UIScrollViewDelegate> {
    NSArray *photos;
    UIScrollView *imageScroller;
}

@property (nonatomic, assign) NSArray *photos;

@end
