import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ChewieItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  const ChewieItem({Key? key, required this.videoPlayerController})
      : super(key: key);
  @override
  _ChewieItemState createState() => _ChewieItemState();
}

class _ChewieItemState extends State<ChewieItem> {
  late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();

    _chewieController = ChewieController(
        videoPlayerController: widget.videoPlayerController,
        aspectRatio: 4 / 2,
        autoInitialize: true,
        errorBuilder: (context, errorBuilder) {
          return Center(
            child: Text(errorBuilder),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController);
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
