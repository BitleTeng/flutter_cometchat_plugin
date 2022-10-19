package cn.bitle.favor.favor_cometchat.model

class RTCParams {
    lateinit var appID: String
    lateinit var region: String

    var receiverUid: String? = null
    var receiverName: String? = null
    var receiverAvatar: String? = null

    var userUID: String? = null
    var userName: String? = null
    var userAvatar: String? = null

    var mode: String = "SPOTLIGHT"
    var sessionId: String? = null

    var domain: String? = null
    var rtcUserJWT: String? = null
    var rtcUserResource: String? = null

    var analyticsSettingsHost: String? = null
    var analyticsSettingsVersion: String? = null
    var analyticsSettingsPingDisabled: String? = null
    var analyticsSettingsUseSSL: String? = null

    var isInitiator: Boolean = true
    var defaultLayout: Boolean = true
    var isAudioOnly: Boolean = false

    var endCallButtonDisable: Boolean = false

    var switchCameraButtonDisable: Boolean = false
    var muteAudioButtonDisable: Boolean = false

    var audioModeButtonDisable: Boolean = false
    var pauseVideoButtonDisable: Boolean = true

    var videoMuted: Boolean = true
    var audioMuted: Boolean = true

    var showSwitchToVideoCall: Boolean = false
    var startRecording: Boolean = false
    var avatarMode: String? = null

    fun getParams(arg: Map<String, Any>): RTCParams {
        val defaultLayout = arg["defaultLayout"] as Boolean?
        val videoMuted = arg["videoMuted"] as Boolean?
        val audioMuted = arg["audioMuted"] as Boolean?
        val endCallButtonDisable = arg["endCallButtonDisable"] as Boolean?
        val isInitiator = arg["isInitiator"] as Boolean?
        val isAudioOnly = arg["isAudioOnly"] as Boolean?
        val pauseVideoButtonDisable = arg["pauseVideoButtonDisable"] as Boolean?
        val audioModeButtonDisable = arg["audioModeButtonDisable"] as Boolean?
        val switchCameraButtonDisable = arg["switchCameraButtonDisable"] as Boolean?
        val muteAudioButtonDisable = arg["muteAudioButtonDisable"] as Boolean?
        val showSwitchToVideoCall = arg["showSwitchToVideoCall"] as Boolean?
        val startRecording = arg["startRecording"] as Boolean?

        val userUID: String = arg["userUID"] as String
        val userName: String = arg["userName"] as String
        val mode = arg["mode"] as String?
        val receiverUid: String = arg["receiverUid"] as String
        val receiverName: String = arg["receiverName"] as String
        val sessionId = arg["sessionId"] as String?
        val appID: String = arg["appID"] as String
        val region: String = arg["region"] as String

        /**
         * 初始化必传
         */
        this.appID = appID
        this.region = region
        this.domain = "rtc-${this.region}.cometchat.io"
        this.userUID = userUID

        this.userName = userName
        this.userAvatar = null
        this.rtcUserJWT = null
        this.rtcUserResource = null

        this.receiverUid = receiverUid
        this.receiverName = receiverName
        this.receiverAvatar = null

        this.analyticsSettingsPingDisabled = null
        this.analyticsSettingsUseSSL = null

        this.avatarMode = null
        this.sessionId = sessionId

        if (startRecording != null) {
            this.startRecording = startRecording
        }

        if (showSwitchToVideoCall != null) {
            this.showSwitchToVideoCall = showSwitchToVideoCall
        }

        if (muteAudioButtonDisable != null) {
            this.muteAudioButtonDisable = muteAudioButtonDisable
        }

        if (switchCameraButtonDisable != null) {
            this.switchCameraButtonDisable = switchCameraButtonDisable
        }

        if (audioModeButtonDisable != null) {
            this.audioModeButtonDisable = audioModeButtonDisable
        }

        if (pauseVideoButtonDisable != null) {
            this.pauseVideoButtonDisable = pauseVideoButtonDisable
        }

        if (isAudioOnly != null) {
            this.isAudioOnly = isAudioOnly
        }

        if (mode != null) {
            this.mode = mode
        }

        if (isInitiator != null) {
            this.isInitiator = isInitiator
        }

        if (defaultLayout != null) {
            this.defaultLayout = defaultLayout
        }

        if (endCallButtonDisable != null) {
            this.endCallButtonDisable = endCallButtonDisable
        }

        if (audioMuted != null) {
            this.audioMuted = audioMuted
        }

        if (videoMuted != null) {
            this.videoMuted = videoMuted
        }

        return this
    }
}