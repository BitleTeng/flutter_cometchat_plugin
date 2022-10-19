package cn.bitle.favor.favor_cometchat

import android.app.Activity
import android.graphics.Point
import android.view.View
import android.view.ViewGroup
import android.widget.RelativeLayout
import androidx.core.content.ContextCompat
import cn.bitle.favor.favor_cometchat.model.RTCParams
import com.cometchat.pro.rtc.CometChatRTCView
import com.cometchat.pro.rtc.CometChatRTCViewListener
import com.cometchat.pro.rtc.Constants
import com.cometchat.pro.rtc.model.*
import com.facebook.react.ReactRootView
import io.flutter.Log
import io.flutter.plugin.platform.PlatformView


class CometChatCallingView(activity: Activity, params: RTCParams) :
    PlatformView {
    private val cometChatRTCView: CometChatRTCView
    private val relativeLayout: View
    private var params: RTCParams

    init {
        this.params = params

        val rtcUser = RTCUser(
            params.userUID.toString(),
            params.userName.toString(),
            params.userAvatar.toString(),
        )
        val rtcReceiver = RTCReceiver(
            params.receiverUid.toString(),
            params.receiverName.toString(),
            params.receiverAvatar.toString(),
        )

        val settings = AnalyticsSettings(
            params.analyticsSettingsHost.toString(),
            params.analyticsSettingsVersion.toString(),
        )

        val cometChatRTCViewBuilder = CometChatRTCView.CometChatRTCViewBuilder(activity)
            .setSessionId(params.sessionId)
            .setAppId(params.appID)
            .setRegion(params.region)
            .setDomain(params.domain)
            .setRTCInitiator(rtcUser)
            .setRTCUser(rtcUser)
            .setRTCReceiver(rtcReceiver)
            .setIsInitiator(params.isInitiator)
            .setDefaultLayoutEnable(params.defaultLayout)
            .setIsAudioOnly(params.isAudioOnly)
            .setMode(params.mode)
            .setEndCallButtonDisable(params.endCallButtonDisable)
            .setSwitchCameraButtonDisable(params.switchCameraButtonDisable)
            .startWithAudioMuted(params.audioMuted)
            .startWithVideoMuted(params.videoMuted)
            .setAnalyticsSettings(settings)
            .setDefaultAudioMode(params.mode)
            .showSwitchToVideoCallButton(params.showSwitchToVideoCall)
            .setMuteAudioButtonDisable(params.muteAudioButtonDisable)
            .setPauseVideoButtonDisable(params.pauseVideoButtonDisable)
            .setAudioModeButtonDisable(params.audioModeButtonDisable)
            .setAvatarMode(params.mode)
            .setEventListner(object : CometChatRTCViewListener {
                override fun onCallEnded() {
                    Log.e(TAG, "onCallEnded called ......")
                }

                override fun onCallEndButtonPressed() {
                    Log.e(TAG, "onCallEndButtonPressed called ......")
                    //cometChatRTCView.endCallSession();
                }

                override fun onUserJoined(user: RTCUser) {
                    Log.e(TAG, "onUserJoined called UID ......" + user.uid)
                    Log.e(TAG, "onUserJoined called name ......" + user.name)
                    Log.e(TAG, "onUserJoined called avatar ......" + user.avatar)
                }

                override fun onUserLeft(user: RTCUser) {
                    Log.e(TAG, "onUserLeft called UID ......" + user.uid)
                    Log.e(TAG, "onUserLeft called name ......" + user.name)
                    Log.e(TAG, "onUserLeft called avatar ......" + user.avatar)
                }

                override fun onUserListChanged(users: ArrayList<RTCUser>) {
                    Log.e(TAG, "onUserListChanged called name ......")
                }

                override fun onAudioModeChanged(devices: ArrayList<AudioMode>) {
                    Log.e(TAG, "onAudioModeChanged size = " + devices.size)
                    for (i in devices.indices) {
                        val audioMode = devices[i]
                        Log.e(
                            TAG,
                            "Mode : " + audioMode.mode + "   is Selected : " + audioMode.isSelected
                        )
                    }
                }

                override fun onCallSwitchedToVideo(info: CallSwitchRequestInfo?) {
                }

                override fun onUserMuted(muteObj: RTCMutedUser?) {
                }

                override fun onRecordingToggled(info: RTCRecordingInfo?) {
                }
            })

        cometChatRTCView = cometChatRTCViewBuilder.build()

        relativeLayout = cometChatRTCView.view

        var layout = RelativeLayout(activity)
        layout.addView(relativeLayout)
        mainView = layout
    }

    override fun getView(): ViewGroup {
        return mainView!!
    }

    override fun dispose() {
        println("dispose============")
    }

    companion object {
        private const val TAG = "NativeLayoutView"
        var mainView: RelativeLayout? = null
    }
}


