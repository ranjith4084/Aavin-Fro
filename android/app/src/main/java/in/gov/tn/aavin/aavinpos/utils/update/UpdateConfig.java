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
package in.gov.tn.aavin.aavinposfro.utils.update;

import android.text.TextUtils;

import in.gov.tn.aavin.aavinposfro.utils.update.base.CheckCallback;
import in.gov.tn.aavin.aavinposfro.utils.update.base.CheckNotifier;
import in.gov.tn.aavin.aavinposfro.utils.update.base.CheckWorker;
import in.gov.tn.aavin.aavinposfro.utils.update.base.DownloadCallback;
import in.gov.tn.aavin.aavinposfro.utils.update.base.DownloadNotifier;
import in.gov.tn.aavin.aavinposfro.utils.update.base.DownloadWorker;
import in.gov.tn.aavin.aavinposfro.utils.update.base.FileChecker;
import in.gov.tn.aavin.aavinposfro.utils.update.base.FileCreator;
import in.gov.tn.aavin.aavinposfro.utils.update.base.InstallNotifier;
import in.gov.tn.aavin.aavinposfro.utils.update.base.InstallStrategy;
import in.gov.tn.aavin.aavinposfro.utils.update.base.UpdateChecker;
import in.gov.tn.aavin.aavinposfro.utils.update.base.UpdateParser;
import in.gov.tn.aavin.aavinposfro.utils.update.base.UpdateStrategy;
import in.gov.tn.aavin.aavinposfro.utils.update.impl.DefaultCheckWorker;
import in.gov.tn.aavin.aavinposfro.utils.update.impl.DefaultDownloadNotifier;
import in.gov.tn.aavin.aavinposfro.utils.update.impl.DefaultDownloadWorker;
import in.gov.tn.aavin.aavinposfro.utils.update.impl.DefaultFileChecker;
import in.gov.tn.aavin.aavinposfro.utils.update.impl.DefaultFileCreator;
import in.gov.tn.aavin.aavinposfro.utils.update.impl.DefaultInstallNotifier;
import in.gov.tn.aavin.aavinposfro.utils.update.impl.DefaultInstallStrategy;
import in.gov.tn.aavin.aavinposfro.utils.update.impl.DefaultUpdateChecker;
import in.gov.tn.aavin.aavinposfro.utils.update.impl.DefaultUpdateNotifier;
import in.gov.tn.aavin.aavinposfro.utils.update.impl.WifiFirstStrategy;
import in.gov.tn.aavin.aavinposfro.utils.update.model.CheckEntity;
import in.gov.tn.aavin.aavinposfro.utils.update.util.L;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * 此类用于提供一些默认使用的更新配置。
 *
 * <p>在进行更新任务时，当{@link UpdateBuilder} 中未设置对应的配置时。将从此配置类中读取默认的配置进行使用
 *
 * @author haoge
 */
public final class UpdateConfig {

    private Class<? extends CheckWorker> checkWorker;
    private Class<? extends DownloadWorker> downloadWorker;
    private CheckEntity entity;
    private UpdateStrategy updateStrategy;
    private CheckNotifier checkNotifier;
    private InstallNotifier installNotifier;
    private DownloadNotifier downloadNotifier;
    private UpdateParser updateParser;
    private FileCreator fileCreator;
    private UpdateChecker updateChecker;
    private FileChecker fileChecker;
    private InstallStrategy installStrategy;
    private ExecutorService executor;
    private CheckCallback checkCallback;
    private DownloadCallback downloadCallback;

    private static UpdateConfig DEFAULT;

    /**
     * 获取一个全局默认的更新配置。正常情况下，使用的即是此默认的更新配置。
     *
     * <p>当使用{@link UpdateBuilder#check()}建立新的更新任务时，则将使用此默认的更新配置进行默认配置提供
     *
     * @return 默认的更新配置。
     */
    public static UpdateConfig getConfig() {
        if (DEFAULT == null) {
            DEFAULT = new UpdateConfig();
        }
        return DEFAULT;
    }

    /**
     * 创建一个新的更新配置提供使用，当有多个需求需要用到更新逻辑时，可使用此方法针对不同的更新逻辑创建不同的更新配置使用：
     * 如插件化远程插件的下载。
     *
     * <p>要使用此方式创建出来的更新配置。需要使用{@link UpdateBuilder#create(UpdateConfig)}进行更新任务创建。
     *
     * @return 新的更新配置。
     */
    public static UpdateConfig createConfig() {
        return new UpdateConfig();
    }

    /**
     * 配置更新api。此方法设置的api是对于只有url数据。请求方式为GET请求时所使用的。
     *
     * <p>请注意：此配置方法与{@link #setCheckEntity(CheckEntity)}互斥。
     *
     * @param url 用于进行检查更新的url地址
     * @return itself
     * @see #setCheckEntity(CheckEntity)
     */
    public UpdateConfig setUrl(String url) {
        this.entity = new CheckEntity().setUrl(url);
        return this;
    }

