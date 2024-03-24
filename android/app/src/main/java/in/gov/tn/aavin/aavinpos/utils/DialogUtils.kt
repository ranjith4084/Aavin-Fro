package `in`.gov.tn.aavin.aavinposfro.utils

import android.app.Activity
import android.app.AlertDialog
import android.app.Dialog
import android.app.ProgressDialog
import android.content.Context
import android.content.DialogInterface
import android.view.View
import android.view.WindowManager
import android.view.inputmethod.InputMethodManager

/**
 * Created by yyzz on 2018/5/18.
 */
object DialogUtils {
    fun destoryDialog() {}
    fun showProgress(context: Context?, title: String?, message: String?): ProgressDialog {
        return ProgressDialog.show(context, title, message)
    }

    fun showProgress(
        context: Context?,
        title: String?,
        message: String?,
        cancelListener: DialogInterface.OnCancelListener?
    ): Dialog {
        return ProgressDialog.show(context, title, message, false, true, cancelListener)
    }

    fun showViewDialog(
        context: Context?,
        view: View?,
        title: String?,
        message: String?,
        confirmButton: String?,
        cancelButton: String?,
        confirmListener: DialogInterface.OnClickListener?,
        cancelListener: DialogInterface.OnClickListener?
    ): Dialog {
        return show(
            context,
            title,
            message,
            view,
            true,
            confirmButton,
            confirmListener,
            null,
            null,
            cancelButton,
            cancelListener,
            null,
            null,
            null
        )
    }

    fun show(context: Context?, message: String?): Dialog {
        return show(
            context,
            null,
            message,
            null,
            true,
            "OK",
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null
        )
    }

    fun show(context: Context?, title: String?, message: String?, confirmButton: String?): Dialog {
        return show(
            context,
            title,
            message,
            null,
            true,
            confirmButton,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null
        )
    }

    fun show(
        context: Context?,
        title: String?,
        message: String?,
        confirmButton: String?,
        cancelButton: String?,
        confirmListener: DialogInterface.OnClickListener?,
        cancelListener: DialogInterface.OnClickListener?
    ): Dialog {
        return show(
            context,
            title,
            message,
            null,
            true,
            confirmButton,
            confirmListener,
            null,
            null,
            cancelButton,
            cancelListener,
            null,
            null,
            null
        )
    }

    fun show(
        context: Context?,
        title: String?,
        message: String?,
        confirmButton: String?,
        confirmListener: DialogInterface.OnClickListener?,
        onCancelListener: DialogInterface.OnCancelListener?
    ): Dialog {
        return show(
            context,
            title,
            message,
            null,
            true,
            confirmButton,
            confirmListener,
            null,
            null,
            null,
            null,
            null,
            onCancelListener,
            null
        )
    }

    @JvmOverloads
    fun show(
        context: Context?,
        title: String?,
        message: String?,
        view: View? = null,
        cancelable: Boolean = true,
        confirmButton: String? = "OK",
        confirmListener: DialogInterface.OnClickListener? = null,
        centerButton: String? = null,
        centerListener: DialogInterface.OnClickListener? = null,
        cancelButton: String? = null,
        cancelListener: DialogInterface.OnClickListener? = null,
        onShowListener: DialogInterface.OnShowListener? = null,
        onCancelListener: DialogInterface.OnCancelListener? = null,
        onDismissListener: DialogInterface.OnDismissListener? = null
    ): Dialog {
        val builder = AlertDialog.Builder(context).setCancelable(cancelable)
        if (title != null) {
            builder.setTitle(title)
        }
        if (message != null) {
            builder.setMessage(message)
        }
        if (confirmButton != null) {
            builder.setPositiveButton(confirmButton, confirmListener)
        }
        if (centerButton != null) {
            builder.setNeutralButton(centerButton, centerListener)
        }
        if (cancelButton != null) {
            builder.setNegativeButton(cancelButton, cancelListener)
        }
        if (cancelable) {
            builder.setOnCancelListener(onCancelListener)
        }
        if (view != null) {
            builder.setView(view)
        }
        val alertDialog = builder.create()
        alertDialog.setOnShowListener(onShowListener)
        alertDialog.setOnDismissListener(onDismissListener)
        if (context !is Activity) {
            if (alertDialog.window != null) {
                alertDialog.window!!.setType(WindowManager.LayoutParams.TYPE_SYSTEM_ALERT)
            }
        }
        alertDialog.show()
        return alertDialog
    }

    fun hintKeyBoard(view: View?) {
        val imm =
            view!!.context.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        if (imm.isActive && view != null) {
            if (view.windowToken != null) {
                imm.hideSoftInputFromWindow(view.windowToken, InputMethodManager.HIDE_NOT_ALWAYS)
            }
        }
    }

    fun showKeyboard(v: View) {
        val imm = v.context.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        imm.toggleSoftInput(InputMethodManager.SHOW_IMPLICIT, InputMethodManager.HIDE_NOT_ALWAYS)
    }
//
//    private object Holder {
//        val instace: DialogUtils = DialogUtils()
//            get() = Holder.field
//    }
}