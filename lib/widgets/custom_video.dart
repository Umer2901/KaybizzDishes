// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class SilentVideo extends StatefulWidget {
//   final String assetPath;
//   final double aspectRatio;
//   final BorderRadius borderRadius;

//   const SilentVideo({
//     super.key,
//     required this.assetPath,
//     this.aspectRatio = 16 / 9,
//     this.borderRadius = const BorderRadius.all(Radius.circular(12)),
//   });

//   @override
//   State<SilentVideo> createState() => _SilentVideoState();
// }

// class _SilentVideoState extends State<SilentVideo> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset(widget.assetPath)
//       ..setVolume(0.0) // 🔇 no sound
//       ..setLooping(true)
//       ..initialize().then((_) {
//         _controller.play();
//         setState(() {});
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_controller.value.isInitialized) {
//       return const AspectRatio(
//         aspectRatio: 16 / 9,
//         child: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return ClipRRect(
//       borderRadius: widget.borderRadius,
//       child: AspectRatio(
//         aspectRatio: widget.aspectRatio,
//         child: VideoPlayer(_controller),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SilentVideo extends StatefulWidget {
  final String assetPath;
  const SilentVideo({super.key, required this.assetPath});

  @override
  State<SilentVideo> createState() => _SilentVideoState();
}

class _SilentVideoState extends State<SilentVideo> {
  late final VideoPlayerController _controller;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath)
      ..initialize().then((_) async {
        await _controller.setLooping(true);
        await _controller.setVolume(0.0); // ✅ mute
        await _controller.play();
        if (mounted) setState(() => _ready = true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return const Center(child: CircularProgressIndicator());
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
    );
  }
}
