@class GridView;

@interface RootViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    NSMutableArray *photos;
    GridView *gridView;
}

@end
