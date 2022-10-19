package cn.bitle.favor.favor_cometchat.model

import com.cometchat.pro.rtc.model.RTCUser

class RTCRecordingInfo(var recordingStarted: Boolean, var user: RTCUser) {

    fun detUser(user: RTCUser) {
        this.user = user
    }
}
