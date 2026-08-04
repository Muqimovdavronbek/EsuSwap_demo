import 'package:flutter/material.dart';

import '../components/bottom_nav_bar.dart';
import '../data/mock_data.dart';
import '../models/skill_models.dart';
import '../screens/auth_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/explore_screen.dart';
import '../screens/home_feed_screen.dart';
import '../screens/leaderboard_screen.dart';
import '../screens/matching_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/skill_profile_screen.dart';

enum ShellScreen { onboarding, auth, main, notifications, skillProfile, leaderboard }

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  ShellScreen _screen = ShellScreen.onboarding;
  NavTab _tab = NavTab.home;
  String? _selectedUserId;
  NavTab _returnTab = NavTab.home;
  String? _chatUserId;

  void _goMain([NavTab tab = NavTab.home]) {
    setState(() {
      _screen = ShellScreen.main;
      _tab = tab;
    });
  }

  void _openProfile(String userId) {
    setState(() {
      _selectedUserId = userId;
      _returnTab = _tab;
      _screen = ShellScreen.skillProfile;
    });
  }

  void _openCard(SkillCard card) => _openProfile(card.user.id);

  Widget _buildBody() {
    switch (_screen) {
      case ShellScreen.onboarding:
        return OnboardingScreen(onGetStarted: () => setState(() => _screen = ShellScreen.auth));
      case ShellScreen.auth:
        return AuthScreen(onBack: () => setState(() => _screen = ShellScreen.onboarding), onAuth: () => _goMain());
      case ShellScreen.notifications:
        return NotificationsScreen(onBack: () => _goMain(_tab));
      case ShellScreen.skillProfile:
        final user = mockUsers.firstWhere((u) => u.id == _selectedUserId, orElse: () => mockUsers.first);
        return SkillProfileScreen(
          user: user,
          onBack: () => _goMain(_returnTab),
          onMessage: () {
            setState(() {
              _chatUserId = user.id;
              _screen = ShellScreen.main;
              _tab = NavTab.messages;
            });
          },
        );
      case ShellScreen.leaderboard:
        return LeaderboardScreen(onBack: () => _goMain(_tab));
      case ShellScreen.main:
        switch (_tab) {
          case NavTab.home:
            return HomeFeedScreen(
              onCardClick: _openCard,
              onNotificationsClick: () => setState(() => _screen = ShellScreen.notifications),
              onLeaderboardClick: () => setState(() => _screen = ShellScreen.leaderboard),
              notificationCount: 2,
            );
          case NavTab.explore:
            return ExploreScreen(onUserClick: _openProfile);
          case NavTab.match:
            return MatchingScreen(
              onMatch: (userId) {
                setState(() => _chatUserId = userId);
                Future.delayed(const Duration(milliseconds: 550), () {
                  if (!mounted) return;
                  _goMain(NavTab.messages);
                });
              },
            );
          case NavTab.messages:
            return ChatScreen(userId: _chatUserId, onBack: () => setState(() => _chatUserId = null));
          case NavTab.profile:
            return const ProfileScreen();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final showNav = _screen == ShellScreen.main;
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: showNav
          ? EduBottomNavBar(
              activeTab: _tab,
              messageCount: 1,
              onChanged: (tab) => setState(() => _tab = tab),
            )
          : null,
    );
  }
}
