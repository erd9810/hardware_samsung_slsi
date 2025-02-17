# Copyright (C) 2014 The Android Open Source Project
# Copyright (C) 2023 The LineageOS Project
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

#
# Audio RIL Interface for SEC
#
ifeq ($(BOARD_USE_AUDIOHAL_COMV1), true)
ifneq ($(BOARD_USE_SITRIL), true)
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := secril_interface.c

LOCAL_C_INCLUDES += \
	$(TOP)/hardware/samsung_slsi/exynos/include/libaudio/audiohal_comv1

LOCAL_C_INCLUDES += ./include

LOCAL_HEADER_LIBRARIES := libhardware_headers
LOCAL_SHARED_LIBRARIES := liblog libcutils libutils libc

LOCAL_MODULE := libaudio-ril
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)
endif
endif
