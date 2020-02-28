include $(THEOS)/makefiles/common.mk

ARCHS = arm64 arm64e

BUNDLE_NAME = Foldy

Foldy_FILES = PLPRootListController.m TitleListController.m BackgroundColorListController.m FrameListController.m LayoutListController.m
Foldy_INSTALL_PATH = /Library/PreferenceBundles
Foldy_FRAMEWORKS = UIKit
Foldy_PRIVATE_FRAMEWORKS = Preferences
Foldy_CFLAGS = -fobjc-arc
Foldy_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
Foldy_LDFLAGS += -lCSColorPicker
Foldy_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Foldy.plist$(ECHO_END)
