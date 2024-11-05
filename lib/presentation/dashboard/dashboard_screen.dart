import 'package:flutter/material.dart';
import 'package:pm_prototype/presentation/dashboard/custom_side_menu.dart';
// import 'package:sidebarx/sidebarx.dart';

class DashboardScreen extends StatefulWidget {
  final Widget child;
  const DashboardScreen({super.key, required this.child});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return Scaffold(
          key: _key,
          body: Row(
            children: [
              if (!isSmallScreen) CustomSideMenu(),
              Expanded(
                child: Center(
                  child: widget.child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
