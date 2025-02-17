# Copyright (C) 2021 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

soc_ver := $(TARGET_SOC_BASE)
LOCAL_MODULE := android.hardware.composer.hwc3-service.slsi

LOCAL_LICENSE_KINDS := SPDX-license-identifier-Apache-2.0
LOCAL_LICENSE_CONDITIONS := notice
LOCAL_NOTICE_FILE := $(LOCAL_PATH)/NOTICE

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_PROPRIETARY_MODULE := true

LOCAL_CFLAGS += \
	-DSOC_VERSION=$(soc_ver) \
	-DLOG_TAG=\"hwc-3\" \
	-Wthread-safety

# hwc3 re-uses hwc2.2 ComposerResource and libexynosdisplay
LOCAL_SHARED_LIBRARIES := \
	android.hardware.graphics.allocator@2.0 \
	android.hardware.graphics.composer3-V2-ndk \
	android.hardware.graphics.composer@2.1-resources \
        android.hardware.graphics.composer@2.2-resources \
	android.hardware.graphics.composer@2.4 \
	libbase \
	libbinder \
	libbinder_ndk \
	libcutils \
	libexynosdisplay \
	libfmq \
	libhardware \
	libhardware_legacy \
	liblog \
	libsync \
	libutils

LOCAL_STATIC_LIBRARIES := libaidlcommonsupport

LOCAL_HEADER_LIBRARIES := \
	android.hardware.graphics.composer3-command-buffer \
	libgralloc_headers \
	libhdrinterface_header

LOCAL_C_INCLUDES := \
	$(TOP)/hardware/samsung_slsi/exynos/include \
	$(TOP)/hardware/samsung_slsi/graphics/base/include \
	$(TOP)/hardware/samsung_slsi/graphics/base/libhwc2.1 \
	$(TOP)/hardware/samsung_slsi/graphics/base/libhwc2.1/libdevice \
	$(TOP)/hardware/samsung_slsi/graphics/base/libhwc2.1/libdisplayinterface \
	$(TOP)/hardware/samsung_slsi/graphics/base/libhwc2.1/libdrmresource/include \
	$(TOP)/hardware/samsung_slsi/graphics/base/libhwc2.1/libhwchelper \
	$(TOP)/hardware/samsung_slsi/graphics/base/libhwc2.1/libhwcService \
	$(TOP)/hardware/samsung_slsi/graphics/base/libhwc2.1/libresource \
	$(TOP)/hardware/samsung_slsi/graphics/$(soc_ver)/include \
	$(TOP)/hardware/samsung_slsi/graphics/$(soc_ver)/libhwc2.1 \
	$(TOP)/hardware/samsung_slsi/graphics/$(soc_ver)/libhwc2.1/libdevice \
	$(TOP)/hardware/samsung_slsi/graphics/$(soc_ver)/libhwc2.1/libmaindisplay \
	$(TOP)/hardware/samsung_slsi/graphics/$(soc_ver)/libhwc2.1/libresource

LOCAL_SRC_FILES := \
	Composer.cpp \
	ComposerClient.cpp \
	ComposerCommandEngine.cpp \
	impl/HalImpl.cpp \
	impl/ResourceManager.cpp \
	service.cpp

ifeq ($(BOARD_USES_HWC_SERVICES),true)
LOCAL_CFLAGS += -DUSES_HWC_SERVICES
LOCAL_SHARED_LIBRARIES += libExynosHWCService
LOCAL_HEADER_LIBRARIES += libbinder_headers
endif

LOCAL_VINTF_FRAGMENTS = hwc3-default.xml
LOCAL_INIT_RC := hwc3-slsi.rc

include $(BUILD_EXECUTABLE)
