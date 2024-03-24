package `in`.gov.tn.aavin.aavinposfro.utils

import `in`.gov.tn.aavin.aavinposfro.R
import android.animation.ValueAnimator
import android.app.Activity
import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.content.res.Configuration
import android.net.ConnectivityManager
import android.net.NetworkInfo
import android.net.Proxy
import android.net.Uri
import android.provider.Settings
import android.telephony.TelephonyManager
import android.text.TextUtils
import android.util.TypedValue
import android.view.View
import android.view.ViewGroup
import java.io.*
import java.lang.Exception
import java.lang.IllegalArgumentException
import java.lang.RuntimeException
import java.lang.StringBuilder
import java.text.SimpleDateFormat
import java.util.*
import java.util.regex.Pattern

/**
 * Created by wanglei on 2016/11/28.
 */
class Kits {
    object Screen {
        /**
         * 获取屏幕宽度
         *
         * @return
         */
        fun getScreenWidth(context: Context): Int {
            return context.resources.displayMetrics.widthPixels
        }

        /**
         * 获取屏幕高度
         *
         * @return
         */
        fun getScreenHeight(context: Context): Int {
            return context.resources.displayMetrics.heightPixels
        }

        fun getStatusBarHeight(context: Context): Int {
            var result = 0
            val resourceId =
                context.resources.getIdentifier("status_bar_height", "dimen", "android")
            if (resourceId > 0) {
                result = context.resources.getDimensionPixelSize(resourceId)
            }
            return result
        }

        /*fun getActionBarSize(context: Context): Int {
            val tv = TypedValue()
            return if (context.theme.resolveAttribute(R.attr.actionBarSize, tv, true)) {
                TypedValue.complexToDimensionPixelSize(
                    tv.data,
                    context.resources.displayMetrics
                )
            } else 0
        }*/

        /**
         * 当前是否是横屏
         *
         * @param context context
         * @return boolean
         */
        fun isLandscape(context: Context): Boolean {
            return context.resources.configuration.orientation == Configuration.ORIENTATION_LANDSCAPE
        }

        /**
         * 当前是否是竖屏
         *
         * @param context context
         * @return boolean
         */
        fun isPortrait(context: Context): Boolean {
            return context.resources.configuration.orientation == Configuration.ORIENTATION_PORTRAIT
        }

        /**
         * 调整窗口的透明度  1.0f,0.5f 变暗
         *
         * @param from    from>=0&&from<=1.0f
         * @param to      to>=0&&to<=1.0f
         * @param context 当前的activity
         */
        fun dimBackground(from: Float, to: Float, context: Activity) {
            val window = context.window
            val valueAnimator = ValueAnimator.ofFloat(from, to)
            valueAnimator.duration = 500
            valueAnimator.addUpdateListener { animation ->
                val params = window.attributes
                params.alpha = (animation.animatedValue as Float)
                window.attributes = params
            }
            valueAnimator.start()
        }

        /**
         * 判断是否开启了自动亮度调节
         *
         * @param activity
         * @return
         */
        fun isAutoBrightness(activity: Activity): Boolean {
            var isAutoAdjustBright = false
            try {
                isAutoAdjustBright = Settings.System.getInt(
                    activity.contentResolver,
                    Settings.System.SCREEN_BRIGHTNESS_MODE
                ) == Settings.System.SCREEN_BRIGHTNESS_MODE_AUTOMATIC
            } catch (e: Settings.SettingNotFoundException) {
                e.printStackTrace()
            }
            return isAutoAdjustBright
        }

        /**
         * 关闭亮度自动调节
         *
         * @param activity
         */
        fun stopAutoBrightness(activity: Activity) {
            Settings.System.putInt(
                activity.contentResolver,
                Settings.System.SCREEN_BRIGHTNESS_MODE,
                Settings.System.SCREEN_BRIGHTNESS_MODE_MANUAL
            )
        }

        /**
         * 开启亮度自动调节
         *
         * @param activity
         */
        fun startAutoBrightness(activity: Activity) {
            Settings.System.putInt(
                activity.contentResolver,
                Settings.System.SCREEN_BRIGHTNESS_MODE,
                Settings.System.SCREEN_BRIGHTNESS_MODE_AUTOMATIC
            )
        }

        /**
         * 获得当前屏幕亮度值
         *
         * @return 0~100
         */
        fun getScreenBrightness(context: Context): Int {
            return (getScreenBrightnessInt255(context) / 255.0f * 100).toInt()
        }

        /**
         * 获得当前屏幕亮度值
         *
         * @return 0~255
         */
        fun getScreenBrightnessInt255(context: Context): Int {
            var screenBrightness = 255
            try {
                screenBrightness = Settings.System.getInt(
                    context.contentResolver,
                    Settings.System.SCREEN_BRIGHTNESS
                )
            } catch (e: Exception) {
                e.printStackTrace()
            }
            return screenBrightness
        }

