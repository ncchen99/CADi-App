// C5 — 開啟 App 畫面 (Figma node 1:21)
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'client_home_screen.dart';

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
    _timer = Timer(const Duration(seconds: 5), () {
      if (mounted) context.go('/client/mood');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ClientHiLandingView());
  }
}
