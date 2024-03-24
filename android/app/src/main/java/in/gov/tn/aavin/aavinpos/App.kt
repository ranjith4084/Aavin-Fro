package `in`.gov.tn.aavin.aavinposfro

import com.zcs.sdk.DriverManager
import io.flutter.app.FlutterApplication

class App : FlutterApplication() {
    //    public static CardInfoEntity cardInfoEntity;
    override fun onCreate() {
        super.onCreate()
//        GeneratedPluginRegistrant.registerWith(flutterEngine)

        //        cardInfoEntity = new CardInfoEntity();
//
//        Config.init(this)
//                .setUpdate();
        //FlutterFirebaseMessagingService.setPluginRegistrant(this);
    }

    companion object {
        var sDriverManager: DriverManager? = null
    }
}