// Figma: Frames 1:1683, 1:1694, 1:1226, 1:1230 → 直接使用 assets/videos/時光隧道.mp4
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MotivationScreen extends StatefulWidget {
  const MotivationScreen({super.key});

  @override
  State<MotivationScreen> createState() => _MotivationScreenState();
}

class _MotivationScreenState extends State<MotivationScreen> {
  late VideoPlayerController _videoCtrl;
  bool _videoReady = false;
  bool _showText = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _initVideo();
  }

  Future<void> _initVideo() async {
    _videoCtrl = VideoPlayerController.asset('assets/videos/時光隧道.mp4');
    await _videoCtrl.initialize();
    _videoCtrl.addListener(_onVideoProgress);
    setState(() => _videoReady = true);
    await _videoCtrl.play();
  }

  void _onVideoProgress() {
    if (!mounted) return;
    final pos = _videoCtrl.value.position;
    final dur = _videoCtrl.value.duration;
    // Show encouragement text in last 3 seconds
    if (dur > Duration.zero && dur - pos < const Duration(seconds: 3)) {
      if (!_showText) setState(() => _showText = true);
    }
    // Auto-close after video ends
    if (!_videoCtrl.value.isPlaying && pos >= dur && dur > Duration.zero) {
      _finish();
    }
  }

  void _finish() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    if (mounted) context.go('/client/tunnel/quote');
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _videoCtrl.removeListener(_onVideoProgress);
    _videoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _finish,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Video layer — 時光隧道.mp4
            if (_videoReady)
              FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoCtrl.value.size.width,
                  height: _videoCtrl.value.size.height,
                  child: VideoPlayer(_videoCtrl),
                ),
              )
            else
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),

            // Encouragement text overlay (Figma: 1:1232)
            if (_showText)
              Positioned(
                left: 32,
                right: 32,
                bottom: MediaQuery.paddingOf(context).bottom + 80,
                child: Text(
                  '你已經走過許多坎坷，\n每一步都值得被讚賞。',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 12,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.15),
              ),

            // Skip hint
            Positioned(
              top: MediaQuery.paddingOf(context).top + 16,
              right: 20,
              child: GestureDetector(
                onTap: _finish,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '略過',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
