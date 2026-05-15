// C5 — 開啟 App 畫面 (Figma node 1:21)
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/client_chrome.dart';

class ClientSplashScreen extends StatefulWidget {
  const ClientSplashScreen({super.key});

  @override
  State<ClientSplashScreen> createState() => _ClientSplashScreenState();
}

class _ClientSplashScreenState extends State<ClientSplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) context.go('/client');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientGradientBackground(
        child: const SafeArea(
          child: Center(child: CadiWordmark(size: 72)),
        ),
      ),
    );
  }
}
