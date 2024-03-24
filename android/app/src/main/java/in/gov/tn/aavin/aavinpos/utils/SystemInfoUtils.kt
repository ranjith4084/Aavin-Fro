package `in`.gov.tn.aavin.aavinposfro.utils

import android.app.Activity
import android.content.Context
import android.os.Build
import android.telephony.TelephonyManager
import android.text.TextUtils
import java.io.IOException
import java.io.InputStreamReader
import java.io.LineNumberReader
import java.lang.Exception
import java.lang.reflect.InvocationTargetException
import java.lang.reflect.Method
import java.util.HashMap

/**
 * Created by yyzz on 2018/12/10.
 */
object SystemInfoUtils {//return android.os.Build.VERSION.RELEASE;
    /**
     * 获取当前手机系统版本号
     *
     * @return 系统版本号
     */
    val systemVersion: String
        get() = Build.DISPLAY
    //return android.os.Build.VERSION.RELEASE;
    /**
     * 获取手机型号
     *
     * @return 手机型号
     */
    val systemModel: String
        get() = Build.MODEL

    /**
     * 获取手机厂商
     *
     * @return 手机厂商
     */
    val deviceBrand: String
        get() = Build.BRAND

    /**
     * 获取SN
     *
     * @return
     */
    fun getSn(ctx: Context?): String? {
        var serial: String? = null
        try {
            val c = Class.forName("android.os.SystemProperties")
            val get = c.getMethod("get", String::class.java)
            serial = get.invoke(c, "ro.serialno") as String
        } catch (ignored: Exception) {
        }
        return serial
    }

    /**
     * 系统4.0的时候
     * 获取手机IMEI 或者Meid
     *
     * @return 手机IMEI
     */
    fun getImeiOrMeid(ctx: Context): String? {
        val tm = ctx.getSystemService(Activity.TELEPHONY_SERVICE) as TelephonyManager
        return if (tm != null) {
            tm.deviceId
        } else null
    }

    /**
     * 拿到imei或者meid后判断是有多少位数
     *
     * @param ctx
     * @return
     */
    fun getNumber(ctx: Context): Int {
        var count = 0
        var number = getImeiOrMeid(ctx)!!
            .trim { it <= ' ' }.toLong()
        while (number > 0) {
            number = number / 10
            count++
        }
        return count
    }

    /**
     * Flyme 说 5.0 6.0统一使用这个获取IMEI IMEI2 MEID
     *
     * @param ctx
     * @return
     */
    /*fun getImeiAndMeid(ctx: Context): Map<*, *> {
        val map: MutableMap<String, String> = HashMap()
        val mTelephonyManager = ctx.getSystemService(Activity.TELEPHONY_SERVICE) as TelephonyManager
        var clazz: Class<*>? = null
        var method: Method? = null //(int slotId)
        try {
            clazz = Class.forName("android.os.SystemProperties")
            method = clazz.getMethod("get", String::class.java, String::class.java)
            val gsm = method.invoke(null, "ril.gsm.imei", "") as String
            val meid = method.invoke(null, "ril.cdma.meid", "") as String
            map["meid"] = meid
            if (!TextUtils.isEmpty(gsm)) {
                //the value of gsm like:xxxxxx,xxxxxx
                val imeiArray = gsm.split(",").toTypedArray()
                if (imeiArray != null && imeiArray.size > 0) {
                    map["imei1"] = imeiArray[0]
                    if (imeiArray.size > 1) {
                        map["imei2"] = imeiArray[1]
                    } else {
                        map["imei2"] = mTelephonyManager.getDeviceId(1)
                    }
                } else {
                    map["imei1"] = mTelephonyManager.getDeviceId(0)
                    map["imei2"] = mTelephonyManager.getDeviceId(1)
                }
            } else {
                map["imei1"] = mTelephonyManager.getDeviceId(0)
                map["imei2"] = mTelephonyManager.getDeviceId(1)
            }
        } catch (e: ClassNotFoundException) {
            e.printStackTrace()
        } catch (e: NoSuchMethodException) {
            e.printStackTrace()
        } catch (e: IllegalAccessException) {
            e.printStackTrace()
        } catch (e: InvocationTargetException) {
            e.printStackTrace()
        }
        return map
    }*/

    // 去空格
    val mac: String
        get() {
            var macSerial = ""
            var str = ""
            try {
                val pp = Runtime.getRuntime().exec("cat /sys/class/net/wlan0/address")
                val ir = InputStreamReader(pp.inputStream)
                val input = LineNumberReader(ir)
                while (null != str) {
                    str = input.readLine()
                    if (str != null) {
                        macSerial = str.trim { it <= ' ' } // 去空格
                        break
                    }
                }
            } catch (ex: IOException) {
                ex.printStackTrace()
            }
            return macSerial
        }
}