import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodeoapp/components/small_loader.dart';
import 'package:foodeoapp/helper/data_storage.dart';
import 'package:video_player/video_player.dart';

class Videoplayer extends StatefulWidget {
  final String url;
  const Videoplayer({super.key, required this.url});

  @override
  State<Videoplayer> createState() => _VideoplayerState();
}

class _VideoplayerState extends State<Videoplayer> {
  late VideoPlayerController _videoPlayerController;
  late Future _initializeVideoPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    print('VideoUrl${widget.url}');

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _initializeVideoPlayer = _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
    // _togglePlayPause();
    // _videoPlayerController.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();

    super.dispose();
  }

  void _togglePlayPause() {
    if (isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayPause,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            FutureBuilder(
              future: _initializeVideoPlayer,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    ),
                  );
                } else {
                  return Container(
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [SmallLoader()],
                    ),
                  );
                }
              },
            ),
            if (DataStroge.userRole.value == 'owner')
              Positioned(
                top: 10.sp,
                left: 10.sp,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            if (!isPlaying)
              Center(
                child: CircleAvatar(
                  radius: 50.sp,
                  backgroundColor:
                      const Color.fromARGB(255, 180, 179, 179).withOpacity(0.4),
                  child: SvgPicture.asset(
                    'assets/icons/fill-Play.svg',
                    color: Colors.white.withOpacity(0.8),
                    width: 30.sp,
                    height: 30.sp,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
