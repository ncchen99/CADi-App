import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/storage/app_storage.dart';
import '../../shared/theme/app_theme.dart';
import '../widgets/client_chrome.dart';

enum ChatMode { client, family }

class _Message {
  final String text;
  final bool isUser;

  const _Message(this.text, {required this.isUser});
}

class AiChatScreen extends StatefulWidget {
  final ChatMode mode;
  // C8/F3 = false (剛開始), C9/F4 = true (已經開始)
  final bool started;

  const AiChatScreen({super.key, required this.mode, this.started = true});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final _inputController = TextEditingController();
  late final String _modeKey = widget.mode == ChatMode.client
      ? 'client'
      : 'family';
  late List<_Message> _messages;

  static const _seedStarted = [
    _Message('那是因為他以前喜歡在這個時\n間買菜', isUser: false),
    _Message('那他為什麼喜歡買菜', isUser: true),
    _Message('他之前有習慣每週煮給家人', isUser: false),
    _Message('那我要怎麼避免', isUser: true),
    _Message('你可以先把菜園收好不能使找到，\n這樣他就比較難發現。', isUser: false),
  ];

  static const _seedNew = [_Message('我可以怎麼幫忙?', isUser: true)];

  @override
  void initState() {
    super.initState();
    final stored = AppStorage.loadChat(_modeKey);
    if (stored.isNotEmpty) {
      _messages = stored
          .map((r) => _Message(r.text, isUser: r.isUser))
          .toList();
    } else {
      _messages = List.of(widget.started ? _seedStarted : _seedNew);
      _persist();
    }
  }

  void _persist() {
    AppStorage.saveChat(
      _modeKey,
      _messages.map((m) => ChatRecord(text: m.text, isUser: m.isUser)).toList(),
    );
  }

  void _send() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Message(text, isUser: true));
      _inputController.clear();
    });
    _persist();
    if (text.contains('影片')) {
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          context.push('/client/edu-video');
        }
      });
    }
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ClientGradientBackground(
        peachOnly: widget.mode == ChatMode.client,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 12,
                left: 8,
                child: ClientBackButton(
                  onTap: () => context.go(
                    widget.mode == ChatMode.client ? '/client' : '/family',
                  ),
                ),
              ),
              Positioned(
                top: 18,
                right: 26,
                child: Row(
                  children: const [
                    Icon(Icons.search_rounded, size: 22, color: Colors.black),
                    SizedBox(width: 24),
                    Icon(
                      Icons.swap_horiz_rounded,
                      size: 24,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              const Positioned(
                top: 74,
                left: 0,
                right: 0,
                child: Center(child: CadiSoftBot(size: 146)),
              ),
              Positioned(
                top: 180,
                left: 23,
                right: 23,
                child: _PromptCard(
                  text: widget.mode == ChatMode.client
                      ? '你可以把電鍋的線拔掉，讓他不知道電\n鍋沒電，或是把開關得只是換掉'
                      : '你可以先記下今天的狀態，晚一點再和患者確認。',
                ),
              ),
              Positioned.fill(
                top: 318,
                bottom: 138,
                child: _MessageCloud(messages: _messages),
              ),
              Positioned(
                left: 46,
                right: 46,
                bottom: 90,
                child: _PromptCard(
                  height: 48,
                  text: '那如果他一直堅持要用電鍋煮飯呢?',
                  fontSize: 13,
                ),
              ),
              Positioned(
                left: 30,
                right: 30,
                bottom: 22,
                child: CadiInputPill(
                  controller: _inputController,
                  onSend: _send,
                  hintText: '',
                  showPlus: true,
                  accentColor: widget.mode == ChatMode.client
                      ? AppColors.peach
                      : const Color(0xFF6EA6C9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PromptCard extends StatelessWidget {
  final String text;
  final double height;
  final double fontSize;

  const _PromptCard({required this.text, this.height = 78, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTextStyles.body(
          context,
        ).copyWith(color: Colors.black, fontSize: fontSize, height: 1.65),
      ),
    );
  }
}

class _MessageCloud extends StatelessWidget {
  final List<_Message> messages;

  const _MessageCloud({required this.messages});

  @override
  Widget build(BuildContext context) {
    final layout = [
      const Offset(44, 0),
      const Offset(242, 52),
      const Offset(42, 116),
      const Offset(278, 188),
      const Offset(42, 244),
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: List.generate(messages.length.clamp(0, layout.length), (
            index,
          ) {
            final message = messages[index];
            final offset = layout[index];
            final width = message.isUser ? 126.0 : 138.0;
            return Positioned(
              left: offset.dx.clamp(18, constraints.maxWidth - width - 18),
              top: offset.dy,
              child: _FloatingBubble(text: message.text, width: width),
            );
          }),
        );
      },
    );
  }
}

class _FloatingBubble extends StatelessWidget {
  final String text;
  final double width;

  const _FloatingBubble({required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 14,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Text(
        text,
        style: AppTextStyles.caption(
          context,
        ).copyWith(color: AppColors.primaryText, fontSize: 9, height: 1.55),
      ),
    );
  }
}
