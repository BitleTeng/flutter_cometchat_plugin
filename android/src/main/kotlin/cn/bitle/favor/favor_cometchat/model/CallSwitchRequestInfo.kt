package cn.bitle.favor.favor_cometchat.model

import com.cometchat.pro.rtc.model.RTCUser

class CallSwitchRequestInfo(
    val sessionId: String,
    var requestInitiatedBy: RTCUser,
    var requestAcceptedBy: RTCUser,
)
