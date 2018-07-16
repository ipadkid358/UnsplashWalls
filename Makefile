INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = UnsplashWalls
UnsplashWalls_FILES = Tweak.m
UnsplashWalls_FRAMEWORKS = UIKit
UnsplashWalls_PRIVATE_FRAMEWORKS = PhotoLibrary
UnsplashWalls_LIBRARIES = activator
UnsplashWalls_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
