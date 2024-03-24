//package `in`.gov.tn.aavin.aavinposfro
//
//
//import `in`.gov.tn.aavin.aavinposfro.utils.DialogUtils
//import `in`.gov.tn.aavin.aavinposfro.utils.PermissionsManager
//import `in`.gov.tn.aavin.aavinposfro.utils.SDK_Result
//import android.Manifest
//import android.app.Activity
//import android.app.ProgressDialog
//import android.content.Intent
//import android.content.pm.PackageManager
//import android.content.res.AssetManager
//import android.graphics.drawable.BitmapDrawable
//import android.graphics.drawable.Drawable
//import android.net.Uri
//import android.os.Build
//import android.provider.Settings
//import android.text.Layout
//import android.util.Log
//import android.view.KeyEvent
//import android.widget.Toast
//import androidx.annotation.NonNull
//import androidx.annotation.RequiresApi
//import androidx.core.app.ActivityCompat
//import androidx.core.content.ContextCompat
//import androidx.multidex.BuildConfig
//import com.google.gson.Gson
//import com.google.gson.reflect.TypeToken
//import com.zcs.sdk.*
//import com.zcs.sdk.print.PrnStrFormat
//import com.zcs.sdk.print.PrnTextFont
//import com.zcs.sdk.print.PrnTextStyle
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel
//import java.io.IOException
//import java.io.InputStream
//import java.text.SimpleDateFormat
//import java.util.*
//
//
//class MainActivity : FlutterActivity() {
//    private val CHANNEL = "samples.flutter.dev/print"
//    private lateinit var mPrinter: Printer
//
//    private lateinit var mSys : Sys
//    private var mPermissionsManager: PermissionsManager? = null
//    private var mDialogInit: ProgressDialog? = null
//    private var mActivity: Activity? = null
//
//
//    private var args: String? = ""
//    private var total: String? = ""
//    private var address: String? = ""
//    private var cgst: String? = ""
//
//    private var sgst: String? = ""
//
//
//    private var paymentmethod: String? = ""
//    private var store_code: String? = ""
//
//    private var subtotal: String? = ""
//    private var igst: String? = ""
//    private var orderID: String? = ""
//
//    private var REQUEST_CODE_INITIALIZE = 10001
//    private val REQUEST_CODE_PREPARE = 10002
//    private val REQUEST_CODE_WALLET_TXN = 10003
//    private val REQUEST_CODE_CHEQUE_TXN = 10004
//    private val REQUEST_CODE_SALE_TXN = 10005
//    private val REQUEST_CODE_CASH_BACK_TXN = 10006
//    private val REQUEST_CODE_CASH_AT_POS_TXN = 10007
//    private val REQUEST_CODE_CASH_TXN = 10008
//    private val REQUEST_CODE_SEARCH = 10009
//    private val REQUEST_CODE_VOID = 10010
//    private val REQUEST_CODE_ATTACH_SIGN = 10011
//    private val REQUEST_CODE_UPDATE = 10012
//    private val REQUEST_CODE_CLOSE = 10013
//    private val REQUEST_CODE_GET_TXN_DETAIL = 10014
//    private val REQUEST_CODE_GET_INCOMPLETE_TXN = 10015
//    private val REQUEST_CODE_PAY = 10016
//    private val REQUEST_CODE_UPI = 10017
//    private val REQUEST_CODE_REMOTE_PAY = 10018
//    private val REQUEST_CODE_QR_CODE_PAY = 10019
//    private val REQUEST_CODE_NORMAL_EMI = 10020
//    private val REQUEST_CODE_BRAND_EMI = 10021
//    private val REQUEST_CODE_PRINT_RECEIPT = 10022
//    private val REQUEST_CODE_PRINT_BITMAP = 10023
//    private val REQUEST_CODE_SERVICE_REQUEST = 10024
//    private val REQUEST_CODE_STOP_PAYMENT = 10025
//    private val REQUEST_CODE_GET_TXN_DETAIL_WITHOUT_STOP = 10026
//
//    @RequiresApi(Build.VERSION_CODES.KITKAT)
//
//    private lateinit var results: MethodChannel.Result
//
//    @RequiresApi(Build.VERSION_CODES.KITKAT)
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//
//        mActivity = this
//        val mDriverManager = DriverManager.getInstance()
//        mPrinter = mDriverManager.printer
//        mSys = mDriverManager.baseSysDevice
//
//        if (checkPermission()) {
//            initSdk()
//        } else {
//            requestPermission()
//        }
//////          initSdk()
////        //  checkPermission()
//
//
////
////
////        // WebViewPlugin.registerWith(this.registrarFor("com.grocery.shopping"))
//        MethodChannel(
//            flutterEngine.dartExecutor.binaryMessenger,
//            CHANNEL
//        ).setMethodCallHandler { call, result ->
//            this.results = result
//            if (call.method == "print") {
//                args = call.argument("data")!! // .argument returns the correct type
//                total = call.argument("total")!!
//                address = call.argument("address")!!
//                cgst = call.argument("cgst")!!
//                sgst = call.argument("sgst")!!
//                igst = call.argument("igst")!!
//                orderID = call.argument("orderID")!!
//                subtotal = call.argument("subtotal")!!
//                store_code = call.argument("storecode")!!
//                paymentmethod = call.argument("paymentmethod")!!
//                val gson = Gson()
//                args = args!!.replace("\\\"", "'")
//                val productList = gson.fromJson<ArrayList<ProductModel>>(
//                    args!!.substring(1, args!!.length - 1),
//                    object : TypeToken<ArrayList<ProductModel>>() {}.type
//                )
//                printMatrixText(
//                    productList,
//                    total!!,
//                    address!!,
//                    store_code!!,
//                    orderID!!,
//                    paymentmethod!!,
//                    subtotal!!,
//                    cgst!!,
//                    sgst!!,
//                    igst!!
//                )
//            }
//        }
//    }
//
//
//
//   /* override fun onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?) {
//        super.onActivityResult(requestCode, resultCode, intent)
//        Log.d("SampleAppLogs", "requestCode = " + requestCode + "resultCode = " + resultCode)
//        try {
//            if (intent != null && intent.hasExtra("response")) {
//                Toast.makeText(this, intent.getStringExtra("response"), Toast.LENGTH_LONG).show()
////                Log.d("SampleAppLogs", intent.getStringExtra("response")!)
//            }
//            when (requestCode) {
//                REQUEST_CODE_UPI, REQUEST_CODE_CASH_TXN, REQUEST_CODE_CASH_BACK_TXN, REQUEST_CODE_CASH_AT_POS_TXN, REQUEST_CODE_WALLET_TXN, REQUEST_CODE_SALE_TXN -> if (resultCode == RESULT_OK) {
//                    var response = JSONObject(intent!!.getStringExtra("response"))
//                    response = response.getJSONObject("result")
//                    response = response.getJSONObject("txn")
//                    var strTxnId = response.getString("txnId")
//                    var emiID = response.getString("emiId")
//                    var gson = Gson()
//                    val productList = gson.fromJson<ArrayList<ProductModel>>(
//                        args!!.substring(
//                            1,
//                            args!!.length - 1
//                        ), object : TypeToken<ArrayList<ProductModel>>() {}.type
//                    )
//                    printMatrixText(
//                        productList,
//                        total!!,
//                        address!!,
//                        store_code!!,
//                        orderID!!,
//                        paymentmethod!!,
//                        subtotal!!,
//                        cgst!!,
//                        sgst!!,
//                        igst!!
//                    )
//                } else if (resultCode == RESULT_CANCELED) {
//                    var response = JSONObject(intent!!.getStringExtra("response"))
//                    response = response.getJSONObject("error")
//                    val errorCode = response.getString("code")
//                    val errorMessage = response.getString("message")
//                }
//                REQUEST_CODE_PREPARE -> if (resultCode == RESULT_OK) {
//                    var response = JSONObject(intent!!.getStringExtra("response"))
//                    response = response.getJSONObject("result")
//                } else if (resultCode == RESULT_CANCELED) {
//                    var response = JSONObject(intent!!.getStringExtra("response"))
//                    response = response.getJSONObject("error")
//                    val errorCode = response.getString("code")
//                    val errorMessage = response.getString("message")
//                }
//                REQUEST_CODE_INITIALIZE -> if (resultCode == RESULT_OK) {
//                    var response = JSONObject(intent!!.getStringExtra("response"))
//                    response = response.getJSONObject("result")
//                }
//            }
//        } catch (e: java.lang.Exception) {
//            e.printStackTrace()
//        }
//    }*/
//
//    @RequiresApi(Build.VERSION_CODES.KITKAT)
//    private fun printMatrixText(
//        productList: List<ProductModel>,
//        total: String,
//        address: String,
//        code: String,
//        orderID: String,
//        paymentmethod: String,
//        subtotal: String,
//        cgst: String,
//        sgst: String,
//        igst: String
//    ) {
//
//        Thread(Runnable {
//
//            val asm: AssetManager = assets
////            var inputStream: InputStream? = null
//            try {
//
//            } catch (e: IOException) {
//                e.printStackTrace()
//            }
////            val d = Drawable.createFromStream(inputStream, null)
//            var printStatus = mPrinter?.printerStatus
//            if (printStatus == SdkResult.SDK_PRN_STATUS_PAPEROUT) {
//                runOnUiThread(Runnable {
//                    DialogUtils.show(
//                        this,
//                        getString(R.string.printer_out_of_paper)
//                    )
//                })
//            } else {
////                val bitmap = (ContextCompat.getDrawable(mActivity as Context,R.drawable.aavin) as BitmapDrawable).bitmap
//                val asm = activity.assets
//                var inputStream: InputStream? = null
//                try {
//                    inputStream = asm.open("aavin.bmp")
//                } catch (e: IOException) {
//                    e.printStackTrace()
//                }
//                val d = Drawable.createFromStream(inputStream, null)
//                val bitmap = (d as BitmapDrawable).bitmap
//
//
//
//                mPrinter!!.setPrintAppendBitmap(
//                    bitmap,
//                    Layout.Alignment.ALIGN_CENTER
//                )
//
//                val format = PrnStrFormat()
//                format.textSize = 25
//                format.ali = Layout.Alignment.ALIGN_CENTER
//                format.style = PrnTextStyle.NORMAL
//                format.font = PrnTextFont.DEFAULT
//                format.ali = Layout.Alignment.ALIGN_NORMAL
//                mPrinter!!.setPrintAppendString(" ", format)
//
//
//                format.style
//                format.textSize = 20
//                format.font = PrnTextFont.MONOSPACE
//                format.ali = Layout.Alignment.ALIGN_CENTER
//                mPrinter!!.setPrintAppendString(address, format)
//
//
////                mPrinter!!.setPrintAppendString(" ", format)
//
//                format.textSize = 20
//                format.font = PrnTextFont.MONOSPACE
//                format.ali = Layout.Alignment.ALIGN_CENTER
//                mPrinter!!.setPrintAppendString("Store : " + code, format)
//                mPrinter!!.setPrintAppendString("Order :# " + orderID, format)
//
//
//
//                val sdf = SimpleDateFormat("dd/MM/yyyy")
//                val timef = SimpleDateFormat("hh:mm a")
//                val currentDate = sdf.format(Date())
//                val currentTime = timef.format(Date())
//                var dateTxt = "Date: " + currentDate
//                var currentTimeTxt = "Time: " + currentTime
//                var text =
//                    dateTxt + getSpace(35 - (dateTxt.length + currentTimeTxt.length)) + currentTimeTxt
//                format.textSize = 18
//                format.font = PrnTextFont.DEFAULT_BOLD
//                mPrinter!!.setPrintAppendString(text, format)
//                mPrinter!!.setPrintAppendString(" ", format)
//
//                format.textSize = 18
//                format.font = PrnTextFont.DEFAULT_BOLD
//                format.ali = Layout.Alignment.ALIGN_NORMAL
//
//
//                var paymentMethod = ""
//                paymentMethod = if (paymentmethod == "1") {
//                    "Payment Mode: Cash"
//                } else {
//                    ""
//                }
//                paymentMethod = if (paymentmethod == "2") {
//                    "Payment Mode: Card"
//                } else {
//                    ""
//                }
//                paymentMethod = if (paymentmethod == "3") {
//                    "Payment Mode: UPI"
//                } else {
//                    ""
//                }
//                paymentMethod = if (paymentmethod == "4") {
//                    "Payment Mode: Dunzo"
//                } else {
//                    ""
//                }
//
//
//                mPrinter!!.setPrintAppendString(paymentMethod, format)
//
//
//                format.textSize = 20
//                format.font = PrnTextFont.MONOSPACE
//                format.ali = Layout.Alignment.ALIGN_NORMAL
//                mPrinter!!.setPrintAppendString("----------------------------------", format)
////                mPrinter!!.setPrintAppendString(
////                       "Qty Product           Price",
////                        format)
//                val left = "Qty" + getSpace(2) + "Product" + getSpace(15) + " " + "Price"
//                mPrinter!!.setPrintAppendString(left.toString(), format)
//                //Print("Qty  ", "Product", "Price", mPrinter!!, format);
//
//                // mPrinter!!.setPrintAppendString(" ", format)
//                format.textSize = 20
//                format.font = PrnTextFont.MONOSPACE
//                format.ali = Layout.Alignment.ALIGN_NORMAL
//                mPrinter!!.setPrintAppendString("----------------------------------", format)
//                productList.forEach {
//                    // var productname=it.Product_Name;
//                    var qty = ""
//                    qty = if (it.No_Of_Items.toString().length <= 1) {
//                        val qnty = it.No_Of_Items.toString().length + 1
//
//                        //   Log.d("spacea", qnty.toString());
//                        " " + it.No_Of_Items.toString() + getSpace(5 - qnty)
//                    } else {
//                        Log.d(
//                            "space>3",
//                            it.No_Of_Items.toString() + getSpace(5 - it.No_Of_Items.toString().length).toString()
//                        )
//                        //    var qnty = it.no_Of_Order.toString().length + 1;
//
//                        // Log.d("space", (it.no_Of_Order.toString().length).toString());
//                        it.No_Of_Items.toString() + getSpace(5 - it.No_Of_Items.toString().length)
//                    }
//                    Print(
//                        qty,
//                        ((it.Product_Name.toLowerCase()).capitalizeWords()).trim() + "  " + getSpace(
//                            5
//                        ),
//                        (" ₹ " + (String.format(
//                            "%.2f",
//                            (it.Product_Price * it.No_Of_Items)
//                        ))).trim() + getSpace(8),
//                        mPrinter!!,
//                        format
//                    )
//                }
//
//                mPrinter!!.setPrintAppendString("----------------------------------", format)
//                format.ali = Layout.Alignment.ALIGN_NORMAL
//                paymentDetails("Sub Total", "₹ $subtotal", mPrinter!!, format)
//                paymentDetails("CGST ", "₹ $cgst", mPrinter!!, format)
//                paymentDetails("SGST ", "₹ $sgst", mPrinter!!, format)
//                paymentDetails("Total ", "₹ $total", mPrinter!!, format)
//
//
//                format.ali = Layout.Alignment.ALIGN_CENTER
//                mPrinter!!.setPrintAppendString(" ", format)
//
//
//                mPrinter!!.setPrintAppendString("----------------------------------", format)
//                format.ali = Layout.Alignment.ALIGN_CENTER
//                mPrinter!!.setPrintAppendString("Thank You !!", format)
//                mPrinter!!.setPrintAppendString("Welcome Again !!", format)
//                mPrinter!!.setPrintAppendString(" ", format)
//
//
//                mPrinter!!.setPrintAppendQRCode(
//                    "0002010102110827YESB0CMSNOC222333004882700126350010A0000005240117razorpaybqr@icici27350010A0000005240117RZPHLgPEz0zYu6hCf5204939953033565802IN5905TCMPF6007Chennai610660003562180514HLgPEz0zYu6hCf630464FE",
//                    350,
//                    350,
//                    Layout.Alignment.ALIGN_CENTER
//                )
//                mPrinter!!.setPrintAppendString(" ", format)
//                mPrinter!!.setPrintAppendString(" ", format)
//                mPrinter!!.setPrintAppendString(" ", format)
//                mPrinter!!.setPrintAppendString(" ", format)
//
//
////                mPrinter!!.addSymbol
//                printStatus = mPrinter!!.setPrintStart()
//
//                if (printStatus == SdkResult.SDK_PRN_STATUS_PAPEROUT) {
//                    runOnUiThread(Runnable {
//                        DialogUtils.show(
//                            this,
//                            getString(R.string.printer_out_of_paper)
//                        )
//                    })
//                } else if (printStatus == SdkResult.SDK_OK) {
//                    runOnUiThread(Runnable {
//                        results.success(true)
//
//                    })
//                }
//            }
//        }).run()
//
//    }
//
//    fun Double.roundTo(n: Int): Double {
//        return "%.${n}f".format(this).toDouble()
//    }
//
//    fun initSdk() {
//        initSdk(true)
//    }
//
//
//    var speed = 460800
//    var count = 0
//
//    private fun initSdk(reset: Boolean) {
//        if (mDialogInit == null && window.decorView.isShown) {
//
//            mDialogInit = DialogUtils.showProgress(
//                this,
//                "Waiting",
//                "Initialize"
//            )
//        } else if (mDialogInit != null && mDialogInit!!.isShowing) {
//            mDialogInit!!.show()
//        }
//        Thread(Runnable {
//            val statue = mSys?.getFirmwareVer(arrayOfNulls<String>(1))
//            if (statue != SdkResult.SDK_OK) {
//                val sysPowerOn = mSys?.sysPowerOn()
//                Log.i(
//                    "POS",
//                    "sysPowerOn: $sysPowerOn"
//                )
//                try {
//                    Thread.sleep(1000)
//                } catch (e: InterruptedException) {
//                    e.printStackTrace()
//                }
//            }
//            mSys?.setUartSpeed(speed)
//            val i = mSys?.sdkInit()
////            if (i == SdkResult.SDK_OK) {
////                setDeviceInfo()
////            }
//            if (reset && ++count < 2 && i == SdkResult.SDK_OK && mSys?.curSpeed != 460800) {
//                Log.d(
//                    "tag",
//                    "switch baud rate, cur speed = " + mSys?.curSpeed
//                )
//                val ret = mSys?.setDeviceBaudRate()
//                if (ret != SdkResult.SDK_OK) {
//                    DialogUtils.show(this, "SwitchBaudRate error: $ret")
//                }
//                mSys?.sysPowerOff()
//                initSdk()
//                return@Runnable
//            }
//            runOnUiThread {
//                if (mDialogInit != null) mDialogInit!!.dismiss()
//
//                if (BuildConfig.DEBUG && Sys.getConnectType() == ConnectTypeEnum.COM) {
//                    DialogUtils.show(this, "Cur speed: " + mSys?.curSpeed)
//                }
//                val initRes =
//                    if (i == SdkResult.SDK_OK) getString(R.string.init_success) else SDK_Result.obtainMsg(
//                        mActivity!!,
//                        i!!
//                    )
//                Toast.makeText(this, initRes, Toast.LENGTH_SHORT).show()
//            }
//        }).start()
//    }
//
//    fun writePrint(align: ByteArray?, msg: String): String {
//        var msg = msg
//        try {
//            //   mmOutputStream.write(align)
//            var space = "   "
//            val l = msg.length
//            if (l < 41) {
//                for (x in 41 - l downTo 0) {
//                    space = "$space "
//                }
//            }
//            msg = msg.replace(" : ", space)
//
//            //mmOutputStream.write(msg.toByteArray())
//        } catch (e: IOException) {
//            e.printStackTrace()
//        }
//        return msg
//    }
//
//    fun checkPermission(): Boolean {
//        var write = 0
//        var read = 0
//        var camera = 0
//        var phone = 0
//        write = ContextCompat.checkSelfPermission(
//            this,
//            Manifest.permission.WRITE_EXTERNAL_STORAGE
//        )
//        read = ContextCompat.checkSelfPermission(
//            this,
//            Manifest.permission.READ_EXTERNAL_STORAGE
//        )
//        camera = ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA)
//        phone = ContextCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE)
//        return write == PackageManager.PERMISSION_GRANTED && phone == PackageManager.PERMISSION_GRANTED && read == PackageManager.PERMISSION_GRANTED && camera == PackageManager.PERMISSION_GRANTED
//    }
//
//    private fun requestPermission() {
//        ActivityCompat.requestPermissions(
//            this,
//            arrayOf(
//                Manifest.permission.WRITE_EXTERNAL_STORAGE,
//                Manifest.permission.READ_EXTERNAL_STORAGE,
//                Manifest.permission.CAMERA,
//                Manifest.permission.READ_PHONE_STATE
//            ),
//            11
//        )
//    }
//
//    override fun onRequestPermissionsResult(
//        requestCode: Int,
//        permissions: Array<String?>,
//        grantResults: IntArray
//    ) {
//        try {
//            if (requestCode == 11) {
//                if (grantResults.size > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED && grantResults[1] == PackageManager.PERMISSION_GRANTED && grantResults[2] == PackageManager.PERMISSION_GRANTED && grantResults[3] == PackageManager.PERMISSION_GRANTED
//                ) {
//
//                    initSdk()
//                } else if (Build.VERSION.SDK_INT >= 23 && !shouldShowRequestPermissionRationale(
//                        permissions[0]!!
//                    )
//                ) {
//                    //  Toast.makeText(MainActivity.this, "Go to Settings and Grant the permission to use this feature.", Toast.LENGTH_SHORT).show();
//                    // User selected the Never Ask Again Option
//                    val i = Intent()
//                    i.action = Settings.ACTION_APPLICATION_DETAILS_SETTINGS
//                    i.addCategory(Intent.CATEGORY_DEFAULT)
//                    i.data = Uri.parse("package:$packageName")
//                    i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
//                    i.addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY)
//                    i.addFlags(Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS)
//                    startActivity(i)
//                    Toast.makeText(
//                        mActivity,
//                        getString(R.string.enable_permission),
//                        Toast.LENGTH_SHORT
//                    ).show()
//                } else {
//                    Toast.makeText(
//                        mActivity,
//                        getString(R.string.permission_denied),
//                        Toast.LENGTH_SHORT
//                    ).show()
//                }
//            }
//        } catch (ex: java.lang.Exception) {
//            //Logger.log(Constants.TAG, ex.message)
//        }
//    }
//
//    fun String.capitalizeWords(): String = split(" ").map { it.capitalize() }.joinToString(" ")
//
//    var barcode = ""
//    override fun dispatchKeyEvent(e: KeyEvent): Boolean {
//        if (e.action == KeyEvent.ACTION_DOWN) {
//            //printM
//            Log.i("TAG", "dispatchKeyEvent: $e")
//            val pressedKey = e.unicodeChar.toChar()
//            barcode += pressedKey
//        }
//        if (e.action == KeyEvent.ACTION_DOWN && e.keyCode == KeyEvent.KEYCODE_ENTER) {
//            Toast.makeText(
//                applicationContext,
//                "barcode--->>>$barcode", Toast.LENGTH_LONG
//            )
//                .show()
//            //
//            barcode = ""
//            return true
//        }
//        return super.dispatchKeyEvent(e)
//    }
//
//    @RequiresApi(Build.VERSION_CODES.KITKAT)
//    fun Print(
//        qnty: String,
//        product: String,
//        price: String,
//        epsonPrinter: Printer,
//        format: PrnStrFormat
//    ) {
//
//
//        var stringLength = 35
//        //var qntyDefaultLen = 5
//        var priceDefaultLen = 9
//        //  var totalString = ""
//
//        var qntylength = qnty.length
//        // var qntyNumString = qnty + getSpace((qntyDefaultLen - qntylength))
//        var qntyNumString = qnty
//
//        var priceString = getSpace((priceDefaultLen - price.length)) + price
//
//        Log.d(priceString, priceString.length.toString())
//        var remainingStringLength = 0
//
//
//
//        if (product.length > 22) {
//            if (qnty.length == 6) {
//                remainingStringLength = 20
//            } else if (qnty.length == 7) {
//                remainingStringLength = 19
//            } else {
//                remainingStringLength = 21
//            }
////            if (price.length>=11){
////                remainingStringLength = 21;
////            }else if(price.length>=10){
////                remainingStringLength = 21;
////            }else{
////                remainingStringLength = 21;
////            }
//
//
//        } else {
//            remainingStringLength = stringLength - qntyNumString.length - priceString.length
//        }
//
//        var splitString = splitEqually(product, remainingStringLength)
//
//        val stringBuilder = StringBuilder()
//        stringBuilder.append(qntyNumString)
//        if (splitString!!.size > 1) {
//            splitString.forEachIndexed { index, s ->
//
//                if (index > 0) {
//                    stringBuilder.append(getSpace(qntyNumString.length))
//                    //  Toast.makeText(this, qntyNumString.length.toString(), Toast.LENGTH_LONG).show()
//                }
//                stringBuilder.append(s + " ")
//                if (index == 0) {
//                    var spacelength = remainingStringLength - splitString[0]!!.length
//                    Log.d("split len", splitString[0]!!.length.toString())
//                    Log.d("price len", priceString.length.toString())
//                    Log.d("qty len", qntyNumString.length.toString())
//                    Log.d("space", spacelength.toString())
//                    stringBuilder.append(getSpace(spacelength) + priceString)
//                }
//                stringBuilder.append(System.getProperty("line.separator"))
//            }
//
//        } else {
//            var spacelength = remainingStringLength - splitString[0]!!.length
//            Log.d("split len", splitString[0]!!.length.toString())
//            Log.d("price len", priceString.length.toString())
//            Log.d("qty len", qntyNumString.length.toString())
//            Log.d("space", spacelength.toString())
//            stringBuilder.append(splitString[0])
//            stringBuilder.append(getSpace(spacelength) + priceString)
//        }
//
//
//        epsonPrinter.setPrintAppendString(stringBuilder.toString(), format)
//        //  printMe!!.addBreak(1);
//        //  epsonPrinter!!.setPrintAppendString(stringBuilder.toString(), format)
//    }
//
//
//
//
//    fun paymentDetails(name: String, amount: String, epsonPrinter: Printer, format: PrnStrFormat) {
//        val stringBuilder = StringBuilder()
//        stringBuilder.append(name)
//        stringBuilder.append(getSpace(35 - (name.length + amount.length)))
//        stringBuilder.append(amount)
//        epsonPrinter.setPrintAppendString(stringBuilder.toString(), format)
//    }
//
//    fun getSpace(space: Int): String {
//        var spacestr = ""
//        if (space > 0) {
//            for (i in 0 until space) {
//                spacestr = "$spacestr "
//            }
//        }
//        return spacestr
//
//    }
//
//    fun splitEqually(text: String, size: Int): List<String?>? {
//        // Give the list the right capacity to start with. You could use an array
//        // instead if you wanted.
//        var ret: List<String>? = null
//        ret = ArrayList((text.length + size - 1) / size)
//        var start = 0
//        while (start < text.length) {
//            //ret.add
//            ret.add(text.substring(start, Math.min(text.length, start + size)))
//            start += size
//        }
//        return ret
//    }
//
//}
package `in`.gov.tn.aavin.aavinposfro


