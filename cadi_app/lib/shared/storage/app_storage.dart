import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';

/// Single-box local persistence for demo state.
///
/// Stores everything keyed in one Hive box so reopening the app
/// resumes where the user left off (chosen mode, onboarding inputs,
/// chat messages, mood selection, etc.).
class AppStorage {
  static const _boxName = 'cadi_app_state';

  static const _kMode = 'mode'; // 'client' | 'family'
  static const _kOnboardingDone = 'onboarding_done';
  static const _kOnboardingText = 'onboarding_text';
  static const _kOnboardingImage = 'onboarding_image';
  static const _kOnboardingTag = 'onboarding_tag';
  static const _kMoodIndex = 'mood_index';

  static late Box _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  static Box get box => _box;

  // ── Mode ────────────────────────────────────────────────
  static String? get lastMode => _box.get(_kMode) as String?;
  static Future<void> setMode(String mode) => _box.put(_kMode, mode);

  // ── Onboarding ──────────────────────────────────────────
  static bool get onboardingDone =>
      (_box.get(_kOnboardingDone) as bool?) ?? false;
  static Future<void> setOnboardingDone(bool v) =>
      _box.put(_kOnboardingDone, v);

  static String get onboardingText =>
      (_box.get(_kOnboardingText) as String?) ?? '';
  static Future<void> setOnboardingText(String v) =>
      _box.put(_kOnboardingText, v);

  static Uint8List? get onboardingImage {
    final v = _box.get(_kOnboardingImage);
    if (v == null) return null;
    if (v is Uint8List) return v;
    if (v is List) return Uint8List.fromList(v.cast<int>());
    return null;
  }

  static Future<void> setOnboardingImage(Uint8List bytes) =>
      _box.put(_kOnboardingImage, bytes);

  static String? get onboardingTag => _box.get(_kOnboardingTag) as String?;
  static Future<void> setOnboardingTag(String tag) =>
      _box.put(_kOnboardingTag, tag);

  // ── Mood ────────────────────────────────────────────────
  static int get moodIndex => (_box.get(_kMoodIndex) as int?) ?? 1;
  static Future<void> setMoodIndex(int v) => _box.put(_kMoodIndex, v);

  // ── Chat messages ───────────────────────────────────────
  // Stored as a list of "u:..." / "b:..." prefixed strings.
  static String _chatKey(String mode) => 'chat_$mode';

  static List<ChatRecord> loadChat(String mode) {
    final raw = _box.get(_chatKey(mode));
    if (raw is! List) return const [];
    return raw
        .cast<String>()
        .map((s) => ChatRecord(
              text: s.length > 2 ? s.substring(2) : '',
              isUser: s.startsWith('u:'),
            ))
        .toList();
  }

  static Future<void> saveChat(String mode, List<ChatRecord> messages) {
    final encoded = messages
        .map((m) => '${m.isUser ? 'u' : 'b'}:${m.text}')
        .toList(growable: false);
    return _box.put(_chatKey(mode), encoded);
  }

  static Future<void> clearAll() => _box.clear();
}

class ChatRecord {
  final String text;
  final bool isUser;
  const ChatRecord({required this.text, required this.isUser});
}