        /**
         * 设置当前屏幕亮度值
         *
         * @param paramInt 0~255
         * @param mContext
         */
        fun saveScreenBrightnessInt255(paramInt: Int, mContext: Context) {
            var paramInt = paramInt
            if (paramInt <= 5) {
                paramInt = 5
            }
            try {
                Settings.System.putInt(
                    mContext.contentResolver,
                    Settings.System.SCREEN_BRIGHTNESS,
                    paramInt
                )
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }

        /**
         * 设置当前屏幕亮度值
         *
         * @param paramInt 0~100
         * @param mContext
         */
        fun saveScreenBrightnessInt100(paramInt: Int, mContext: Context) {
            saveScreenBrightnessInt255((paramInt / 100.0f * 255).toInt(), mContext)
        }

        /**
         * 设置当前屏幕亮度值
         *
         * @param paramFloat 0~100
         * @param mContext
         */
        fun saveScreenBrightness(paramFloat: Float, mContext: Context) {
            saveScreenBrightnessInt255((paramFloat / 100.0f * 255).toInt(), mContext)
        }

        /**
         * 设置Activity的亮度
         *
         * @param paramInt
         * @param mActivity
         */
        fun setScreenBrightness(paramInt: Int, mActivity: Activity) {
            var paramInt = paramInt
            if (paramInt <= 5) {
                paramInt = 5
            }
            val localWindow = mActivity.window
            val localLayoutParams = localWindow.attributes
            val f = paramInt / 100.0f
            localLayoutParams.screenBrightness = f
            localWindow.attributes = localLayoutParams
        }

        /**
         * 测量view的尺寸，实际上view的最终尺寸会由于父布局传递来的MeasureSpec和view本身的LayoutParams共同决定
         * 这里预先测量，由自己给出的MeasureSpec计算尺寸
         *
         * @param view
         */
        fun measure(view: View) {
            val sizeWidth: Int
            val sizeHeight: Int
            val modeWidth: Int
            val modeHeight: Int
            var layoutParams = view.layoutParams
            if (layoutParams == null) {
                layoutParams = ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.WRAP_CONTENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT
                )
            }
            if (layoutParams.width == ViewGroup.LayoutParams.WRAP_CONTENT) {
                sizeWidth = 0
                modeWidth = View.MeasureSpec.UNSPECIFIED
            } else {
                sizeWidth = layoutParams.width
                modeWidth = View.MeasureSpec.EXACTLY
            }
            if (layoutParams.height == ViewGroup.LayoutParams.WRAP_CONTENT) {
                sizeHeight = 0
                modeHeight = View.MeasureSpec.UNSPECIFIED
            } else {
                sizeHeight = layoutParams.height
                modeHeight = View.MeasureSpec.EXACTLY
            }
            view.measure(
                View.MeasureSpec.makeMeasureSpec(sizeWidth, modeWidth),
                View.MeasureSpec.makeMeasureSpec(sizeHeight, modeHeight)
            )
        }
    }

    object Package {
        fun getAppName(context: Context): String? {
            try {
                val packageManager = context.packageManager
                val packageInfo = packageManager.getPackageInfo(context.packageName, 0)
                val labelRes = packageInfo.applicationInfo.labelRes
                return context.resources.getString(labelRes)
            } catch (e: Exception) {
                e.printStackTrace()
            }
            return null
        }

        fun getPackageName(context: Context): String? {
            try {
                val packageManager = context.packageManager
                val packageInfo =
                    packageManager.getPackageInfo(context.packageName, 0)
                return packageInfo.packageName
            } catch (e: Exception) {
                e.printStackTrace()
            }
            return null
        }

        /**
         * 获取版本号
         *
         * @param context
         * @return
         */
        fun getVersionCode(context: Context): Int {
            val pManager = context.packageManager
            var packageInfo: PackageInfo? = null
            var versionCode = 0
            try {
                packageInfo = pManager.getPackageInfo(context.packageName, 0)
                versionCode = packageInfo.versionCode
            } catch (e: PackageManager.NameNotFoundException) {
                e.printStackTrace()
            }
            return versionCode
        }

        /**
         * 获取当前版本
         *
         * @param context
         * @return
         */
        fun getVersionName(context: Context): String {
            val pManager = context.packageManager
            var packageInfo: PackageInfo? = null
            var versionName = ""
            try {
                packageInfo = pManager.getPackageInfo(context.packageName, 0)
                versionName = packageInfo.versionName
            } catch (e: PackageManager.NameNotFoundException) {
                e.printStackTrace()
            }
            return versionName
        }

        /**
         * 安装App
         *
         * @param context
         * @param filePath
         * @return
         */
        fun installNormal(context: Context, filePath: String): Boolean {
            val i = Intent(Intent.ACTION_VIEW)
            val file = File(filePath)
            if (file == null || !file.exists() || !file.isFile || file.length() <= 0) {
                return false
            }
            i.setDataAndType(
                Uri.parse("file://$filePath"),
                "application/vnd.android.package-archive"
            )
            i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(i)
            return true
        }

        /**
         * 卸载App
         *
         * @param context
         * @param packageName
         * @return
         */
        fun uninstallNormal(context: Context, packageName: String?): Boolean {
            if (packageName == null || packageName.length == 0) {
                return false
            }
            val i = Intent(
                Intent.ACTION_DELETE, Uri.parse(
                    StringBuilder().append("package:")
                        .append(packageName).toString()
                )
            )
            i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(i)
            return true
        }

        /**
         * 判断是否是系统App
         *
         * @param context
         * @param packageName 包名
         * @return
         */
        fun isSystemApplication(context: Context?, packageName: String?): Boolean {
            if (context == null) {
                return false
            }
            val packageManager = context.packageManager
            if (packageManager == null || packageName == null || packageName.length == 0) {
                return false
            }
            try {
                val app = packageManager.getApplicationInfo(packageName, 0)
                return app != null && app.flags and ApplicationInfo.FLAG_SYSTEM > 0
            } catch (e: PackageManager.NameNotFoundException) {
                e.printStackTrace()
            }
            return false
        }

