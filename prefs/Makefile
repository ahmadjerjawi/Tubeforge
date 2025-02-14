ARCHS = armv7 arm64
TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = TubeForgePref

TubeForgePref_FILES = YRPRootListController.m
TubeForgePref_FRAMEWORKS = UIKit
TubeForgePref_PRIVATE_FRAMEWORKS = Preferences
TubeForgePref_EXTRA_FRAMEWORKS = Cephei CepheiPrefs
TubeForgePref_INSTALL_PATH = /Library/PreferenceBundles
TubeForgePref_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
