/******************************************************************************
 * File: ManagedCameraFrame.hpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2017-2021 Wikitude GmbH.
 *
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#ifndef ManagedCameraFrame_hpp
#define ManagedCameraFrame_hpp

#ifdef __cplusplus

#include <functional>
#include <memory>
#include <mutex>

#include "CameraFrame.hpp"
#include "CompilerAttributes.hpp"

namespace wikitude::sdk {

    class CameraFramePlane;
    class WT_EXPORT_API ManagedCameraFrame {
    public:
        ManagedCameraFrame(); /* delete me because I can’t be constructed without a sdk::CameraFrame */

        ManagedCameraFrame(const CameraFrame& frameInfo_);

        ManagedCameraFrame(ManagedCameraFrame& other_);
        ManagedCameraFrame(ManagedCameraFrame&& other_);

        /* dtor impl. not needed as the Wikitude SDK is calling lockForCopy(), copyIfNeeded() and unlockAfterCopy() when the lifetime of the FrameObject ends */
        virtual ~ManagedCameraFrame() = default;

        ManagedCameraFrame& operator=(ManagedCameraFrame& other_);
        ManagedCameraFrame& operator=(ManagedCameraFrame&& other);

        long getId() const;
        const std::string& getDeviceName() const;
        long getDeviceId() const;
        CameraType getCameraType() const;

        std::int64_t getColorTimestamp() const;
        const ColorCameraFrameMetadata& getColorMetadata() const;

        std::int64_t getDepthTimestamp() const;
        const DepthCameraFrameMetadata& getDepthMetadata() const;

        const CameraFrame& getCameraFrame() {
            return _cameraFrame;
        }

        const std::vector<CameraFramePlane>& get();
        const void* getDepth();
        const void* getConfidenceDepth();

        bool hasPose() const;
        const Matrix4& getPose() const;

        void addRequestor();
        const std::vector<CameraFramePlane>& getRequestedData();
        const void* getRequestedDepthData();
        const void* getRequestedConfidenceDepthData();

        void lockForCopy();
        void copyIfNeeded();
        void unlockAfterCopy();

    protected:
        void addOwner(ManagedCameraFrame& other_);

        /**
         * overrite this method to keep track if the copy was actually done.
         *
         * For now the purpose of this method is to test this class. It should not be overritten in production code.
         */
        virtual void copyWasNeeded();

    protected:
        CameraFrame _cameraFrame;

        std::shared_ptr<std::vector<CameraFramePlane>> _safeStorage;
        std::shared_ptr<unsigned char*> _safeDepthStorage;
        std::shared_ptr<unsigned char*> _safeConfidenceDepthStorage;
        std::shared_ptr<std::mutex> _safeStorageMutex;
        std::shared_ptr<int> _refCount = nullptr;
    };
}

#endif /* ManagedCameraFrame_hpp */

#endif /* __cplusplus */
