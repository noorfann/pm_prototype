import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pm_prototype/cubit/menu/menu_cubit.dart';
import 'package:pm_prototype/presentation/widgets/popup_helper.dart';
import 'package:pm_prototype/routes/routes.dart';

class CustomSideMenu extends StatefulWidget {
  const CustomSideMenu({super.key});

  @override
  State<CustomSideMenu> createState() => _CustomSideMenuState();
}

class _CustomSideMenuState extends State<CustomSideMenu> {
  bool _isExpanded = false;
  Map<String, bool> _hoveredItems = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surface,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      AssetImage('assets/images/logo.png'), // Add your logo
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Task Management',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Zulfikar N',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildMenuItem(
                      context,
                      icon: Icons.home,
                      title: 'Home',
                      route: rootScreen,
                      selected: state.selectedRoute == rootScreen,
                    ),
                    ExpansionTile(
                      leading: Icon(Icons.storage, color: Colors.white),
                      title: Text('Master Data',
                          style: TextStyle(color: Colors.white)),
                      trailing: Icon(
                          _isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.white),
                      onExpansionChanged: (expanded) {
                        setState(() {
                          _isExpanded = expanded;
                        });
                      },
                      children: [
                        _buildMenuItem(
                          context,
                          icon: Icons.key,
                          title: 'Role',
                          route: roleScreen,
                          selected: state.selectedRoute == roleScreen,
                          indent: true,
                        ),
                        _buildMenuItem(
                          context,
                          icon: Icons.people,
                          title: 'Employee',
                          route: employeeScreen,
                          selected: state.selectedRoute == employeeScreen,
                          indent: true,
                        ),
                        _buildMenuItem(
                          context,
                          icon: Icons.list_alt,
                          title: 'Criteria',
                          route: criteriaScreen,
                          selected: state.selectedRoute == criteriaScreen,
                          indent: true,
                        ),
                        _buildMenuItem(
                          context,
                          icon: Icons.work,
                          title: 'Projects',
                          route: projectsScreen,
                          selected: state.selectedRoute == projectsScreen,
                          indent: true,
                        ),
                      ],
                    ),
                    ExpansionTile(
                      leading: Icon(Icons.abc, color: Colors.white),
                      title: Text('Profile Matching',
                          style: TextStyle(color: Colors.white)),
                      trailing: Icon(
                          _isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.white),
                      onExpansionChanged: (expanded) {
                        setState(() {
                          _isExpanded = expanded;
                        });
                      },
                      children: [
                        _buildMenuItem(
                          context,
                          icon: Icons.assessment,
                          title: 'Assesment',
                          route: roleScreen,
                          selected: state.selectedRoute == roleScreen,
                          indent: true,
                        ),
                        _buildMenuItem(
                          context,
                          icon: Icons.task,
                          title: 'Tasks',
                          route: employeeScreen,
                          selected: state.selectedRoute == employeeScreen,
                          indent: true,
                        ),
                      ],
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.exit_to_app,
                      title: 'Logout',
                      isLogout: true,
                      onTap: () {
                        PopupHelper.showConfirmationPopup(context,
                            title: 'Are you sure want to logout?',
                            confirmText: 'Yes');
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? route,
    bool selected = false,
    bool indent = false,
    bool isLogout = false,
    VoidCallback? onTap,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredItems[title] = true),
      onExit: (_) => setState(() => _hoveredItems[title] = false),
      child: Container(
        color: selected
            ? Theme.of(context).colorScheme.primary
            : _hoveredItems[title] == true
                ? Theme.of(context).colorScheme.primary
                : Colors.transparent,
        child: ListTile(
          leading: Icon(
            icon,
            color: isLogout ? Colors.red : Colors.white,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isLogout ? Colors.red : Colors.white,
            ),
          ),
          contentPadding: EdgeInsets.only(
            left: indent ? 32 : 16,
            right: 16,
          ),
          onTap: onTap ??
              () {
                if (route != null) {
                  context.read<MenuCubit>().updateSelectedRoute(route);
                  context.go(route);
                }
              },
        ),
      ),
    );
  }
}
