import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ─── Placeholder screens ───────────────────────────────────────────────────
// Replace these with your actual screen widgets.
class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderPage(label: 'Booking');
}

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderPage(label: 'Community');
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderPage(label: 'Home');
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderPage(label: 'Messages');
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderPage(label: 'Profile');
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      );
}

// ─── Nav Item Model ─────────────────────────────────────────────────────────

class NavItem {
  final String title;
  final IconData icon;
  final IconData activeIcon; // filled variant for selected state
  final int? badgeCount;    // optional notification badge

  const NavItem({
    required this.title,
    required this.icon,
    IconData? activeIcon,
    this.badgeCount,
  }) : activeIcon = activeIcon ?? icon;
}

// ─── Controller ─────────────────────────────────────────────────────────────

class BottomNavController extends GetxController {
  final RxInt currentIndex = 2.obs; // default to Home (index 2)

  // ── Nav items — add/remove/reorder freely ──────────────────────────────
  final List<NavItem> items = const [
    NavItem(
      title: 'Booking',
      icon: Icons.book_online_outlined,
      activeIcon: Icons.book_online,
    ),
    NavItem(
      title: 'Community',
      icon: Icons.group_outlined,
      activeIcon: Icons.group,
    ),
    NavItem(
      title: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
    ),
    NavItem(
      title: 'Messages',
      icon: Icons.chat_bubble_outline,
      activeIcon: Icons.chat_bubble,
      badgeCount: 3, // example badge
    ),
    NavItem(
      title: 'Profile',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];

  // ── Screens — keep in the same order as items ──────────────────────────
  final List<Widget> screens = const [
    BookingScreen(),
    CommunityScreen(),
    HomeScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  // ── Actions ────────────────────────────────────────────────────────────
  void changeIndex(int index) {
    assert(index >= 0 && index < items.length, 'Index out of range');
    currentIndex.value = index;
  }

  void goTo(String tabTitle) {
    final idx = items.indexWhere(
      (e) => e.title.toLowerCase() == tabTitle.toLowerCase(),
    );
    if (idx != -1) changeIndex(idx);
  }
}