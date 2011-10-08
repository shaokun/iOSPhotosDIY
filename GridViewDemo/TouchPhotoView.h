@class Photo;

CGRect CGRectCenteredInRect(CGRect inner, CGRect outer);

@interface TouchPhotoView : UIScrollView {
	Photo *photo;
	UIImageView *imageView;
	CGFloat initialZoom;
	UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) Photo *photo;
@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, retain) UIImage *image;

// Zooms out if already zoomed in.  Zooms into location if entirely zoomed out.
- (void)toggleZoomIntoLocation:(CGPoint)location;

@end