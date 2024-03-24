import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CallScreen extends StatefulWidget {
  final String? channelId;
  const CallScreen({
    Key? key,
    this.channelId,
  }) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  RtcEngine? _engine;
  bool loader = false;
  List _remoteUids = [];
  double xPosition = 0;
  double yPosition = 0;
  bool muted = false;
  bool videoMuted = false;

  Future<void> initAgora() async {
    setState(() {
      loader = true;
    });
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine?.initialize(const RtcEngineContext(
      appId: "d3dce750cac44e96846ce625e50a0797",
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine?.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            loader = false; // Set loader to false when joined channel
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUids.add(remoteUid);
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUids.remove(remoteUid);
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine?.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine?.enableVideo();
    await _engine?.startPreview();

    await _engine?.joinChannel(
      token: "",
      channelId: widget.channelId.toString(),
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _engine?.leaveChannel();
    await _engine?.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF77D8E),
        surfaceTintColor: const Color(0xFFF77D8E),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Call Screen",
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
      body: (loader)
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : Stack(
              children: [
                Center(
                  child: _renderRemoteView(context),
                ),
                Stack(
                  children: [
                    Positioned(
                      top: yPosition,
                      left: xPosition,
                      child: GestureDetector(
                        onPanUpdate: (tabInfo) {
                          setState(() {
                            xPosition += tabInfo.delta.dx;
                            yPosition += tabInfo.delta.dy;
                          });
                        },
                        child: SizedBox(
                            height: 120,
                            width: 130,
                            child: localVideoView()),
                      ),
                    ),
                    _toolBar(),
                  ],
                )
              ],
            ),
    );
  }

  Widget _renderRemoteView(BuildContext context) {
    if (_remoteUids.isNotEmpty) {
      if (_remoteUids.length == 1) {
        return remoteVideoView(_remoteUids[0], widget.channelId);
      } else if (_remoteUids.length == 2) {
        return Column(
          children: [
            remoteVideoView(_remoteUids[1],  widget.channelId),
            remoteVideoView(_remoteUids[2],  widget.channelId),
          ],
        );
      } else {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 11 / 20,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10),
            itemCount: _remoteUids.length,
            itemBuilder: (_, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: remoteVideoView(_remoteUids[index],  widget.channelId),
              );
            },
          ),
        );
      }
    } else {
      return const Text("Waiting for other user to join");
    }
  }

  Widget _toolBar() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              setState(() {
                muted = !muted;
              });
              _engine?.muteLocalAudioStream(muted);
            },
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(6),
            elevation: 2,
            fillColor: (muted) ? Colors.blue : Colors.white,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blue,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              _onCallEnd(context);
            },
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(6),
            elevation: 2,
            fillColor: Colors.red,
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 40,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              setState(() {
                _engine?.switchCamera();
              });
            },
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(6),
            elevation: 2,
            fillColor: (muted) ? Colors.blue : Colors.white,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blue,
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              setState(() {
                videoMuted = !videoMuted;
              });

              _engine?.muteLocalVideoStream(videoMuted);
            },
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(6),
            elevation: 2,
            fillColor: (videoMuted) ? Colors.blue : Colors.white,
            child: Icon(
              videoMuted ? Icons.mic_off : Icons.mic,
              color: videoMuted ? Colors.white : Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  AgoraVideoView remoteVideoView(
      int remoteUid, channelId) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: _engine!,
        canvas: VideoCanvas(uid: remoteUid),
        connection: RtcConnection(channelId: channelId),
      ),
    );
  }

  AgoraVideoView localVideoView() {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: _engine!,
        canvas: const VideoCanvas(uid: 0), // Use uid = 0 for local view
      ),
    );
  }


  Future<void> _onCallEnd(BuildContext context) async {
    await _engine?.leaveChannel();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
