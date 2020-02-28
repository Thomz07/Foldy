ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Foldy

Foldy_FILES = Tweak.xm
Foldy_CFLAGS = -fobjc-arc
Foldy_EXTRA_FRAMEWORKS += Cephei
Foldy_LDFLAGS += -lCSColorPicker

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += foldy
include $(THEOS_MAKE_PATH)/aggregate.mk