        /**
         * 判断某个包名是否运行在顶层
         *
         * @param context
         * @param packageName
         * @return
         */
        fun isTopActivity(context: Context?, packageName: String): Boolean? {
            if (context == null || TextUtils.isEmpty(packageName)) {
                return null
            }
            val activityManager =
                context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
            val tasksInfo = activityManager.getRunningTasks(1)
            return if (tasksInfo == null || tasksInfo.isEmpty()) {
                null
            } else try {
                packageName == tasksInfo[0].topActivity!!.packageName
            } catch (e: Exception) {
                e.printStackTrace()
                false
            }
        }

        /**
         * 获取Meta-Data
         *
         * @param context
         * @param key
         * @return
         */
        fun getAppMetaData(context: Context?, key: String?): String? {
            if (context == null || TextUtils.isEmpty(key)) {
                return null
            }
            var resultData: String? = null
            try {
                val packageManager = context.packageManager
                if (packageManager != null) {
                    val applicationInfo = packageManager.getApplicationInfo(
                        context.packageName,
                        PackageManager.GET_META_DATA
                    )
                    if (applicationInfo != null) {
                        if (applicationInfo.metaData != null) {
                            resultData = applicationInfo.metaData.getString(key)
                        }
                    }
                }
            } catch (e: PackageManager.NameNotFoundException) {
                e.printStackTrace()
            }
            return resultData
        }

        /**
         * 判断当前应用是否运行在后台
         *
         * @param context
         * @return
         */
        fun isApplicationInBackground(context: Context): Boolean {
            val am = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
            val taskList = am.getRunningTasks(1)
            if (taskList != null && !taskList.isEmpty()) {
                val topActivity = taskList[0].topActivity
                if (topActivity != null && topActivity.packageName != context.packageName) {
                    return true
                }
            }
            return false
        }
    }

    object Dimens {
        fun dpToPx(context: Context, dp: Float): Float {
            return dp * context.resources.displayMetrics.density
        }

        fun pxToDp(context: Context, px: Float): Float {
            return px / context.resources.displayMetrics.density
        }

        fun dpToPxInt(context: Context, dp: Float): Int {
            return (dpToPx(context, dp) + 0.5f).toInt()
        }

        fun pxToDpCeilInt(context: Context, px: Float): Int {
            return (pxToDp(context, px) + 0.5f).toInt()
        }

        /**
         * 将px值转换为sp值
         *
         * @param pxValue
         * @return
         */
        fun pxToSp(context: Context, pxValue: Float): Float {
            return pxValue / context.resources.displayMetrics.scaledDensity
        }

        /**
         * 将sp值转换为px值
         *
         * @param spValue
         * @return
         */
        fun spToPx(context: Context, spValue: Float): Float {
            return spValue * context.resources.displayMetrics.scaledDensity
        }
    }

    object Random {
        const val NUMBERS_AND_LETTERS =
            "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        const val NUMBERS = "0123456789"
        const val LETTERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        const val CAPITAL_LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        const val LOWER_CASE_LETTERS = "abcdefghijklmnopqrstuvwxyz"
        fun getRandomNumbersAndLetters(length: Int): String? {
            return getRandom(NUMBERS_AND_LETTERS, length)
        }

        fun getRandomNumbers(length: Int): String? {
            return getRandom(NUMBERS, length)
        }

        fun getRandomLetters(length: Int): String? {
            return getRandom(LETTERS, length)
        }

        fun getRandomCapitalLetters(length: Int): String? {
            return getRandom(CAPITAL_LETTERS, length)
        }

        fun getRandomLowerCaseLetters(length: Int): String? {
            return getRandom(LOWER_CASE_LETTERS, length)
        }

        fun getRandom(source: String, length: Int): String? {
            return if (TextUtils.isEmpty(source)) null else getRandom(source.toCharArray(), length)
        }

        fun getRandom(sourceChar: CharArray?, length: Int): String? {
            if (sourceChar == null || sourceChar.size == 0 || length < 0) {
                return null
            }
            val str = StringBuilder(length)
            val random = Random()
            for (i in 0 until length) {
                str.append(sourceChar[random.nextInt(sourceChar.size)])
            }
            return str.toString()
        }

        fun getRandom(max: Int): Int {
            return getRandom(0, max)
        }

        fun getRandom(min: Int, max: Int): Int {
            if (min > max) {
                return 0
            }
            return if (min == max) {
                min
            } else min + Random().nextInt(max - min)
        }
    }

    object File {
        const val FILE_EXTENSION_SEPARATOR = "."

