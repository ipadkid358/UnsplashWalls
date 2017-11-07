DEBUG = 0
ARCHS = armv7 arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = UnsplashWalls
UnsplashWalls_FILES = Tweak.xm
UnsplashWalls_FRAMEWORKS = UIKit
UnsplashWalls_PRIVATE_FRAMEWORKS = PhotoLibrary
UnsplashWalls_LDFLAGS = -lactivator
UnsplashWalls_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	killall -9 SpringBoard