import `in`.gov.tn.aavin.aavinposfro.utils.DialogUtils
import `in`.gov.tn.aavin.aavinposfro.utils.PermissionsManager
import `in`.gov.tn.aavin.aavinposfro.utils.SDK_Result
import android.Manifest
import android.app.Activity
import android.app.ProgressDialog
import android.content.Intent
import android.content.pm.PackageManager
import android.content.res.AssetManager
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.text.Layout
import android.util.Log
import android.view.KeyEvent
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.multidex.BuildConfig
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.zcs.sdk.*
import com.zcs.sdk.print.PrnStrFormat
import com.zcs.sdk.print.PrnTextFont
import com.zcs.sdk.print.PrnTextStyle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.IOException
import java.io.InputStream
import java.text.SimpleDateFormat
import java.util.*


class MainActivity : FlutterActivity() {
    private val CHANNEL = "samples.flutter.dev/print"
    private lateinit var mPrinter: Printer

    private lateinit var mSys : Sys
    private var mPermissionsManager: PermissionsManager? = null
    private var mDialogInit: ProgressDialog? = null
    private var mActivity: Activity? = null


    private var args: String? = ""
    private var total: String? = ""
    private var address: String? = ""
    private var cgst: String? = ""

    private var sgst: String? = ""


    private var paymentmethod: String? = ""
    private var store_code: String? = ""