        /**
         * read file
         *
         * @param filePath
         * @param charsetName The name of a supported [&lt;/code&gt;charset&lt;code&gt;][java.nio.charset.Charset]
         * @return if file not exist, return null, else return content of file
         * @throws RuntimeException if an error occurs while operator BufferedReader
         */
        fun readFile(filePath: String?, charsetName: String?): StringBuilder? {
            val file = File(filePath)
            val fileContent = StringBuilder("")
            if (file == null || !file.isFile) {
                return null
            }
            var reader: BufferedReader? = null
            return try {
                val `is` = InputStreamReader(FileInputStream(file), charsetName)
                reader = BufferedReader(`is`)
                var line: String? = null
                while (reader.readLine().also { line = it } != null) {
                    if (fileContent.toString() != "") {
                        fileContent.append("\r\n")
                    }
                    fileContent.append(line)
                }
                fileContent
            } catch (e: IOException) {
                throw RuntimeException("IOException occurred. ", e)
            } finally {
                IO.close(reader)
            }
        }
        /**
         * write file
         *
         * @param filePath
         * @param content
         * @param append   is append, if true, write to the end of file, else clear content of file and write into it
         * @return return false if content is empty, true otherwise
         * @throws RuntimeException if an error occurs while operator FileWriter
         */
        /**
         * write file, the string will be written to the begin of the file
         *
         * @param filePath
         * @param content
         * @return
         */
        @JvmOverloads
        fun writeFile(filePath: String, content: String?, append: Boolean = false): Boolean {
            if (TextUtils.isEmpty(content)) {
                return false
            }
            var fileWriter: FileWriter? = null
            return try {
                makeDirs(filePath)
                fileWriter = FileWriter(filePath, append)
                fileWriter.write(content)
                true
            } catch (e: IOException) {
                throw RuntimeException("IOException occurred. ", e)
            } finally {
                IO.close(fileWriter)
            }
        }
        /**
         * write file
         *
         * @param filePath
         * @param contentList
         * @param append      is append, if true, write to the end of file, else clear content of file and write into it
         * @return return false if contentList is empty, true otherwise
         * @throws RuntimeException if an error occurs while operator FileWriter
         */
        /**
         * write file, the string list will be written to the begin of the file
         *
         * @param filePath
         * @param contentList
         * @return
         */
        @JvmOverloads
        fun writeFile(
            filePath: String,
            contentList: List<String?>?,
            append: Boolean = false
        ): Boolean {
            if (contentList == null || contentList.isEmpty()) {
                return false
            }
            var fileWriter: FileWriter? = null
            return try {
                makeDirs(filePath)
                fileWriter = FileWriter(filePath, append)
                var i = 0
                for (line in contentList) {
                    if (i++ > 0) {
                        fileWriter.write("\r\n")
                    }
                    fileWriter.write(line)
                }
                true
            } catch (e: IOException) {
                throw RuntimeException("IOException occurred. ", e)
            } finally {
                IO.close(fileWriter)
            }
        }
        /**
         * write file
         *
         * @param stream the input stream
         * @param append if `true`, then bytes will be written to the end of the file rather than the
         * beginning
         * @return return true
         * @throws RuntimeException if an error occurs while operator FileOutputStream
         */
        /**
         * write file, the bytes will be written to the begin of the file
         *
         * @param filePath
         * @param stream
         * @return
         * @see {@link .writeFile
         */
        @JvmOverloads
        fun writeFile(filePath: String?, stream: InputStream, append: Boolean = false): Boolean {
            return writeFile(if (filePath != null) File(filePath) else null, stream, append)
        }
        /**
         * write file
         *
         * @param file   the file to be opened for writing.
         * @param stream the input stream
         * @param append if `true`, then bytes will be written to the end of the file rather than the
         * beginning
         * @return return true
         * @throws RuntimeException if an error occurs while operator FileOutputStream
         */
        /**
         * write file, the bytes will be written to the begin of the file
         *
         * @param file
         * @param stream
         * @return
         * @see {@link .writeFile
         */
        @JvmOverloads
        fun writeFile(file: java.io.File?, stream: InputStream, append: Boolean = false): Boolean {
            var o: OutputStream? = null
            return try {
                makeDirs(file!!.absolutePath)
                o = FileOutputStream(file, append)
                val data = ByteArray(1024)
                var length = -1
                while (stream.read(data).also { length = it } != -1) {
                    o.write(data, 0, length)
                }
                o.flush()
                true
            } catch (e: FileNotFoundException) {
                throw RuntimeException("FileNotFoundException occurred. ", e)
            } catch (e: IOException) {
                throw RuntimeException("IOException occurred. ", e)
            } finally {
                IO.close(o)
                IO.close(stream)
            }
        }

        /**
         * move file
         *
         * @param sourceFilePath
         * @param destFilePath
         */
        fun moveFile(sourceFilePath: String?, destFilePath: String?) {
            if (TextUtils.isEmpty(sourceFilePath) || TextUtils.isEmpty(destFilePath)) {
                throw RuntimeException("Both sourceFilePath and destFilePath cannot be null.")
            }
            moveFile(File(sourceFilePath), File(destFilePath))
        }

        /**
         * move file
         *
         * @param srcFile
         * @param destFile
         */
        fun moveFile(srcFile: java.io.File, destFile: java.io.File) {
            val rename = srcFile.renameTo(destFile)
            if (!rename) {
                copyFile(srcFile.absolutePath, destFile.absolutePath)
                deleteFile(srcFile.absolutePath)
            }
        }

        /**
         * copy file
         *
         * @param sourceFilePath
         * @param destFilePath
         * @return
         * @throws RuntimeException if an error occurs while operator FileOutputStream
         */
        fun copyFile(sourceFilePath: String?, destFilePath: String?): Boolean {
            var inputStream: InputStream? = null
            inputStream = try {
                FileInputStream(sourceFilePath)
            } catch (e: FileNotFoundException) {
                throw RuntimeException("FileNotFoundException occurred. ", e)
            }
            return if(inputStream != null)
                writeFile(destFilePath, inputStream)
            else false
        }

