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


import in.gov.tn.aavin.aavinposfro.utils.update.UpdateBuilder;
import in.gov.tn.aavin.aavinposfro.utils.update.model.Update;

import java.io.File;


public abstract class FileCreator {

    /**
     * 根据update更新数据。创建一个对应的本地文件缓存路径。用于提供给{@link DownloadWorker}下载任务使用。
     *
     * @param update 更新数据实体类
     * @return 下载文件本地路径，不能为null
     */
    protected abstract File create(Update update);

    protected abstract File createForDaemon(Update update);

    final File createWithBuilder(Update update, UpdateBuilder builder) {
        File file = null;
        if (builder.isDaemon()) {
            file = createForDaemon(update);
        } else {
            file = create(update);
        }

        String name = getClass().getCanonicalName();
        if (file == null) {
            throw new RuntimeException(String.format(
                    "Could not returns a null file with FileCreator:[%s], create mode is [%s]",
                    name, builder.isDaemon() ? "Daemon" : "Normal"
            ));
        }

        if (file.isDirectory()) {
            throw new RuntimeException(String.format(
                    "Could not returns a directory file with FileCreator:[%s], create mode is [%s]",
                    name, builder.isDaemon() ? "Daemon" : "Normal"
            ));
        }

        return file;
    }
}