    private var subtotal: String? = ""
    private var igst: String? = ""
    private var orderID: String? = ""

    private var REQUEST_CODE_INITIALIZE = 10001
    private val REQUEST_CODE_PREPARE = 10002
    private val REQUEST_CODE_WALLET_TXN = 10003
    private val REQUEST_CODE_CHEQUE_TXN = 10004
    private val REQUEST_CODE_SALE_TXN = 10005
    private val REQUEST_CODE_CASH_BACK_TXN = 10006
    private val REQUEST_CODE_CASH_AT_POS_TXN = 10007
    private val REQUEST_CODE_CASH_TXN = 10008
    private val REQUEST_CODE_SEARCH = 10009
    private val REQUEST_CODE_VOID = 10010
    private val REQUEST_CODE_ATTACH_SIGN = 10011
    private val REQUEST_CODE_UPDATE = 10012
    private val REQUEST_CODE_CLOSE = 10013
    private val REQUEST_CODE_GET_TXN_DETAIL = 10014
    private val REQUEST_CODE_GET_INCOMPLETE_TXN = 10015
    private val REQUEST_CODE_PAY = 10016
    private val REQUEST_CODE_UPI = 10017
    private val REQUEST_CODE_REMOTE_PAY = 10018
    private val REQUEST_CODE_QR_CODE_PAY = 10019
    private val REQUEST_CODE_NORMAL_EMI = 10020
    private val REQUEST_CODE_BRAND_EMI = 10021
    private val REQUEST_CODE_PRINT_RECEIPT = 10022
    private val REQUEST_CODE_PRINT_BITMAP = 10023
    private val REQUEST_CODE_SERVICE_REQUEST = 10024
    private val REQUEST_CODE_STOP_PAYMENT = 10025
    private val REQUEST_CODE_GET_TXN_DETAIL_WITHOUT_STOP = 10026