        /**
         * read file to string list, a element of list is a line
         *
         * @param filePath
         * @param charsetName The name of a supported [&lt;/code&gt;charset&lt;code&gt;][java.nio.charset.Charset]
         * @return if file not exist, return null, else return content of file
         * @throws RuntimeException if an error occurs while operator BufferedReader
         */
        fun readFileToList(filePath: String?, charsetName: String?): List<String?>? {
            val file = File(filePath)
            val fileContent: MutableList<String?> = ArrayList()
            if (file == null || !file.isFile) {
                return null
            }
            var reader: BufferedReader? = null
            return try {
                val `is` = InputStreamReader(FileInputStream(file), charsetName)
                reader = BufferedReader(`is`)
                var line: String? = null
                while (reader.readLine().also { line = it } != null) {
                    fileContent.add(line)
                }
                fileContent
            } catch (e: IOException) {
                throw RuntimeException("IOException occurred. ", e)
            } finally {
                IO.close(reader)
            }
        }

        /**
         * get file name with path, not include suffix
         *
         *
         * <pre>
         * getFileNameWithoutExtension(null)               =   null
         * getFileNameWithoutExtension("")                 =   ""
         * getFileNameWithoutExtension("   ")              =   "   "
         * getFileNameWithoutExtension("abc")              =   "abc"
         * getFileNameWithoutExtension("a.mp3")            =   "a"
         * getFileNameWithoutExtension("a.b.rmvb")         =   "a.b"
         * getFileNameWithoutExtension("c:\\")              =   ""
         * getFileNameWithoutExtension("c:\\a")             =   "a"
         * getFileNameWithoutExtension("c:\\a.b")           =   "a"
         * getFileNameWithoutExtension("c:a.txt\\a")        =   "a"
         * getFileNameWithoutExtension("/home/admin")      =   "admin"
         * getFileNameWithoutExtension("/home/admin/a.txt/b.mp3")  =   "b"
        </pre> *
         *
         * @param filePath
         * @return file name with path, not include suffix
         * @see
         */
        fun getFileNameWithoutExtension(filePath: String): String {
            if (TextUtils.isEmpty(filePath)) {
                return filePath
            }
            val extenPosi = filePath.lastIndexOf(FILE_EXTENSION_SEPARATOR)
            val filePosi = filePath.lastIndexOf(java.io.File.separator)
            if (filePosi == -1) {
                return if (extenPosi == -1) filePath else filePath.substring(0, extenPosi)
            }
            if (extenPosi == -1) {
                return filePath.substring(filePosi + 1)
            }
            return if (filePosi < extenPosi) filePath.substring(
                filePosi + 1,
                extenPosi
            ) else filePath.substring(
                filePosi
                        + 1
            )
        }

        /**
         * get file name with path, include suffix
         *
         *
         * <pre>
         * getFileName(null)               =   null
         * getFileName("")                 =   ""
         * getFileName("   ")              =   "   "
         * getFileName("a.mp3")            =   "a.mp3"
         * getFileName("a.b.rmvb")         =   "a.b.rmvb"
         * getFileName("abc")              =   "abc"
         * getFileName("c:\\")              =   ""
         * getFileName("c:\\a")             =   "a"
         * getFileName("c:\\a.b")           =   "a.b"
         * getFileName("c:a.txt\\a")        =   "a"
         * getFileName("/home/admin")      =   "admin"
         * getFileName("/home/admin/a.txt/b.mp3")  =   "b.mp3"
        </pre> *
         *
         * @param filePath
         * @return file name with path, include suffix
         */
        fun getFileName(filePath: String): String {
            if (TextUtils.isEmpty(filePath)) {
                return filePath
            }
            val filePosi = filePath.lastIndexOf(java.io.File.separator)
            return if (filePosi == -1) filePath else filePath.substring(filePosi + 1)
        }

        /**
         * get folder name with path
         *
         *
         * <pre>
         * getFolderName(null)               =   null
         * getFolderName("")                 =   ""
         * getFolderName("   ")              =   ""
         * getFolderName("a.mp3")            =   ""
         * getFolderName("a.b.rmvb")         =   ""
         * getFolderName("abc")              =   ""
         * getFolderName("c:\\")              =   "c:"
         * getFolderName("c:\\a")             =   "c:"
         * getFolderName("c:\\a.b")           =   "c:"
         * getFolderName("c:a.txt\\a")        =   "c:a.txt"
         * getFolderName("c:a\\b\\c\\d.txt")    =   "c:a\\b\\c"
         * getFolderName("/home/admin")      =   "/home"
         * getFolderName("/home/admin/a.txt/b.mp3")  =   "/home/admin/a.txt"
        </pre> *
         *
         * @param filePath
         * @return
         */
        fun getFolderName(filePath: String): String {
            if (TextUtils.isEmpty(filePath)) {
                return filePath
            }
            val filePosi = filePath.lastIndexOf(java.io.File.separator)
            return if (filePosi == -1) "" else filePath.substring(0, filePosi)
        }

