#import <libactivator/libactivator.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface PLStaticWallpaperImageViewController : NSObject
- (instancetype)initWithUIImage:(UIImage *)image;
- (void)setWallpaperForLocations:(long long)mask;
@end

@interface SBFWallpaperView : UIView
- (UIImage *)snapshotImage;
@end

@interface SBWallpaperController : NSObject
+ (instancetype)sharedInstance;
- (SBFWallpaperView *)lockscreenWallpaperView;
- (SBFWallpaperView *)homescreenWallpaperView;
- (SBFWallpaperView *)sharedWallpaperView;
@end

@interface UWUnsplashWalls : NSObject <LAListener>
@end

@implementation UWUnsplashWalls

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event forListenerName:(NSString *)listenerName {
    @autoreleasepool {
        if ([listenerName isEqualToString:@"com.ipadkid.unsplashwalls.save"]) {
            SBWallpaperController *wallpaperController = [objc_getClass("SBWallpaperController") sharedInstance];
            SBFWallpaperView *wallpaperView = [activator.currentEventMode isEqualToString:@"lockscreen"] ? wallpaperController.lockscreenWallpaperView : wallpaperController.homescreenWallpaperView;
            if (!wallpaperView) {
                wallpaperView = wallpaperController.sharedWallpaperView;
            }
            
            UIImageWriteToSavedPhotosAlbum(wallpaperView.snapshotImage, NULL, NULL, NULL);
            return;
        }
        
        [[NSURLSession.sharedSession dataTaskWithURL:[NSURL URLWithString:@"https://source.unsplash.com/random"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (data == nil || error != nil) {
                return;
            }
            
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                PLStaticWallpaperImageViewController *wallpaper = [[PLStaticWallpaperImageViewController alloc] initWithUIImage:image];
                if (wallpaper) {
                    long long locations;
                    if ([listenerName isEqualToString:@"com.ipadkid.unsplashwalls"]) {
                        locations = 3;
                    }
                    if ([listenerName isEqualToString:@"com.ipadkid.unsplashwalls.home"]) {
                        locations = 2;
                    }
                    if ([listenerName isEqualToString:@"com.ipadkid.unsplashwalls.lock"]) {
                        locations = 1;
                    }
                    [wallpaper setWallpaperForLocations:locations];
                }
                
                if ([[[NSUserDefaults alloc] initWithSuiteName:@"com.ipadkid.unsplashwalls"] boolForKey:@"UWSaveImagesKey"]) {
                    UIImageWriteToSavedPhotosAlbum(image, NULL, NULL, NULL);
                }
            }
        }] resume];
    }
}

+ (void)load {
    @autoreleasepool {
        UWUnsplashWalls *listener = self.new;
        [LASharedActivator registerListener:listener forName:@"com.ipadkid.unsplashwalls"];
        [LASharedActivator registerListener:listener forName:@"com.ipadkid.unsplashwalls.home"];
        [LASharedActivator registerListener:listener forName:@"com.ipadkid.unsplashwalls.lock"];
        [LASharedActivator registerListener:listener forName:@"com.ipadkid.unsplashwalls.save"];
    }
}

@end
