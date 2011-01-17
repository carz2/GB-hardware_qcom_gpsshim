ifeq ($(BOARD_USES_GPSSHIM),true)

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_MODULE := gps.$(TARGET_GPSSHIM_BOARD_NAME)

LOCAL_SHARED_LIBRARIES:= \
	liblog \
    $(BOARD_GPS_LIBRARIES) \

LOCAL_SRC_FILES += \
    gps.c

LOCAL_CFLAGS += \
    -fno-short-enums 

ifneq ($(BOARD_GPSSHIM_BAD_AGPS),)
LOCAL_CFLAGS += \
    -DNO_AGPS
endif

#ifneq ($(BOARD_GPS_NEEDS_XTRA),)
LOCAL_CFLAGS += \
    -DNEEDS_INITIAL_XTRA
#endif

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

include $(BUILD_SHARED_LIBRARY)

#If ALT_GPSSHIM_BOARDNAME is set generate a second library
# (aka trout if the main board name was sapphire)
ifneq ($(ALT_GPSSHIM_BOARDNAME),)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_MODULE := gps.$(ALT_GPSSHIM_BOARDNAME)

LOCAL_SHARED_LIBRARIES:= \
    liblog \
    $(BOARD_GPS_LIBRARIES) 

LOCAL_SRC_FILES += \
    gps.c

LOCAL_CFLAGS += \
    -fno-short-enums

ifneq ($(BOARD_GPSSHIM_BAD_AGPS),)
LOCAL_CFLAGS += \
    -DNO_AGPS
endif

LOCAL_CFLAGS += \
    -DNEEDS_INITIAL_XTRA

LOCAL_PRELINK_MODULE := false
LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

include $(BUILD_SHARED_LIBRARY)

endif #ALT_GPSSHIM_BOARDNAME set

endif # BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE
