package `in`.gov.tn.aavin.aavinposfro.utils

import `in`.gov.tn.aavin.aavinposfro.R
import android.content.Context
import com.zcs.sdk.card.CardInfoEntity
import com.zcs.sdk.SdkResult
import androidx.annotation.StringRes
import java.lang.StringBuilder

/**
 * Created by yyzz on 2018/5/19.
 */
object SDK_Result {
    fun obtainCardInfo(context: Context?, vararg cardInfoEntitys: CardInfoEntity?): String {
        val stringBuilder = StringBuilder()
        for (entity in cardInfoEntitys) {
            stringBuilder.append(obtainCardInfo(context, entity)).append("\n")
        }
        return stringBuilder.toString()
    }

    fun obtainCardInfo(context: Context?, cardInfoEntity: CardInfoEntity?): String? {
        if (cardInfoEntity == null) return null
        val sb = StringBuilder()
        sb.append(
            """
    Resultcode:	${cardInfoEntity.resultcode}
    
    """.trimIndent()
        )
            .append(
                if (cardInfoEntity.cardExistslot == null) "" else """
     Card type:	${cardInfoEntity.cardExistslot.name}
     
     """.trimIndent()
            )
            .append(
                if (cardInfoEntity.cardNo == null) "" else """
     Card no:	${cardInfoEntity.cardNo}
     
     """.trimIndent()
            )
            .append(
                if (cardInfoEntity.rfCardType.toInt() == 0) "" else """
     Rf card type:	${cardInfoEntity.rfCardType}
     
     """.trimIndent()
            )
            .append(
                if (cardInfoEntity.rFuid == null) "" else """
     RFUid:	${String(cardInfoEntity.rFuid)}
     
     """.trimIndent()
            )
            .append(
                if (cardInfoEntity.atr == null) "" else """
     Atr:	${cardInfoEntity.atr}
     
     """.trimIndent()
            )
            .append(
                if (cardInfoEntity.tk1 == null) "" else """
     Track1:	${cardInfoEntity.tk1}
     
     """.trimIndent()
            )
            .append(
                if (cardInfoEntity.tk2 == null) "" else """
     Track2:	${cardInfoEntity.tk2}
     
     """.trimIndent()
            )
            .append(
                if (cardInfoEntity.tk3 == null) "" else """
     Track3:	${cardInfoEntity.tk3}
     
     """.trimIndent()
            )
            .append(
                if (cardInfoEntity.expiredDate == null) "" else """
     expiredDate:	${cardInfoEntity.expiredDate}
     
     """.trimIndent()
            )
            .append(if (cardInfoEntity.serviceCode == null) "" else "serviceCode:\t" + cardInfoEntity.serviceCode)
        return sb.toString()
    }

    fun obtainMsg(context: Context, resCode: Int): String? {
        var msg: String? = null
        msg = when (resCode) {
            SdkResult.SDK_ERROR -> appendMsg(
                context,
                resCode,
                R.string.SDK_ERROR
            )
            SdkResult.SDK_PARAMERR -> appendMsg(
                context,
                resCode,
                R.string.SDK_PARAMERR
            )
            SdkResult.SDK_TIMEOUT -> appendMsg(
                context,
                resCode,
                R.string.SDK_TIMEOUT
            )
            SdkResult.SDK_RECV_DATA_ERROR -> appendMsg(
                context,
                resCode,
                R.string.SDK_RECV_DATA_ERROR
            )
            SdkResult.SDK_ICC_BASE_ERR -> appendMsg(
                context,
                resCode,
                R.string.SDK_ICC_BASE_ERR
            )
            SdkResult.SDK_ICC_ERROR -> appendMsg(
                context,
                resCode,
                R.string.SDK_ICC_ERROR
            )
            SdkResult.SDK_ICC_PARAM_ERROR -> appendMsg(
                context,
                resCode,
                R.string.SDK_ICC_PARAM_ERROR
            )
            SdkResult.SDK_ICC_NO_CARD -> appendMsg(
                context,
                resCode,
                R.string.SDK_ICC_NO_CARD
            )
            SdkResult.SDK_ICC_NO_RESP -> appendMsg(
                context,
                resCode,
                R.string.SDK_ICC_NO_RESP
            )
            SdkResult.SDK_ICC_COMM_ERR -> appendMsg(
                context,
                resCode,
                R.string.SDK_ICC_COMM_ERR
            )
            SdkResult.SDK_ICC_RESP_ERR -> appendMsg(
                context,
                resCode,
                R.string.SDK_ICC_RESP_ERR
            )
            SdkResult.SDK_ICC_NO_POWER_ON -> appendMsg(
                context,
                resCode,
                R.string.SDK_ICC_NO_POWER_ON
            )
            SdkResult.SDK_RF_BASE_ERR -> appendMsg(
                context,
                resCode,
                R.string.SDK_RF_BASE_ERR
            )
            SdkResult.SDK_RF_ERROR -> appendMsg(
                context,
                resCode,
                R.string.SDK_RF_ERROR
            )
            SdkResult.SDK_RF_PARAM_ERROR -> appendMsg(
                context,
                resCode,
                R.string.SDK_RF_PARAM_ERROR
            )
            SdkResult.SDK_RF_ERR_NOCARD -> appendMsg(
                context,
                resCode,
                R.string.SDK_RF_ERR_NOCARD
            )
            SdkResult.SDK_RF_ERR_CARD_CONFLICT -> appendMsg(
                context,
                resCode,
                R.string.SDK_RF_ERR_CARD_CONFLICT
            )
            SdkResult.SDK_RF_TIME_OUT -> appendMsg(
                context,
                resCode,
                R.string.SDK_RF_TIME_OUT
            )
            SdkResult.SDK_RF_PROTOCOL_ERROR -> appendMsg(
                context,
                resCode,
                R.string.SDK_RF_PROTOCOL_ERROR
            )
            SdkResult.SDK_RF_TRANSMISSION_ERROR -> appendMsg(
                context,
                resCode,
                R.string.SDK_RF_TRANSMISSION_ERROR
            )
            SdkResult.SDK_MAG_BASE_ERR -> appendMsg(
                context,
                resCode,
                R.string.SDK_MAG_BASE_ERR
            )
            SdkResult.SDK_MAG_ERROR -> appendMsg(
                context,
                resCode,
                R.string.SDK_MAG_ERROR
            )
            SdkResult.SDK_MAG_PARAM_ERROR -> appendMsg(
                context,
                resCode,
                R.string.SDK_MAG_PARAM_ERROR
            )
            SdkResult.SDK_MAG_NO_BRUSH -> appendMsg(
                context,
                resCode,
                R.string.SDK_MAG_NO_BRUSH
            )
            SdkResult.SDK_PRN_BASE_ERR -> appendMsg(
                context,
                resCode,
                R.string.SDK_PRN_BASE_ERR
            )
            SdkResult.SDK_PRN_ERROR -> appendMsg(
                context,
                resCode,
                R.string.SDK_PRN_ERROR
            )
            SdkResult.SDK_PRN_PARAM_ERROR -> appendMsg(
                context,
                resCode,
                R.string.SDK_PRN_PARAM_ERROR
            )
            SdkResult.SDK_PRN_STATUS_PAPEROUT -> appendMsg(
                context,
                resCode,
                R.string.SDK_PRN_STATUS_PAPEROUT
            )
            SdkResult.SDK_PRN_STATUS_TOOHEAT -> appendMsg(
                context,
                resCode,
                R.string.SDK_PRN_STATUS_TOOHEAT
            )
            SdkResult.SDK_PRN_STATUS_FAULT -> appendMsg(
                context,
                resCode,
                R.string.SDK_PRN_STATUS_FAULT
            )
            SdkResult.SDK_PAD_BASE_ERR -> appendMsg(
                context,
                resCode,
                R.string.SDK_PAD_BASE_ERR
            )
            SdkResult.SDK_PAD_ERR_NOPIN -> appendMsg(
                context,
                resCode,
                R.string.SDK_PAD_ERR_NOPIN
            )
            SdkResult.SDK_PAD_ERR_CANCEL -> appendMsg(
                context,
                resCode,
                R.string.SDK_PAD_ERR_CANCEL
            )
            SdkResult.SDK_PAD_ERR_EXCEPTION -> appendMsg(
                context,
                resCode,
                R.string.SDK_PAD_ERR_EXCEPTION
            )
            SdkResult.SDK_PAD_ERR_TIMEOUT -> appendMsg(
                context,
                resCode,
                R.string.SDK_PAD_ERR_TIMEOUT
            )
            SdkResult.SDK_PAD_ERR_NEED_WAIT -> appendMsg(
                context,
                resCode,
                R.string.SDK_PAD_ERR_NEED_WAIT
            )
            SdkResult.SDK_PAD_ERR_DUPLI_KEY -> appendMsg(
                context,
                resCode,
                R.string.SDK_PAD_ERR_NEED_WAIT
            )
            SdkResult.SDK_PAD_ERR_INVALID_INDEX -> appendMsg(
                context,
                resCode,
                R.string.SDK_PAD_ERR_NEED_WAIT
            )
            SdkResult.SDK_PAD_ERR_NOTSET_KEY -> appendMsg(
                context,
                resCode,
                R.string.SDK_PAD_ERR_NEED_WAIT
            )
            else -> appendMsg(
                context,
                resCode,
                R.string.SDK_UNKNOWN_ERROR
            )
        }
        return msg
    }

    fun appendMsg(context: Context, code: Int, @StringRes id: Int): String {
        return appendMsg(code, context.getString(id))
    }

    fun appendMsg(code: Int, msg: String?): String {
        return appendMsg("Code", code.toString() + "", "Msg", msg!!)
    }

    fun appendMsg(vararg msg: String): String {
        val sb = StringBuilder()
        var i = 0
        while (i < msg.size) {
            if (i == msg.size - 2) {
                sb.append(append(msg[i], msg[i + 1]))
                i += 2
                continue
            }
            if (i == msg.size - 1) {
                sb.append(msg[i])
                i += 2
                continue
            }
            sb.append(append(msg[i], msg[i + 1]))
                .append("\n")
            i += 2
        }
        return sb.toString()
    }

    fun append(title: String, content: String): String {
        return "$title:\t$content"
    }
}