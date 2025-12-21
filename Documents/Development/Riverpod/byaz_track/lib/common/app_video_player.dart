import 'package:chewie/chewie.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  const AppVideoPlayer({
    required this.videoUrl,
    super.key,
    this.showListener = false,
    this.onProgressUpdate,
  });
  final String videoUrl;
  final bool showListener;
  final ValueChanged<double>? onProgressUpdate;

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      setState(() {
        _errorMessage = null;
      });
      // Force https for http URLs
      String videoUrl = widget.videoUrl;
      if (videoUrl.startsWith('http://')) {
        videoUrl = videoUrl.replaceFirst('http://', 'https://');
      }

      _videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      // _videoController = VideoPlayerController.networkUrl(
      //   // widget.videoUrl,
      //   //networkUrl
      //   Uri.parse(widget.videoUrl),
      // );

      await _videoController.initialize();

      if (widget.showListener) {
        _videoController.addListener(() {
          final duration = _videoController.value.duration;
          final position = _videoController.value.position;

          if (duration.inMilliseconds == 0) return;

          final progress = position.inMilliseconds / duration.inMilliseconds;
          widget.onProgressUpdate?.call(progress);

          if (mounted) {
            setState(() {
              // _isVideoEnded = position >= duration;
            });
          }
        });
      }

      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        errorBuilder:
            (context, errorMessage) => CustomErrorWidget(error: errorMessage),
        autoPlay: true,
        customControls: const MaterialControls(),
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.primary500,
          handleColor: const Color.fromARGB(255, 2, 92, 167),
          bufferedColor: AppColors.textColor300,
        ),
      );

      setState(() {});
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load video.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _errorMessage != null
        ? CustomErrorWidget(
          error: _errorMessage,
          onPressed: _initializePlayer,
          verticlePadding: const EdgeInsets.symmetric(vertical: 100),
        )
        : ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child:
                _chewieController != null &&
                        _chewieController!
                            .videoPlayerController
                            .value
                            .isInitialized
                    ? Chewie(controller: _chewieController!)
                    : const ColoredBox(
                      color: Colors.black,
                      child: LoadingWidget(),
                    ),
          ),
        );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
