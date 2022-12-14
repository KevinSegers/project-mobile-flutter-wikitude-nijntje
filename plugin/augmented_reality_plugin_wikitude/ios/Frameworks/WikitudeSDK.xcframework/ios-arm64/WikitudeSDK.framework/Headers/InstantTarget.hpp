/******************************************************************************
 * File: InstantTarget.hpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2017-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#ifndef InstantTarget_hpp
#define InstantTarget_hpp

#ifdef __cplusplus

#include "CompilerAttributes.hpp"

#include "CameraRenderingParameters.hpp"

namespace wikitude::sdk {

    /** @addtogroup InstantTracking
     *  @{
     */
    /** @class InstantTarget
     *  @brief A class that represents instant targets that are found by an instant tracker.
     */
    class Matrix4;
    class WT_EXPORT_API InstantTarget {
    public:
        virtual ~InstantTarget() = default;

        /** @brief Gets the combined modelview matrix that should be applied to augmentations when rendering.
         * WARNING: this method is provided for backwards compatibility only and does not conform to the same coordinate system conventions as the modelMatrix and viewMatrix provided below.
         * In cases where the orientation of the rendering surface and orientation of the camera do not match, and a correct cameraToRenderSurfaceRotation is passed to the SDK,
         * this matrix will also be rotate to account for the mismatch.
         *
         * For example, on mobile devices running in portrait mode, that have a camera sensor is landscape right position, the cameraToRenderSurfaceRotation should be 90 degrees.
         * The matrix will be rotated by 90 degrees around the Z axis.
         *
         * @return The matrix that should be applied to the target augmentation when rendering.
         */
        virtual Matrix4 getMatrix() const = 0;

        /** @brief Gets the transformation from local space to world space.
         * When the CameraFrame doesn't contain a valid device pose, world space and camera space are the same.
         * When combined with the viewMatrix, this results in the modelViewMatrix that should be applied to the target augmentation when rendering.
         *
         * @return The matrix that transforms the target from local space to world space.
         */
        virtual const Matrix4& getModelMatrix() const = 0;

        /** @brief Gets the transformation from world space to camera space.
         * When the CameraFrame doesn't contain a valid device pose, world space and camera space are the same.
         * When combined with the modelMatrix, this results in the modelViewMatrix that should be applied to the target augmentation when rendering.
         *
         * @return The matrix that transform the target from world space to camera space.
         */
        virtual const Matrix4& getViewMatrix() const = 0;

        virtual CameraRenderingParameters getCameraRenderingParameters() const = 0;

        virtual Matrix4 getAdjustedModelViewMatrix() const = 0;
    };
    /** @}*/
}

#endif /* __cplusplus */

#endif /* ImageTarget_hpp */
