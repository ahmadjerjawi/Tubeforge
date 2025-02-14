TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = YouTube
FINALPACKAGE = 1

ARCHS = armv7 arm64
export ARCHS

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TubeForge
$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_FRAMEWORKS = UIKit Foundation MobileCoreServices SystemConfiguration Security JavaScriptCore Cephei
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = MediaRemote MobileCoreServices SystemConfiguration Security JavaScriptCore Cephei
$(TWEAK_NAME)_EXTRA_FRAMEWORKS += Cephei
$(TWEAK_NAME)_RESOURCES = tubeforge

SUBPROJECTS += prefs

# Post-install and post-remove scripts
after-install::
	install.exec "killall -9 SpringBoard"

internal-stage::
	@mkdir -p $(THEOS_STAGING_DIR)/DEBIAN/
	@cp $(THEOS_PROJECT_DIR)/postinst $(THEOS_STAGING_DIR)/DEBIAN/postinst
	@chmod 755 $(THEOS_STAGING_DIR)/DEBIAN/postinst

	@cp $(THEOS_PROJECT_DIR)/postrm $(THEOS_STAGING_DIR)/DEBIAN/postrm
	@chmod 755 $(THEOS_STAGING_DIR)/DEBIAN/postrm

	@mkdir -p $(THEOS_STAGING_DIR)/Library/TweakInject/TubeForge/
	@cp -r $(THEOS_PROJECT_DIR)/web $(THEOS_STAGING_DIR)/Library/TweakInject/TubeForge/
	@cp $(THEOS_PROJECT_DIR)/tubeforge $(THEOS_STAGING_DIR)/Library/TweakInject/TubeForge/

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