        /**
         * get suffix of file with path
         *
         *
         * <pre>
         * getFileExtension(null)               =   ""
         * getFileExtension("")                 =   ""
         * getFileExtension("   ")              =   "   "
         * getFileExtension("a.mp3")            =   "mp3"
         * getFileExtension("a.b.rmvb")         =   "rmvb"
         * getFileExtension("abc")              =   ""
         * getFileExtension("c:\\")              =   ""
         * getFileExtension("c:\\a")             =   ""
         * getFileExtension("c:\\a.b")           =   "b"
         * getFileExtension("c:a.txt\\a")        =   ""
         * getFileExtension("/home/admin")      =   ""
         * getFileExtension("/home/admin/a.txt/b")  =   ""
         * getFileExtension("/home/admin/a.txt/b.mp3")  =   "mp3"
        </pre> *
         *
         * @param filePath
         * @return
         */
        fun getFileExtension(filePath: String): String {
            if (TextUtils.isEmpty(filePath)) {
                return filePath
            }
            val extenPosi = filePath.lastIndexOf(FILE_EXTENSION_SEPARATOR)
            val filePosi = filePath.lastIndexOf(java.io.File.separator)
            if (extenPosi == -1) {
                return ""
            }
            return if (filePosi >= extenPosi) "" else filePath.substring(extenPosi + 1)
        }

        /**
         * Creates the directory named by the trailing filename of this file, including the complete directory path
         * required
         * to create this directory. <br></br>
         * <br></br>
         *
         * **Attentions:**
         *  * makeDirs("C:\\Users\\Trinea") can only create users folder
         *  * makeFolder("C:\\Users\\Trinea\\") can create Trinea folder
         *
         *
         * @param filePath
         * @return true if the necessary directories have been created or the target directory already exists, false
         * one of
         * the directories can not be created.
         *
         *  * if [File.getFolderName] return null, return false
         *  * if target directory already exists, return true
         *
         */
        fun makeDirs(filePath: String): Boolean {
            val folderName = getFolderName(filePath)
            if (TextUtils.isEmpty(folderName)) {
                return false
            }
            val folder = File(folderName)
            return if (folder.exists() && folder.isDirectory) true else folder.mkdirs()
        }

        /**
         * @param filePath
         * @return
         * @see .makeDirs
         */
        fun makeFolders(filePath: String): Boolean {
            return makeDirs(filePath)
        }

        /**
         * Indicates if this file represents a file on the underlying file system.
         *
         * @param filePath
         * @return
         */
        fun isFileExist(filePath: String?): Boolean {
            if (TextUtils.isEmpty(filePath)) {
                return false
            }
            val file = File(filePath)
            return file.exists() && file.isFile
        }

        /**
         * Indicates if this file represents a directory on the underlying file system.
         *
         * @param directoryPath
         * @return
         */
        fun isFolderExist(directoryPath: String?): Boolean {
            if (TextUtils.isEmpty(directoryPath)) {
                return false
            }
            val dire = File(directoryPath)
            return dire.exists() && dire.isDirectory
        }

        /**
         * delete file or directory
         *
         *  * if path is null or empty, return true
         *  * if path not exist, return true
         *  * if path exist, delete recursion. return true
         *
         *
         * @param path
         * @return
         */
        fun deleteFile(path: String?): Boolean {
            if (TextUtils.isEmpty(path)) {
                return true
            }
            val file = File(path)
            if (!file.exists()) {
                return true
            }
            if (file.isFile) {
                return file.delete()
            }
            if (!file.isDirectory) {
                return false
            }
            for (f in file.listFiles()) {
                if (f.isFile) {
                    f.delete()
                } else if (f.isDirectory) {
                    deleteFile(f.absolutePath)
                }
            }
            return file.delete()
        }

        /**
         * get file size
         *
         *  * if path is null or empty, return -1
         *  * if path exist and it is a file, return file size, else return -1
         *
         *
         * @param path
         * @return returns the length of this file in bytes. returns -1 if the file does not exist.
         */
        fun getFileSize(path: String?): Long {
            if (TextUtils.isEmpty(path)) {
                return -1
            }
            val file = File(path)
            return if (file.exists() && file.isFile) file.length() else -1
        }
    }

    object IO {
        /**
         * 关闭流
         *
         * @param closeable
         */
        fun close(closeable: Closeable?) {
            if (closeable != null) {
                try {
                    closeable.close()
                } catch (e: IOException) {
                    throw RuntimeException("IOException occurred. ", e)
                }
            }
        }
    }

    object Date {
        private val m = SimpleDateFormat("MM")
        private val d = SimpleDateFormat("dd")
        private val md = SimpleDateFormat("MM-dd")
        private val ymd = SimpleDateFormat("yyyy-MM-dd")
        private val ymdDot = SimpleDateFormat("yyyy.MM.dd")
        private val ymdhms = SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
        private val ymdhmss = SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS")
        private val ymdhm = SimpleDateFormat("yyyy-MM-dd HH:mm")
        private val hm = SimpleDateFormat("HH:mm")
        private val mdhm = SimpleDateFormat("MM月dd日 HH:mm")
        private val mdhmLink = SimpleDateFormat("MM-dd HH:mm")

        /**
         * 年月日[2015-07-28]
         *
         * @param timeInMills
         * @return
         */
        fun getYmd(timeInMills: Long): String {
            return ymd.format(Date(timeInMills))
        }

        /**
         * 年月日[2015.07.28]
         *
         * @param timeInMills
         * @return
         */
        fun getYmdDot(timeInMills: Long): String {
            return ymdDot.format(Date(timeInMills))
        }

