/******************************************************************************
 * File: ArchitectPlugin.hpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2018-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#ifndef ArchitectPlugin_hpp
#define ArchitectPlugin_hpp

#ifdef __cplusplus

#include "Plugin.hpp"

#include "JavaScriptPluginModule.hpp"


namespace wikitude::sdk {

        class WT_EXPORT_API ArchitectPlugin : public Plugin {
        public:
            ArchitectPlugin(const std::string& identifier_);
            virtual ~ArchitectPlugin() = default;

            JavaScriptPluginModule* getJavaScriptPluginModule() const;

            PluginType getPluginType() const;

        protected:
            void setJavaScriptPluginModule(std::unique_ptr<JavaScriptPluginModule> javaScriptPluginModule_);

        private:
            std::unique_ptr<JavaScriptPluginModule>     _javaScriptPluginModule;
        };
}

#endif /* __cplusplus */

#endif /* ArchitectPlugin_hpp */
