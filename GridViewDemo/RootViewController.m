#import "RootViewController.h"
#import "DetailViewController.h"
#import "GridView.h"
#import "UIImage+Resize.h"
#import "Photo.h"

@interface RootViewController()

- (void)showPhoto:(UIButton *)sender;

@end

@implementation RootViewController

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
	didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
	if (!image) {
		image = [info objectForKey:UIImagePickerControllerOriginalImage];
	}
	
	[picker dismissModalViewControllerAnimated:YES];
    
    Photo *photo = [[Photo new] autorelease];
    photo.image = image;
    photo.thumbImage = [image thumbnailImage:75 transparentBorder:0 cornerRadius:0 interpolationQuality:0.8];
    [photos addObject:photo];
    
    UIButton *thumbButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thumbButton.tag = [photos indexOfObject:photo];
    [thumbButton setImage:photo.thumbImage forState:UIControlStateNormal];
    [thumbButton sizeToFit];
    [thumbButton addTarget:self action:@selector(showPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [gridView addSubview:thumbButton];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissModalViewControllerAnimated:YES];
}

#pragma

- (void)presentImagePickerControllerWithSourceType:
	(UIImagePickerControllerSourceType)type
{
	UIImagePickerController *picker = [[UIImagePickerController new] autorelease];
	picker.delegate = self;
	picker.sourceType = type;
	[self presentModalViewController:picker animated:YES];
}

- (void)showPhoto:(UIButton *)sender {
    DetailViewController *controller = [[DetailViewController new] autorelease];
    controller.photos = photos;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)addPhoto {
	[self presentImagePickerControllerWithSourceType:
		UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"RootView";
    
    photos = [NSMutableArray new];
    
    int width = 75;
    int cols = 4;
    int margin = ([UIScreen mainScreen].bounds.size.width - width * cols) / (cols + 1);

    gridView = [[GridView alloc] initWithCols:cols width:width margin:margin];
    [self.view addSubview:gridView];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPhoto)] autorelease];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [gridView release];
    [photos release];
    [super dealloc];
}

@end