        fun getYmdhms(timeInMills: Long): String {
            return ymdhms.format(Date(timeInMills))
        }

        fun getYmdhmsS(timeInMills: Long): String {
            return ymdhmss.format(Date(timeInMills))
        }

        fun getYmdhm(timeInMills: Long): String {
            return ymdhm.format(Date(timeInMills))
        }

        fun getHm(timeInMills: Long): String {
            return hm.format(Date(timeInMills))
        }

        fun getMd(timeInMills: Long): String {
            return md.format(Date(timeInMills))
        }

        fun getMdhm(timeInMills: Long): String {
            return mdhm.format(Date(timeInMills))
        }

        fun getMdhmLink(timeInMills: Long): String {
            return mdhmLink.format(Date(timeInMills))
        }

        fun getM(timeInMills: Long): String {
            return m.format(Date(timeInMills))
        }

        fun getD(timeInMills: Long): String {
            return d.format(Date(timeInMills))
        }

        /**
         * 是否是今天
         *
         * @param timeInMills
         * @return
         */
        fun isToday(timeInMills: Long): Boolean {
            val dest = getYmd(timeInMills)
            val now = getYmd(Calendar.getInstance().timeInMillis)
            return dest == now
        }

        /**
         * 是否是同一天
         *
         * @param aMills
         * @param bMills
         * @return
         */
        fun isSameDay(aMills: Long, bMills: Long): Boolean {
            val aDay = getYmd(aMills)
            val bDay = getYmd(bMills)
            return aDay == bDay
        }

        /**
         * 获取年份
         *
         * @param mills
         * @return
         */
        fun getYear(mills: Long): Int {
            val calendar = Calendar.getInstance()
            calendar.timeInMillis = mills
            return calendar[Calendar.YEAR]
        }

        /**
         * 获取月份
         *
         * @param mills
         * @return
         */
        fun getMonth(mills: Long): Int {
            val calendar = Calendar.getInstance()
            calendar.timeInMillis = mills
            return calendar[Calendar.MONTH] + 1
        }

        /**
         * 获取月份的天数
         *
         * @param mills
         * @return
         */
        fun getDaysInMonth(mills: Long): Int {
            val calendar = Calendar.getInstance()
            calendar.timeInMillis = mills
            val year = calendar[Calendar.YEAR]
            val month = calendar[Calendar.MONTH]
            return when (month) {
                Calendar.JANUARY, Calendar.MARCH, Calendar.MAY, Calendar.JULY, Calendar.AUGUST, Calendar.OCTOBER, Calendar.DECEMBER -> 31
                Calendar.APRIL, Calendar.JUNE, Calendar.SEPTEMBER, Calendar.NOVEMBER -> 30
                Calendar.FEBRUARY -> if (year % 4 == 0) 29 else 28
                else -> throw IllegalArgumentException("Invalid Month")
            }
        }

        /**
         * 获取星期,0-周日,1-周一，2-周二，3-周三，4-周四，5-周五，6-周六
         *
         * @param mills
         * @return
         */
        fun getWeek(mills: Long): Int {
            val calendar = Calendar.getInstance()
            calendar.timeInMillis = mills
            return calendar[Calendar.DAY_OF_WEEK] - 1
        }

        /**
         * 获取当月第一天的时间（毫秒值）
         *
         * @param mills
         * @return
         */
        fun getFirstOfMonth(mills: Long): Long {
            val calendar = Calendar.getInstance()
            calendar.timeInMillis = mills
            calendar[Calendar.DAY_OF_MONTH] = 1
            return calendar.timeInMillis
        }
    }

    object NetWork {
        const val NETWORK_TYPE_WIFI = "wifi"
        const val NETWORK_TYPE_3G = "eg"
        const val NETWORK_TYPE_2G = "2g"
        const val NETWORK_TYPE_WAP = "wap"
        const val NETWORK_TYPE_UNKNOWN = "unknown"
        const val NETWORK_TYPE_DISCONNECT = "disconnect"
        fun isNetworkConnected(context: Context?): Boolean {
            if (context != null) {
                val connectivityManager = context
                    .getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
                val mNetworkInfo = connectivityManager.activeNetworkInfo
                if (mNetworkInfo != null) {
                    return mNetworkInfo.isAvailable
                }
            }
            return false
        }

        fun isWifiConnected(context: Context?): Boolean {
            if (context != null) {
                val mConnectivityManager = context
                    .getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
                val mWiFiNetworkInfo = mConnectivityManager
                    .getNetworkInfo(ConnectivityManager.TYPE_WIFI)
                if (mWiFiNetworkInfo != null) {
                    return mWiFiNetworkInfo.isAvailable
                }
            }
            return false
        }

        fun getNetworkType(context: Context): Int {
            val connectivityManager = context
                .getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            val networkInfo = connectivityManager?.activeNetworkInfo
            return networkInfo?.type ?: -1
        }

