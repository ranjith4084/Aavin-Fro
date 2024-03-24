package `in`.gov.tn.aavin.aavinposfro.utils

import android.content.Context
import android.widget.Toast
import androidx.annotation.StringRes

/**
 * Created by shihao on 2017/3/5.
 *
 *
 * toast 管理类，避免出现长时间显示toast
 */
class ToastManager private constructor(context: Context) {
    private var mToast: Toast? = null
    fun setText(msg: CharSequence?): ToastManager {
        mToast!!.setText(msg)
        return this
    }

    fun setText(@StringRes resId: Int): ToastManager {
        mToast!!.setText(resId)
        return this
    }

    fun durationShort(): ToastManager {
        mToast!!.duration = Toast.LENGTH_SHORT
        return this
    }

    fun durationLong(): ToastManager {
        mToast!!.duration = Toast.LENGTH_LONG
        return this
    }

    fun show() {
        mToast!!.show()
    }

    companion object {
        private var manager: ToastManager? = null
        fun getInstance(context: Context): ToastManager? {
            if (manager == null) manager = ToastManager(context)
            return manager
        }

        /*fun showShort(context: Context, msg: String?) {
            getInstance(context)
                .setText(msg)
                .durationShort()
                .show()
        }

        fun showLong(context: Context, msg: String?) {
            getInstance(context)
                .setText(msg)
                .durationLong()
                .show()
        }

        fun showShort(context: Context, @StringRes resId: Int) {
            getInstance(context)
                .setText(resId)
                .durationShort()
                .show()
        }

        fun showLong(context: Context, @StringRes resId: Int) {
            getInstance(context)
                .setText(resId)
                .durationLong()
                .show()
        }*/
    }

    init {
        if (mToast == null) mToast = Toast.makeText(context, "", Toast.LENGTH_SHORT)
    }
}