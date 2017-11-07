## UnsplashWalls

Change wallpaper to a random image from Unsplash using an Activator gesture

### `-setWallpaperForLocations:` Documentation

`-setWallpaperForLocations:` takes in a bitmask for homescreen and lockscreen

```obj-c
PLStaticWallpaperImageViewController *wallpaper; 
// assume `wallpaper` gets initialized
long long lockscreen = 1;
long long homescreen = 2;

// if you're unfamiliar with this notation, it's a bitwise OR operator
long long bothScreens = lockscreen | homescreen;

// now we can easily set the wallpaper
[wallpaper setWallpaperForLocations:bothScreens]; // both
[wallpaper setWallpaperForLocations:lockscreen]; // lock
[wallpaper setWallpaperForLocations:homescreen]; // home
// of course you can directly plug in the values, but this is for this is for documentation purposes
```
