package cn.bitle.favor.favor_cometchat

import android.app.Activity
import android.content.Intent
import android.view.ViewGroup
import android.widget.RelativeLayout
import com.cometchat.pro.core.*
import com.cometchat.pro.core.CometChat.CallbackListener
import com.cometchat.pro.exceptions.CometChatException
import com.cometchat.pro.models.AudioMode
import com.cometchat.pro.models.User
import com.cometchat.pro.uikit.R
import com.cometchat.pro.uikit.ui_components.calls.call_manager.CometChatCallActivity
import com.cometchat.pro.uikit.ui_components.calls.call_manager.listener.CometChatCallListener
import com.cometchat.pro.uikit.ui_components.cometchat_ui.CometChatUI
import com.cometchat.pro.uikit.ui_resources.utils.ErrorMessagesUtils
import com.cometchat.pro.uikit.ui_resources.utils.Utils
import com.google.android.material.snackbar.Snackbar
import io.flutter.Log
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject


class CometChatUtil {
    companion object {
        const val TAG: String = "favor_plugin_cometchat_listener";
    }

    fun cometChatInit(region: String, appID: String, activity: Activity, result: Result) {
//        CometChatCallListener.addCallListener(TAG, activity)

        val appSettings =
            AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region)
                .build()

        CometChat.init(activity.applicationContext,
            appID,
            appSettings,
            object : CometChat.CallbackListener<String>() {
                override fun onSuccess(successMessage: String) {
                    Log.d(FavorCometchatPlugin.TAG, "Initialization completed successfully")
                    result.success(true)
                }

                override fun onError(e: CometChatException) {
                    Log.d(FavorCometchatPlugin.TAG,
                        "Initialization failed with exception: " + e.message)
                }
            })
    }

    fun login(uid: String, authKey: String, activity: Activity, result: Result) {
        if (CometChat.getLoggedInUser() == null) {
            CometChat.login(uid, authKey, object : CometChat.CallbackListener<User?>() {
                override fun onSuccess(user: User?) {
                    Log.d(FavorCometchatPlugin.TAG, "Login Successful : " + user.toString())
                    activity.applicationContext.startActivity(Intent(activity,
                        CometChatUI::class.java))
                    result.success(true)
                }

                override fun onError(e: CometChatException) {
                    Log.d(FavorCometchatPlugin.TAG,
                        "Login failed with exception: " + e.message);
                    result.success(false)
                }
            })
        } else {
            Log.d(FavorCometchatPlugin.TAG, " User already logged in")
            result.success(true)
        }
    }

    fun logout(result: Result) {
        CometChat.logout(object : CometChat.CallbackListener<String>() {
            override fun onSuccess(p0: String?) {
                Log.d(TAG, "Logout completed successfully")
                result.success(true)
            }

            override fun onError(p0: CometChatException?) {
                Log.d(TAG, "Logout failed with exception: " + p0?.message)
                result.success(false)
            }

        })

    }

    fun initCall(activity: Activity, call: Call, result: Result) {
        addCallListener(activity)
        CometChat.initiateCall(call, object : CometChat.CallbackListener<Call>() {
            override fun onSuccess(call: Call) {}

            override fun onError(e: CometChatException) {
                Log.e(TAG, "onError: " + e.message)
                Snackbar.make(activity.window.decorView.rootView,
                    activity.applicationContext.resources.getString(
                        R.string.call_initiate_error) + ":" + e.message,
                    Snackbar.LENGTH_LONG).show()
                result.success(null)
            }
        })
    }

    private fun addCallListener(activity: Activity) {
        CometChat.addCallListener(TAG, object : CometChat.CallListener() {
            override fun onIncomingCallReceived(call: Call) {
                Log.d(TAG, "Incoming call: ");
            }

            override fun onOutgoingCallAccepted(call: Call) {
              startCall(activity, call, CometChatCallingView.mainView)

                Log.d(TAG, "onOutgoingCallAccepted:${call}");
            }

            override fun onOutgoingCallRejected(call: Call) {
                Log.d(TAG, "Outgoing call rejected: " +
                        call.toString());
            }

            override fun onIncomingCallCancelled(call: Call) {
                Log.d(TAG, "Incoming call cancelled: " +
                        call.toString());
            }
        })
    }

    fun initiateCall(activity: Activity, call: Call, result: Result) {
        val jsonObject = JSONObject()
        try {
            jsonObject.put("bookingId", 6)
        } catch (e: Exception) {
            e.printStackTrace()
        }
        call.metadata = jsonObject

        CometChat.initiateCall(call, object : CometChat.CallbackListener<Call>() {
            override fun onSuccess(call: Call) {
                Utils.startCallIntent(
                    activity.applicationContext,
                    call.callReceiver as User,
                    call.type,
                    true,
                    call.sessionId,
                )
                result.success(true)
            }

            override fun onError(e: CometChatException) {
                Log.e(TAG, "onError: " + e.message)
                Snackbar.make(activity.window.decorView.rootView,
                    activity.applicationContext.resources.getString(
                        R.string.call_initiate_error) + ":" + e.message,
                    Snackbar.LENGTH_LONG).show()
                result.success(false)
            }
        })
    }

    fun startCall(activity: Activity, call: Call, mainView: RelativeLayout?) {
        val callSettings = CallSettings.CallSettingsBuilder(activity, mainView)
            .setSessionId(call.sessionId)
            .startWithAudioMuted(true)
            .startWithVideoMuted(true)
            .enableDefaultLayout(true)
            .setMode(CallSettings.MODE_SPOTLIGHT)
            .build()

        CometChat.startCall(callSettings, object : CometChat.OngoingCallListener {
            override fun onUserJoined(user: User) {
                Log.e(TAG, "onUserJoined: ${user.uid}")
            }

            override fun onUserLeft(user: User) {
                Log.e(TAG, "onUserLeft: ${user.uid}")
            }

            override fun onError(e: CometChatException) {
                e.message?.let { android.util.Log.e("onError: ", it) }
                Log.e(TAG, "onError: $e")
            }

            override fun onCallEnded(call: Call) {
                Log.e(TAG, "onCallEnded: $call")
            }

            override fun onUserListUpdated(p0: MutableList<User>?) {
                Log.e(TAG, "onUserListUpdated: " + p0.toString())
            }

            override fun onAudioModesUpdated(p0: MutableList<AudioMode>?) {
                Log.e(TAG, "onAudioModesUpdated: " + p0.toString())
            }

            override fun onRecordingStarted(p0: User?) {
            }

            override fun onRecordingStopped(p0: User?) {
            }

            override fun onUserMuted(p0: User?, p1: User?) {
            }

            override fun onCallSwitchedToVideo(p0: String?, p1: User?, p2: User?) {
            }
        })
    }

    fun endCall(activity: Activity, sessionId: String, result: Result) {
        CometChat.endCall(sessionId, object : CometChat.CallbackListener<Call>() {
            override fun onSuccess(call: Call) {
                result.success(true)
            }

            override fun onError(e: CometChatException) {
                Log.e(TAG, "onError: " + e.message)
                Snackbar.make(activity.window.decorView.rootView,
                    activity.applicationContext.resources.getString(
                        R.string.call_initiate_error) + ":" + e.message,
                    Snackbar.LENGTH_LONG).show()
                result.success(false)
            }
        })
    }

    /**
     * You can call muteAudio() Method to mute your Audio Stream to the end-user.
     * if set to true the Audio Stream is muted and if set tofalse Audio Stream is transmitted.
     */
    fun muteAudio(paused: Boolean) {
        CallManager.getInstance().muteAudio(paused)
    }

    /**
     * CometChatConstants.AUDIO_MODE_EARPIECE;
     */
    fun setAudioMode(s: String) {
        CallManager.getInstance()
            .setAudioMode(s)
    }

    fun switchCamera() {
        CallManager.getInstance().switchCamera()
    }

    /**
     * You can call pauseVideo() Method to pause Video Stream to the end-user.
     * if set to true the Video Stream is muted and if set to false Video Stream is transmitted.
     */
    fun pauseVideo(paused: Boolean) {
        CallManager.getInstance().pauseVideo(paused)
    }

    fun getAudioOutputModes() {
        CallManager.getInstance()
            .getAudioOutputModes(object : CallbackListener<List<AudioMode?>?>() {
                override fun onSuccess(audioModes: List<AudioMode?>?) {
                    Log.d(TAG, "Availabe audio modes received:${audioModes}")
                }

                override fun onError(e: CometChatException) {
                    Log.d(TAG, "Error while fetching audio modes " + e.message)
                }
            })
    }


    fun getCallParticipantCount(sessionId: String) {
        val callType = CallSettings.CALL_MODE_DIRECT

        CometChat.getCallParticipantCount(sessionId, callType, object : CallbackListener<Int?>() {
            override fun onSuccess(integer: Int?) {
                // handle success
            }

            override fun onError(e: CometChatException) {
                // handle error
            }
        })
    }
}
