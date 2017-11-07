#import <libactivator/libactivator.h>
#import <UIKit/UIKit.h>

@interface PLStaticWallpaperImageViewController : NSObject
- (instancetype)initWithUIImage:(UIImage *)image;
- (void)setWallpaperForLocations:(long long)mask;
@end

@interface UWUnsplashWalls : NSObject <LAListener>
@end

@implementation UWUnsplashWalls
- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
    @autoreleasepool {
        UIScreen *screen = UIScreen.mainScreen;
        CGSize screenSize = screen.bounds.size;
        CGFloat screenScale = screen.scale;
        NSString *size = [NSString stringWithFormat:@"%lux%lu", lroundf(screenSize.width*screenScale), lroundf(screenSize.height*screenScale)];
        NSURL *upsplash = [NSURL URLWithString:[@"https://source.unsplash.com/random" stringByAppendingPathComponent:size]];
        [[NSURLSession.sharedSession dataTaskWithURL:upsplash completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (data == nil || error != nil) return;
            
            UIImage *image = [UIImage imageWithData:data];
            PLStaticWallpaperImageViewController *wallpaper = [[PLStaticWallpaperImageViewController alloc] initWithUIImage:image];
            if (wallpaper) [wallpaper setWallpaperForLocations:3];
        }] resume];
    }
}

+ (void)load {
    @autoreleasepool {
        [LASharedActivator registerListener:[self new] forName:@"com.ipadkid.unsplashwalls"];
    }
}

@end