    @RequiresApi(Build.VERSION_CODES.KITKAT)

    private lateinit var results: MethodChannel.Result

    @RequiresApi(Build.VERSION_CODES.KITKAT)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        mActivity = this
        val mDriverManager = DriverManager.getInstance()
        mPrinter = mDriverManager.printer
        mSys = mDriverManager.baseSysDevice

        if (checkPermission()) {
            initSdk()
        } else {
            requestPermission()
        }
////          initSdk()
//        //  checkPermission()


//
//
//        // WebViewPlugin.registerWith(this.registrarFor("com.grocery.shopping"))
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            this.results = result
            if (call.method == "print") {
                args = call.argument("data")!! // .argument returns the correct type
                total = call.argument("total")!!
                address = call.argument("address")!!
                cgst = call.argument("cgst")!!
                sgst = call.argument("sgst")!!
                igst = call.argument("igst")!!
                orderID = call.argument("orderID")!!
                subtotal = call.argument("subtotal")!!
                store_code = call.argument("storecode")!!
                paymentmethod = call.argument("paymentmethod")!!
                val gson = Gson()
                args = args!!.replace("\\\"", "'")
                val productList = gson.fromJson<ArrayList<ProductModel>>(
                    args!!.substring(1, args!!.length - 1),
                    object : TypeToken<ArrayList<ProductModel>>() {}.type
                )
                printMatrixText(
                    productList,
                    total!!,
                    address!!,
                    store_code!!,
                    orderID!!,
                    paymentmethod!!,
                    subtotal!!,
                    cgst!!,
                    sgst!!,
                    igst!!
                )
            }
        }
    }



    /* override fun onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?) {
         super.onActivityResult(requestCode, resultCode, intent)
         Log.d("SampleAppLogs", "requestCode = " + requestCode + "resultCode = " + resultCode)
         try {
             if (intent != null && intent.hasExtra("response")) {
                 Toast.makeText(this, intent.getStringExtra("response"), Toast.LENGTH_LONG).show()
 //                Log.d("SampleAppLogs", intent.getStringExtra("response")!)
             }
             when (requestCode) {
                 REQUEST_CODE_UPI, REQUEST_CODE_CASH_TXN, REQUEST_CODE_CASH_BACK_TXN, REQUEST_CODE_CASH_AT_POS_TXN, REQUEST_CODE_WALLET_TXN, REQUEST_CODE_SALE_TXN -> if (resultCode == RESULT_OK) {
                     var response = JSONObject(intent!!.getStringExtra("response"))
                     response = response.getJSONObject("result")
                     response = response.getJSONObject("txn")
                     var strTxnId = response.getString("txnId")
                     var emiID = response.getString("emiId")
                     var gson = Gson()
                     val productList = gson.fromJson<ArrayList<ProductModel>>(
                         args!!.substring(
                             1,
                             args!!.length - 1
                         ), object : TypeToken<ArrayList<ProductModel>>() {}.type
                     )
                     printMatrixText(
                         productList,
                         total!!,
                         address!!,
                         store_code!!,
                         orderID!!,
                         paymentmethod!!,
                         subtotal!!,
                         cgst!!,
                         sgst!!,
                         igst!!
                     )
                 } else if (resultCode == RESULT_CANCELED) {
                     var response = JSONObject(intent!!.getStringExtra("response"))
                     response = response.getJSONObject("error")
                     val errorCode = response.getString("code")
                     val errorMessage = response.getString("message")
                 }
                 REQUEST_CODE_PREPARE -> if (resultCode == RESULT_OK) {
                     var response = JSONObject(intent!!.getStringExtra("response"))
                     response = response.getJSONObject("result")
                 } else if (resultCode == RESULT_CANCELED) {
                     var response = JSONObject(intent!!.getStringExtra("response"))
                     response = response.getJSONObject("error")
                     val errorCode = response.getString("code")
                     val errorMessage = response.getString("message")
                 }
                 REQUEST_CODE_INITIALIZE -> if (resultCode == RESULT_OK) {
                     var response = JSONObject(intent!!.getStringExtra("response"))
                     response = response.getJSONObject("result")
                 }
             }
         } catch (e: java.lang.Exception) {
             e.printStackTrace()
         }
     }*/

    @RequiresApi(Build.VERSION_CODES.KITKAT)
    private fun printMatrixText(
        productList: List<ProductModel>,
        total: String,
        address: String,
        code: String,
        orderID: String,
        paymentmethod: String,
        subtotal: String,
        cgst: String,
        sgst: String,
        igst: String
    ) {

        Thread(Runnable {

            val asm: AssetManager = assets
//            var inputStream: InputStream? = null
            try {

            } catch (e: IOException) {
                e.printStackTrace()
            }
//            val d = Drawable.createFromStream(inputStream, null)
            var printStatus = mPrinter?.printerStatus
            if (printStatus == SdkResult.SDK_PRN_STATUS_PAPEROUT) {
                runOnUiThread(Runnable {
                    DialogUtils.show(
                        this,
                        getString(R.string.printer_out_of_paper)
                    )
                })
            } else {
//                val bitmap = (ContextCompat.getDrawable(mActivity as Context,R.drawable.aavin) as BitmapDrawable).bitmap
                val asm = activity.assets
                var inputStream: InputStream? = null
                try {
                    inputStream = asm.open("aavin.bmp")
                } catch (e: IOException) {
                    e.printStackTrace()
                }
                val d = Drawable.createFromStream(inputStream, null)
                val bitmap = (d as BitmapDrawable).bitmap



                mPrinter!!.setPrintAppendBitmap(
                    bitmap,
                    Layout.Alignment.ALIGN_CENTER
                )

                val format = PrnStrFormat()
                format.textSize = 25
                format.ali = Layout.Alignment.ALIGN_CENTER
                format.style = PrnTextStyle.NORMAL
                format.font = PrnTextFont.DEFAULT
                format.ali = Layout.Alignment.ALIGN_NORMAL
                mPrinter!!.setPrintAppendString(" ", format)


                format.style
                format.textSize = 20
                format.font = PrnTextFont.MONOSPACE
                format.ali = Layout.Alignment.ALIGN_CENTER
                mPrinter!!.setPrintAppendString(address, format)


//                mPrinter!!.setPrintAppendString(" ", format)

                format.textSize = 20
                format.font = PrnTextFont.MONOSPACE
                format.ali = Layout.Alignment.ALIGN_CENTER
                mPrinter!!.setPrintAppendString("Store : " + code, format)
                mPrinter!!.setPrintAppendString("Order :# " + orderID, format)



                val sdf = SimpleDateFormat("dd/MM/yyyy")
                val timef = SimpleDateFormat("hh:mm a")
                val currentDate = sdf.format(Date())
                val currentTime = timef.format(Date())
                var dateTxt = "Date: " + currentDate
                var currentTimeTxt = "Time: " + currentTime
                var text =
                    dateTxt + getSpace(35 - (dateTxt.length + currentTimeTxt.length)) + currentTimeTxt
                format.textSize = 18
                format.font = PrnTextFont.DEFAULT_BOLD
                mPrinter!!.setPrintAppendString(text, format)
                mPrinter!!.setPrintAppendString(" ", format)

                format.textSize = 18
                format.font = PrnTextFont.DEFAULT_BOLD
                format.ali = Layout.Alignment.ALIGN_NORMAL


                var paymentMethod = ""
                paymentMethod = if (paymentmethod == "1") {
                    "Payment Mode: Cash"
                } else {
                    ""
                }
                paymentMethod = if (paymentmethod == "2") {
                    "Payment Mode: Card"
                } else {
                    ""
                }
                paymentMethod = if (paymentmethod == "3") {
                    "Payment Mode: UPI"
                } else {
                    ""
                }
                paymentMethod = if (paymentmethod == "4") {
                    "Payment Mode: ThirdParty"
                } else {
                    ""
                }


                mPrinter!!.setPrintAppendString(paymentMethod, format)
                format.textSize = 20
                format.font = PrnTextFont.MONOSPACE
                format.ali = Layout.Alignment.ALIGN_NORMAL
                mPrinter!!.setPrintAppendString("----------------------------------", format)
//                mPrinter!!.setPrintAppendString(
//                       "Qty Product           Price",
//                        format)
                val left = "Qty" + getSpace(2) + "Product" + getSpace(15) + " " + "Price"
                mPrinter!!.setPrintAppendString(left.toString(), format)
                //Print("Qty  ", "Product", "Price", mPrinter!!, format);

                // mPrinter!!.setPrintAppendString(" ", format)
                format.textSize = 20
                format.font = PrnTextFont.MONOSPACE
                format.ali = Layout.Alignment.ALIGN_NORMAL
                mPrinter!!.setPrintAppendString("----------------------------------", format)
                productList.forEach {
                    // var productname=it.Product_Name;
                    var qty = ""
                    qty = if (it.No_Of_Items.toString().length <= 1) {
                        val qnty = it.No_Of_Items.toString().length + 1

                        //   Log.d("spacea", qnty.toString());
                        " " + it.No_Of_Items.toString() + getSpace(4 - qnty)
                    } else {
                        Log.d(
                            "space>3",
                            it.No_Of_Items.toString() + getSpace(4 - it.No_Of_Items.toString().length).toString()
                        )
                        //    var qnty = it.no_Of_Order.toString().length + 1;

                        // Log.d("space", (it.no_Of_Order.toString().length).toString());
                        it.No_Of_Items.toString() + getSpace(4 - it.No_Of_Items.toString().length)
                    }
                    Print(
                        qty,
                        ((it.Product_Name.toLowerCase()).capitalizeWords()).trim() + "  " + getSpace(
                            4
                        ),
                        (" ₹ " + (String.format(
                            "%.2f",
                            (it.Product_Price * it.No_Of_Items)
                        ))).trim() + getSpace(7),
                        mPrinter!!,
                        format
                    )
                }

                mPrinter!!.setPrintAppendString("----------------------------------", format)
                format.ali = Layout.Alignment.ALIGN_NORMAL
                paymentDetails("Sub Total", "₹ $subtotal", mPrinter!!, format)
                paymentDetails("CGST ", "₹ $cgst", mPrinter!!, format)
                paymentDetails("SGST ", "₹ $sgst", mPrinter!!, format)
                paymentDetails("Total ", "₹ $total", mPrinter!!, format)


                format.ali = Layout.Alignment.ALIGN_CENTER
//                mPrinter!!.setPrintAppendString(" ", format)
                mPrinter!!.setPrintAppendString("----------------------------------", format)
                format.ali = Layout.Alignment.ALIGN_CENTER
                mPrinter!!.setPrintAppendString("Thank You !!", format)
                mPrinter!!.setPrintAppendString("Welcome Again !!", format)
//                mPrinter!!.setPrintAppendString(" ", format)


//                mPrinter!!.setPrintAppendQRCode(
//                    "0002010102110827YESB0CMSNOC222333004882700126350010A0000005240117razorpaybqr@icici27350010A0000005240117RZPHLgPEz0zYu6hCf5204939953033565802IN5905TCMPF6007Chennai610660003562180514HLgPEz0zYu6hCf630464FE",
//                    250,
//                    250,
//                    Layout.Alignment.ALIGN_CENTER
//                )
                mPrinter!!.setPrintAppendString(" ", format)
                mPrinter!!.setPrintAppendString(" ", format)
//                mPrinter!!.setPrintAppendString(" ", format)
//                mPrinter!!.setPrintAppendString(" ", format)


//                mPrinter!!.addSymbol
                printStatus = mPrinter!!.setPrintStart()

                if (printStatus == SdkResult.SDK_PRN_STATUS_PAPEROUT) {
                    runOnUiThread(Runnable {
                        DialogUtils.show(
                            this,
                            getString(R.string.printer_out_of_paper)
                        )
                    })
                } else if (printStatus == SdkResult.SDK_OK) {
                    runOnUiThread(Runnable {
                        results.success(true)

                    })
                }
            }
        }).run()

    }

    fun Double.roundTo(n: Int): Double {
        return "%.${n}f".format(this).toDouble()
    }

    fun initSdk() {
        initSdk(true)
    }


    var speed = 460800
    var count = 0

    private fun initSdk(reset: Boolean) {
        if (mDialogInit == null && window.decorView.isShown) {

            mDialogInit = DialogUtils.showProgress(
                this,
                "Waiting",
                "Initialize"
            )
        } else if (mDialogInit != null && mDialogInit!!.isShowing) {
            mDialogInit!!.show()
        }
        Thread(Runnable {
            val statue = mSys?.getFirmwareVer(arrayOfNulls<String>(1))
            if (statue != SdkResult.SDK_OK) {
                val sysPowerOn = mSys?.sysPowerOn()
                Log.i(
                    "POS",
                    "sysPowerOn: $sysPowerOn"
                )
                try {
                    Thread.sleep(1000)
                } catch (e: InterruptedException) {
                    e.printStackTrace()
                }
            }
            mSys?.setUartSpeed(speed)
            val i = mSys?.sdkInit()
//            if (i == SdkResult.SDK_OK) {
//                setDeviceInfo()
//            }
            if (reset && ++count < 2 && i == SdkResult.SDK_OK && mSys?.curSpeed != 460800) {
                Log.d(
                    "tag",
                    "switch baud rate, cur speed = " + mSys?.curSpeed
                )
                val ret = mSys?.setDeviceBaudRate()
                if (ret != SdkResult.SDK_OK) {
                    DialogUtils.show(this, "SwitchBaudRate error: $ret")
                }
                mSys?.sysPowerOff()
                initSdk()
                return@Runnable
            }
            runOnUiThread {
                if (mDialogInit != null) mDialogInit!!.dismiss()

                if (BuildConfig.DEBUG && Sys.getConnectType() == ConnectTypeEnum.COM) {
                    DialogUtils.show(this, "Cur speed: " + mSys?.curSpeed)
                }
                val initRes =
                    if (i == SdkResult.SDK_OK) getString(R.string.init_success) else SDK_Result.obtainMsg(
                        mActivity!!,
                        i!!
                    )
                Toast.makeText(this, initRes, Toast.LENGTH_SHORT).show()
            }
        }).start()
    }

    fun writePrint(align: ByteArray?, msg: String): String {
        var msg = msg
        try {
            //   mmOutputStream.write(align)
            var space = "   "
            val l = msg.length
            if (l < 41) {
                for (x in 41 - l downTo 0) {
                    space = "$space "
                }
            }
            msg = msg.replace(" : ", space)

            //mmOutputStream.write(msg.toByteArray())
        } catch (e: IOException) {
            e.printStackTrace()
        }
        return msg
    }

    fun checkPermission(): Boolean {
        var write = 0
        var read = 0
        var camera = 0
        var phone = 0
        write = ContextCompat.checkSelfPermission(
            this,
            Manifest.permission.WRITE_EXTERNAL_STORAGE
        )
        read = ContextCompat.checkSelfPermission(
            this,
            Manifest.permission.READ_EXTERNAL_STORAGE
        )
        camera = ContextCompat.checkSelfPermission(this, Manifest.permission.CAMERA)
        phone = ContextCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE)
        return write == PackageManager.PERMISSION_GRANTED && phone == PackageManager.PERMISSION_GRANTED && read == PackageManager.PERMISSION_GRANTED && camera == PackageManager.PERMISSION_GRANTED
    }

    private fun requestPermission() {
        ActivityCompat.requestPermissions(
            this,
            arrayOf(
                Manifest.permission.WRITE_EXTERNAL_STORAGE,
                Manifest.permission.READ_EXTERNAL_STORAGE,
                Manifest.permission.CAMERA,
                Manifest.permission.READ_PHONE_STATE
            ),
            11
        )
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String?>,
        grantResults: IntArray
    ) {
        try {
            if (requestCode == 11) {
                if (grantResults.size > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED && grantResults[1] == PackageManager.PERMISSION_GRANTED && grantResults[2] == PackageManager.PERMISSION_GRANTED && grantResults[3] == PackageManager.PERMISSION_GRANTED
                ) {

                    initSdk()
                } else if (Build.VERSION.SDK_INT >= 23 && !shouldShowRequestPermissionRationale(
                        permissions[0]!!
                    )
                ) {
                    //  Toast.makeText(MainActivity.this, "Go to Settings and Grant the permission to use this feature.", Toast.LENGTH_SHORT).show();
                    // User selected the Never Ask Again Option
                    val i = Intent()
                    i.action = Settings.ACTION_APPLICATION_DETAILS_SETTINGS
                    i.addCategory(Intent.CATEGORY_DEFAULT)
                    i.data = Uri.parse("package:$packageName")
                    i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    i.addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY)
                    i.addFlags(Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS)
                    startActivity(i)
                    Toast.makeText(
                        mActivity,
                        getString(R.string.enable_permission),
                        Toast.LENGTH_SHORT
                    ).show()
                } else {
                    Toast.makeText(
                        mActivity,
                        getString(R.string.permission_denied),
                        Toast.LENGTH_SHORT
                    ).show()
                }
            }
        } catch (ex: java.lang.Exception) {
            //Logger.log(Constants.TAG, ex.message)
        }
    }

    fun String.capitalizeWords(): String = split(" ").map { it.capitalize() }.joinToString(" ")

    var barcode = ""
    override fun dispatchKeyEvent(e: KeyEvent): Boolean {
        if (e.action == KeyEvent.ACTION_DOWN) {
            //printM
            Log.i("TAG", "dispatchKeyEvent: $e")
            val pressedKey = e.unicodeChar.toChar()
            barcode += pressedKey
        }
        if (e.action == KeyEvent.ACTION_DOWN && e.keyCode == KeyEvent.KEYCODE_ENTER) {
            Toast.makeText(
                applicationContext,
                "barcode--->>>$barcode", Toast.LENGTH_LONG
            )
                .show()
            //
            barcode = ""
            return true
        }
        return super.dispatchKeyEvent(e)
    }

    @RequiresApi(Build.VERSION_CODES.KITKAT)
    fun Print(
        qnty: String,
        product: String,
        price: String,
        epsonPrinter: Printer,
        format: PrnStrFormat
    ) {


        var stringLength = 35
        //var qntyDefaultLen = 5
        var priceDefaultLen = 9
        //  var totalString = ""

        var qntylength = qnty.length
        // var qntyNumString = qnty + getSpace((qntyDefaultLen - qntylength))
        var qntyNumString = qnty

        var priceString = getSpace((priceDefaultLen - price.length)) + price

        Log.d(priceString, priceString.length.toString())
        var remainingStringLength = 0



        if (product.length > 22) {
            if (qnty.length == 6) {
                remainingStringLength = 20
            } else if (qnty.length == 7) {
                remainingStringLength = 19
            } else {
                remainingStringLength = 21
            }
//            if (price.length>=11){
//                remainingStringLength = 21;
//            }else if(price.length>=10){
//                remainingStringLength = 21;
//            }else{
//                remainingStringLength = 21;
//            }


        } else {
            remainingStringLength = stringLength - qntyNumString.length - priceString.length
        }

        var splitString = splitEqually(product, remainingStringLength)

        val stringBuilder = StringBuilder()
        stringBuilder.append(qntyNumString)
        if (splitString!!.size > 1) {
            splitString.forEachIndexed { index, s ->

                if (index > 0) {
                    stringBuilder.append(getSpace(qntyNumString.length))
                    //  Toast.makeText(this, qntyNumString.length.toString(), Toast.LENGTH_LONG).show()
                }
                stringBuilder.append(s + " ")
                if (index == 0) {
                    var spacelength = remainingStringLength - splitString[0]!!.length
                    Log.d("split len", splitString[0]!!.length.toString())
                    Log.d("price len", priceString.length.toString())
                    Log.d("qty len", qntyNumString.length.toString())
                    Log.d("space", spacelength.toString())
                    stringBuilder.append(getSpace(spacelength) + priceString)
                }
                stringBuilder.append(System.getProperty("line.separator"))
            }

        } else {
            var spacelength = remainingStringLength - splitString[0]!!.length
            Log.d("split len", splitString[0]!!.length.toString())
            Log.d("price len", priceString.length.toString())
            Log.d("qty len", qntyNumString.length.toString())
            Log.d("space", spacelength.toString())
            stringBuilder.append(splitString[0])
            stringBuilder.append(getSpace(spacelength) + priceString)
        }


        epsonPrinter.setPrintAppendString(stringBuilder.toString(), format)
        //  printMe!!.addBreak(1);
        //  epsonPrinter!!.setPrintAppendString(stringBuilder.toString(), format)
    }




    fun paymentDetails(name: String, amount: String, epsonPrinter: Printer, format: PrnStrFormat) {
        val stringBuilder = StringBuilder()
        stringBuilder.append(name)
        stringBuilder.append(getSpace(35 - (name.length + amount.length)))
        stringBuilder.append(amount)
        epsonPrinter.setPrintAppendString(stringBuilder.toString(), format)
    }

    fun getSpace(space: Int): String {
        var spacestr = ""
        if (space > 0) {
            for (i in 0 until space) {
                spacestr = "$spacestr "
            }
        }
        return spacestr

    }

    fun splitEqually(text: String, size: Int): List<String?>? {
        // Give the list the right capacity to start with. You could use an array
        // instead if you wanted.
        var ret: List<String>? = null
        ret = ArrayList((text.length + size - 1) / size)
        var start = 0
        while (start < text.length) {
            //ret.add
            ret.add(text.substring(start, Math.min(text.length, start + size)))
            start += size
        }
        return ret
    }

}