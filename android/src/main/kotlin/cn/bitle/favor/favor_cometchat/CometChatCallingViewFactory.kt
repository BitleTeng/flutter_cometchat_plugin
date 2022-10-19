package cn.bitle.favor.favor_cometchat

import android.app.Activity
import android.content.Context
import cn.bitle.favor.favor_cometchat.model.RTCParams
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class CometChatCallingViewFactory(activity: Activity) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    private var activity: Activity = activity
//    private var params: RTCParams = params

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        @Suppress("UNCHECKED_CAST")
        val arguments = args as Map<String, Any>
        val params = RTCParams().getParams(arguments)
        return CometChatCallingView(activity, params)
    }
}