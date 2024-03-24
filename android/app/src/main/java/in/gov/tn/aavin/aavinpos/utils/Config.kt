package `in`.gov.tn.aavin.aavinposfro.utils

import `in`.gov.tn.aavin.aavinposfro.App
import android.annotation.SuppressLint
import android.app.Application
import android.app.ProgressDialog
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageInfo
import android.os.Looper
import android.util.Log
import android.widget.Toast
import com.zcs.sdk.Sys
import org.json.JSONObject
import java.lang.Exception
import java.lang.NullPointerException
import java.lang.reflect.InvocationTargetException
import java.util.HashMap

class Config {
    /*fun setUpdate(): Config {
        // Update
        var versionName: String = `in`.gov.tn.aavin.aavinposfro.utils.Kits.Package.getVersionName(
            sApplication
        )
        if (versionName != null && versionName.length > 5) {
            versionName = versionName.substring(0, 5)
        }
        val appName = "smartpos"
        val versionCode: Int = `in`.gov.tn.aavin.aavinposfro.utils.Kits.Package.getVersionCode(
            sApplication
        )
        val pkgName: String = `in`.gov.tn.aavin.aavinposfro.utils.Kits.Package.getPackageName(
            sApplication
        )
        val params = HashMap<String, String>()
        params[APP_NAME] = appName
        params[APP_VERSION] = "V$versionName"
        params[SYS_TYPE] = SYS_TYPE_VALUE
        UpdateConfig.getConfig()
            .setCheckEntity(CheckEntity().setUrl(CHECK_UPDATE).setMethod("POST").setParams(params))
            .setUpdateParser(object : UpdateParser() {
                @Throws(Exception::class)
                fun parse(response: String?): Update? {
                    Log.d("CheckUpdate params", params.toString())
                    Log.d("CheckUpdate res", response!!)
                    var update: Update? = null
                    val jsonObject = JSONObject(response)
                    val state = jsonObject.getString(CHECK_STATE)
                    if ("2" != state) {
                        update = Update()
                        val url = jsonObject.getString(FILE_URL)
                        val desc = jsonObject.getString(FILE_DESC)
                        update.setUpdateUrl(BASE_URL + url)
                        update.setUpdateContent(desc)
                        update.setForced(false)
                        update.setVersionCode(versionCode + 1)
                        //update.setVersionName(finalVersionName);
                        update.setPkg(pkgName)
                    } else {
                        Looper.prepare()
                        Toast.makeText(app, "No update", Toast.LENGTH_SHORT).show()
                        Looper.loop()
                    }
                    return update
                }
            })
            .setInstallStrategy(object : InstallStrategy() {
                fun install(context: Context?, filename: String?, update: Update?) {
                    ProgressDialog.show(ActivityManager.get().topActivity(), null, "Installing")
                    silentInstall(filename)
                }
            })
        return this
    }*/

    companion object {
        const val BASE_URL = "http://tms.szzcs.com:7099/pay/"
        const val CHECK_FIRMWARE_UPDATE = BASE_URL + "tms/getUpgradeInf.json" // 检查更新
        const val CHECK_UPDATE = BASE_URL + "tms/getAppUpgradeInf.json" // 检查APP更新

        /* 服务端返回的结果 */
        const val RES_OK = "000000"
        const val RES_ERR = "999999"
        const val NET_CONN_ERROR = "netException"
        const val SERVER_CONN_ERROR = "webException"
        const val NET_EXCEPTION = "exception"
        const val REQUEST_YES = "yes"
        const val REQUEST_NO = "no"
        const val REQUEST_NULL = "null"
        const val ERROR = "ERROR"
        const val SUCCESS = "SUCCESS"
        const val EXIST = "EXIST" // 用户已存在

        /* inten跳转状态码 */
        const val REQUEST_CODE = "requstCode"
        const val SEARCH_TO_RESULT = 1
        const val LIST_TO_RESULT = 2
        const val COLLECT_TO_RESULT = 3
        const val PUBLISH_TO_RESULT = 7

        // update
        const val APP_NAME = "appName"
        const val APP_VERSION = "appVersion"
        const val SYS_TYPE = "sysType"
        const val SYS_TYPE_VALUE = "Android"
        const val CHECK_STATE = "checkState"
        const val FILE_URL = "fileUrl"
        const val FILE_DESC = "fileDesc"
        const val FIRMWARE_NAME = "firmWareName"
        const val FIRMV_ERSION = "firmVersion"
        const val PID = "pid"
        private var sUtils: Config? = null
        private var sApplication: Application? = null
        val instance: Config?
            get() {
                if (sUtils == null) sUtils = Config()
                return sUtils
            }

        fun init(app: Application?): Config? {
            instance
            if (sApplication == null) {
                if (app == null) {
                    sApplication = applicationByReflect
                } else {
                    sApplication = app
                }
            } else {
                if (app != null && app.javaClass != sApplication!!.javaClass) {
                    sApplication = app
                }
            }
            return sUtils
        }

        val app: Application?
            get() {
                if (sApplication != null) return sApplication
                val app = applicationByReflect
                init(app)
                return app
            }
        private val applicationByReflect: Application
            private get() {
                try {
                    @SuppressLint("PrivateApi") val activityThread =
                        Class.forName("android.app.ActivityThread")
                    val thread = activityThread.getMethod("currentActivityThread").invoke(null)
                    val app = activityThread.getMethod("getApplication").invoke(thread)
                        ?: throw NullPointerException("u should init first")
                    return app as Application
                } catch (e: NoSuchMethodException) {
                    e.printStackTrace()
                } catch (e: IllegalAccessException) {
                    e.printStackTrace()
                } catch (e: InvocationTargetException) {
                    e.printStackTrace()
                } catch (e: ClassNotFoundException) {
                    e.printStackTrace()
                }
                throw NullPointerException("u should init first")
            }

        /*fun silentInstall(fileName: String?) {
            val sys: Sys = App.sDriverManager!!.baseSysDevice
            sys.installApp2NoAuth(sApplication, fileName)
        }*/

        /*fun startApp(pkg: String?, cls: String?) {
            var packageInfo: PackageInfo? = null
            val pm = app!!.packageManager
            try {
                packageInfo = pm.getPackageInfo(pkg!!, 0)
                if (packageInfo != null) {
                    val i = Intent()
                    i.setComponent(ComponentName(pkg, cls!!)).flags =
                        Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED
                    app!!.startActivity(i)
                } else {
                    `in`.gov.tn.aavin.aavinposfro.utils.ToastManager.showShort(
                        app,
                        "Without this application"
                    )
                }
            } catch (e: Exception) {
                e.printStackTrace()
                `in`.gov.tn.aavin.aavinposfro.utils.ToastManager.showShort(
                    app,
                    "Without this application"
                )
            }
        }*/
    }
}