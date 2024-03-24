/*
 * Copyright (C) 2017 Haoge
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package in.gov.tn.aavin.aavinposfro.utils.update.base;

import android.content.Context;

import in.gov.tn.aavin.aavinposfro.utils.update.model.Update;


public abstract class InstallStrategy {

    /**
     * 在此定制你自己的安装策略。如：
     * 1. 普通环境下，调起系统安装页面
     * 2. 插件化环境下，在此进行插件安装
     * 3. 热修复环境下，在此进行热修复dex合并及更多兼容操作
     * @param context application context
     * @param filename The apk filename
     * @param update 更新数据实体类
     */
    public abstract void install(Context context, String filename, Update update);
}