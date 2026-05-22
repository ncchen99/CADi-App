// C10 — 科普影片直式 (Figma node 1:12)
// 聊天室會根據聊天內容傳送科普影片給使用者,左下角有小機器人 (1:39)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../shared/theme/app_theme.dart';
import '../widgets/client_chrome.dart';

class EduVideoScreen extends StatefulWidget {
  const EduVideoScreen({super.key});

  @override
  State<EduVideoScreen> createState() => _EduVideoScreenState();
}

class _EduVideoScreenState extends State<EduVideoScreen> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/collo.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _initialized = true;
          });
          _controller.play();
        }
      })
      ..setLooping(true);

    // Allow auto-rotation (portrait and landscape)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    // Restore default system orientations to portrait only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  void _toggleFullscreen() {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    if (isLandscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: !isLandscape,
        bottom: !isLandscape,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _showControls = !_showControls;
            });
          },
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              // 1. Video surface
              Positioned.fill(
                child: Center(
                  child: _initialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              // 2. Play/Pause overlay button in the center
              if (_initialized && _showControls)
                Center(
                  child: GestureDetector(
                    onTap: _togglePlay,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: 0.85,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Colors.black38,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause_circle_filled_rounded
                              : Icons.play_circle_fill_rounded,
                          size: isLandscape ? 72 : 88,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

              // 3. Custom Top-Left back button
              if (_showControls)
                Positioned(
                  top: 12,
                  left: 8,
                  child: ClientBackButton(
                    onTap: () {
                      // Disposes and goes back portrait only
                      context.pop();
                    },
                    color: Colors.white,
                  ),
                ),

              // 4. Portrait title
              if (!isLandscape && _showControls)
                Positioned(
                  top: 20,
                  right: 24,
                  child: Text(
                    '科普影片',
                    style: AppTextStyles.heading2(context)
                        .copyWith(color: Colors.white),
                  ),
                ),

              // 5. Custom Bottom-Right fullscreen toggle button
              if (_showControls)
                Positioned(
                  right: 16,
                  bottom: isLandscape ? 16 : 96,
                  child: IconButton(
                    icon: Icon(
                      isLandscape
                          ? Icons.fullscreen_exit_rounded
                          : Icons.fullscreen_rounded,
                      size: 28,
                      color: Colors.white,
                    ),
                    onPressed: _toggleFullscreen,
                  ),
                ),

              // 6. Portrait bottom left companion CadiSoftBot
              if (!isLandscape)
                const Positioned(
                  left: 20,
                  bottom: 30,
                  child: CadiSoftBot(size: 78, blurred: false),
                ),

              // 7. Portrait bottom-right caption info banner
              if (!isLandscape)
                Positioned(
                  right: 24,
                  bottom: 40,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      '了解失智症日常照護',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