        /*fun getNetworkTypeName(context: Context): String {
            val manager =
                context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
            var networkInfo: NetworkInfo
            var type = NETWORK_TYPE_DISCONNECT
            if (manager == null || manager.activeNetworkInfo.also { networkInfo = it!! } == null) {
                return type
            }
            if (networkInfo.isConnected) {
                val typeName = networkInfo.typeName
                type = if ("WIFI".equals(typeName, ignoreCase = true)) {
                    NETWORK_TYPE_WIFI
                } else if ("MOBILE".equals(typeName, ignoreCase = true)) {
                    val proxyHost = Proxy.getDefaultHost()
                    if (TextUtils.isEmpty(proxyHost)) if (isFastMobileNetwork(context)) NETWORK_TYPE_3G else NETWORK_TYPE_2G else NETWORK_TYPE_WAP
                } else {
                    NETWORK_TYPE_UNKNOWN
                }
            }
            return type
        }*/

        /*private fun isFastMobileNetwork(context: Context): Boolean {
            val telephonyManager =
                context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
                    ?: return false
            return when (telephonyManager.networkType) {
                TelephonyManager.NETWORK_TYPE_1xRTT -> false
                TelephonyManager.NETWORK_TYPE_CDMA -> false
                TelephonyManager.NETWORK_TYPE_EDGE -> false
                TelephonyManager.NETWORK_TYPE_EVDO_0 -> true
                TelephonyManager.NETWORK_TYPE_EVDO_A -> true
                TelephonyManager.NETWORK_TYPE_GPRS -> false
                TelephonyManager.NETWORK_TYPE_HSDPA -> true
                TelephonyManager.NETWORK_TYPE_HSPA -> true
                TelephonyManager.NETWORK_TYPE_HSUPA -> true
                TelephonyManager.NETWORK_TYPE_UMTS -> true
                TelephonyManager.NETWORK_TYPE_EHRPD -> true
                TelephonyManager.NETWORK_TYPE_EVDO_B -> true
                TelephonyManager.NETWORK_TYPE_HSPAP -> true
                TelephonyManager.NETWORK_TYPE_IDEN -> false
                TelephonyManager.NETWORK_TYPE_LTE -> true
                TelephonyManager.NETWORK_TYPE_UNKNOWN -> false
                else -> false
            }
        }*/
    }

    object Empty {
        fun check(obj: Any?): Boolean {
            return obj == null
        }

        fun check(list: List<*>?): Boolean {
            return list == null || list.isEmpty()
        }

        fun check(array: Array<Any?>?): Boolean {
            return array == null || array.size == 0
        }

        fun check(str: String?): Boolean {
            return str == null || "" == str
        }
    }

    /**
     * 常用正则表达式匹配
     *
     * @author shihao
     */
    object PatternMatcher {
        /**
         * 是否为国内移动手机号
         *
         * @param mobile
         * @return
         */
        fun isMobileNumber(mobile: String?): Boolean {
            val p = Pattern.compile("^1(3|5|7|8)\\d{9}$")
            val m = p.matcher(mobile)
            return m.matches()
        }

        /**
         * 是否为电子邮箱地址
         *
         * @param email
         * @return
         */
        fun isEmail(email: String?): Boolean {
            val p = Pattern.compile("^\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}$")
            val m = p.matcher(email)
            return m.matches()
        }

        /**
         * 是否为网址
         *
         * @param url
         * @return
         */
        fun isUrl(url: String?): Boolean {
            val p = Pattern.compile("^[a-zA-z]+://[^\\s]*$")
            val m = p.matcher(url)
            return m.matches()
        }

        /**
         * 是否为身份证号
         *
         * @param num
         * @return
         */
        fun isIDNumber(num: String?): Boolean {
            val p = Pattern.compile("^\\d{15}|\\d{17}[0-9Xx]$")
            val m = p.matcher(num)
            return m.matches()
        }

        /**
         * 是否为QQ号
         *
         * @param qq
         * @return
         */
        fun isQQNumber(qq: String?): Boolean {
            val p = Pattern.compile("^[1-9][0-9]{4,}$")
            val m = p.matcher(qq)
            return m.matches()
        }

        /**
         * 时候为邮政编码
         *
         * @param code
         * @return
         */
        fun isPostalCode(code: String?): Boolean {
            val p = Pattern.compile("^[1-9][0-9]{5}$")
            val m = p.matcher(code)
            return m.matches()
        }

        /**
         * 是否为ipv4地址
         *
         * @param ip
         * @return
         */
        fun isIPV4Address(ip: String?): Boolean {
            val p = Pattern.compile(
                "^((?:(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d)))\\.){3}" +
                        "(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d))))$"
            )
            val m = p.matcher(ip)
            return m.matches()
        }

        /**
         * 从html中找出img标签中的图片地址
         *
         * @param html
         * @return
         */
        fun getImgUrlFromHtml(html: String?): List<String> {
            val results: MutableList<String> = ArrayList()
            val p = Pattern.compile("<img.*?src.*?=\"(.*?)\"", Pattern.CASE_INSENSITIVE)
            val m = p.matcher(html)
            while (m.find()) {
                results.add(m.group(1))
            }
            return results
        }

        /**
         * 从html中匹配出节点element对应属性attr的值
         *
         * @param element 节点名
         * @param attr    属性名
         * @param html    待匹配数据
         * @return
         */
        fun getElementAttributeFromHtml(
            element: String,
            attr: String,
            html: String?
        ): List<String> {
            val results: MutableList<String> = ArrayList()
            val p = Pattern.compile("<$element.*?$attr.*?\"(.*?)\"", Pattern.CASE_INSENSITIVE)
            val m = p.matcher(html)
            while (m.find()) {
                results.add(m.group(1))
            }
            return results
        }
    }
}