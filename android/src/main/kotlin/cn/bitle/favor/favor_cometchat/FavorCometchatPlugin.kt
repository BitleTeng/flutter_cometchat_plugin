package cn.bitle.favor.favor_cometchat

import android.app.Activity
import android.widget.RelativeLayout
import androidx.annotation.NonNull
import cn.bitle.favor.favor_cometchat.model.RTCParams
import com.cometchat.pro.core.Call
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


class FavorCometchatPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var flutterBinding: FlutterPlugin.FlutterPluginBinding
    private lateinit var activity: Activity
    private val cometChatUtil = CometChatUtil()

    companion object {
        const val TAG: String = "favor_cometchat_plugin"
        private val channelName = "favor_cometchat"
        private val viewId = "favor_cometchat_calling_view"
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        flutterBinding = flutterPluginBinding

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, channelName)
        channel.setMethodCallHandler(this)

    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "init" -> {
                val region: String = call.argument<String>("region") as String
                val appID: String = call.argument<String>("appID") as String
                cometChatUtil.cometChatInit(region, appID, activity, result)
            }
            "login" -> {
                val uid: String = call.argument<String>("uid") as String
                val authKey: String = call.argument<String>("authKey") as String
                cometChatUtil.login(uid, authKey, activity, result)
            }
            "logout" -> cometChatUtil.logout(result)
            "startCall" -> {
                val callType: String = call.argument<String>("callType") as String
                val receiverType: String = call.argument<String>("receiverType") as String
                val receiverUid: String = call.argument<String>("receiverUid") as String
                val sessionId: String = call.argument<String>("sessionId") as String
                val calls = Call(receiverUid, receiverType, callType)
                calls.sessionId = sessionId
                cometChatUtil.initiateCall(activity, calls, result)
            }
            "endCall" -> {
                val sessionId: String = call.argument<String>("sessionId") as String
                cometChatUtil.endCall(activity, sessionId, result)
            }
            "initCall" -> {
                val callType: String = call.argument<String>("callType") as String
                val receiverType: String = call.argument<String>("receiverType") as String
                val receiverUid: String = call.argument<String>("receiverUid") as String
                val calls = Call(receiverUid, receiverType, callType)

                cometChatUtil.initCall(activity, calls, result)
            }
            "initView" -> {
                result.success(true)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        flutterBinding.platformViewRegistry.registerViewFactory(
            viewId,
            CometChatCallingViewFactory(activity),
        )
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivity() {}
}