    /**
     * 配置更新api。此方法是用于针对复杂api的需求进行配置的。本身提供url,method,params。对于其他需要的数据。
     * 可通过继承此{@link CheckEntity}实体类，加入更多数据。并通过{@link #setCheckWorker(Class)}配置对应
     * 的网络任务进行匹配兼容
     *
     * @param entity 更新api数据实体类
     * @return itself
     */
    public UpdateConfig setCheckEntity(CheckEntity entity) {
        this.entity = entity;
        return this;
    }

    public UpdateConfig setUpdateChecker(UpdateChecker checker) {
        this.updateChecker = checker;
        return this;
    }


    public UpdateConfig setFileChecker(FileChecker checker) {
        this.fileChecker = checker;
        return this;
    }


    public UpdateConfig setCheckWorker(Class<? extends CheckWorker> checkWorker) {
        this.checkWorker = checkWorker;
        return this;
    }

    public UpdateConfig setDownloadWorker(Class<? extends DownloadWorker> downloadWorker) {
        this.downloadWorker = downloadWorker;
        return this;
    }

    /**
     * 配置下载回调监听。
     *
     * @param callback 下载回调监听
     * @return itself
     * @see DownloadCallback
     */
    public UpdateConfig setDownloadCallback(DownloadCallback callback) {
        this.downloadCallback = callback;
        return this;
    }

    /**
     * 配置更新检查回调监听
     *
     * @param callback 更新检查回调器
     * @return itself
     * @see CheckCallback
     */
    public UpdateConfig setCheckCallback(CheckCallback callback) {
        this.checkCallback = callback;
        return this;
    }

    /**
     * 配置更新数据解析器。
     *
     * @param updateParser 解析器
     * @return itself
     * @see UpdateParser
     */
    public UpdateConfig setUpdateParser(UpdateParser updateParser) {
        this.updateParser = updateParser;
        return this;
    }


    public UpdateConfig setFileCreator(FileCreator fileCreator) {
        this.fileCreator = fileCreator;
        return this;
    }


    public UpdateConfig setDownloadNotifier(DownloadNotifier notifier) {
        this.downloadNotifier = notifier;
        return this;
    }


    public UpdateConfig setInstallNotifier(InstallNotifier notifier) {
        this.installNotifier = notifier;
        return this;
    }

    public UpdateConfig setCheckNotifier(CheckNotifier notifier) {
        this.checkNotifier = notifier;
        return this;
    }


    public UpdateConfig setUpdateStrategy(UpdateStrategy strategy) {
        this.updateStrategy = strategy;
        return this;
    }


    public UpdateConfig setInstallStrategy(InstallStrategy installStrategy) {
        this.installStrategy = installStrategy;
        return this;
    }

    public UpdateStrategy getUpdateStrategy() {
        if (updateStrategy == null) {
            updateStrategy = new WifiFirstStrategy();
        }
        return updateStrategy;
    }

    public CheckEntity getCheckEntity() {
        if (this.entity == null || TextUtils.isEmpty(this.entity.getUrl())) {
            throw new IllegalArgumentException("Do not set url in CheckEntity");
        }
        return this.entity;
    }

    public CheckNotifier getCheckNotifier() {
        if (checkNotifier == null) {
            checkNotifier = new DefaultUpdateNotifier();
        }
        return checkNotifier;
    }

    public InstallNotifier getInstallNotifier() {
        if (installNotifier == null) {
            installNotifier = new DefaultInstallNotifier();
        }
        return installNotifier;
    }

    public UpdateChecker getUpdateChecker() {
        if (updateChecker == null) {
            updateChecker = new DefaultUpdateChecker();
        }
        return updateChecker;
    }

    public FileChecker getFileChecker() {
        if (fileChecker == null) {
            fileChecker = new DefaultFileChecker();
        }
        return fileChecker;
    }

    public DownloadNotifier getDownloadNotifier() {
        if (downloadNotifier == null) {
            downloadNotifier = new DefaultDownloadNotifier();
        }
        return downloadNotifier;
    }

    public UpdateParser getUpdateParser() {
        if (updateParser == null) {
            throw new IllegalStateException("update parser is null");
        }
        return updateParser;
    }

    public Class<? extends CheckWorker> getCheckWorker() {
        if (checkWorker == null) {
            checkWorker = DefaultCheckWorker.class;
        }
        return checkWorker;
    }

    public Class<? extends DownloadWorker> getDownloadWorker() {
        if (downloadWorker == null) {
            downloadWorker = DefaultDownloadWorker.class;
        }
        return downloadWorker;
    }

    public FileCreator getFileCreator() {
        if (fileCreator == null) {
            fileCreator = new DefaultFileCreator();
        }
        return fileCreator;
    }

    public InstallStrategy getInstallStrategy() {
        if (installStrategy == null) {
            installStrategy = new DefaultInstallStrategy();
        }
        return installStrategy;
    }

    public ExecutorService getExecutor() {
        if (executor == null) {
            executor = Executors.newFixedThreadPool(2);
        }
        return executor;
    }

    public CheckCallback getCheckCallback() {
        return checkCallback;
    }

    public DownloadCallback getDownloadCallback() {
        return downloadCallback;
    }

    public static void LogEnable(boolean enable) {
        L.ENABLE = enable;
    }
}

