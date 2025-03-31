import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:server_driven_ui/core/injections/injection.dart';
import 'package:server_driven_ui/core/utils/app_colors.dart';
import 'package:server_driven_ui/core/utils/app_strings.dart';
import 'package:server_driven_ui/features/dashboard/presentation/bloc/dashboard_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final DashboardBloc dashboardBloc;
  late PageController _pageController;
  int currentIndex = 0;
  List<Map<String, dynamic>> bottomNavItems = [];
  Map<String, dynamic> screens = {};

  @override
  void initState() {
    super.initState();
    dashboardBloc = sl<DashboardBloc>();
    _pageController = PageController();
    fetchRemoteConfig();
  }

  void fetchRemoteConfig() {
    dashboardBloc.add(FetchRemoteConfig(screenId: AppString.dashboardScreen));
  }

  void onNavTapped(int index) {
    setState(() => currentIndex = index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      bloc: dashboardBloc,
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is DashboardSuccess) {
          bottomNavItems = List<Map<String, dynamic>>.from(
            state.remoteConfigData['bottomNavBar'] ?? [],
          );
          screens = Map<String, dynamic>.from(
            state.remoteConfigData['screens'] ?? {},
          );

          return Scaffold(
            appBar: buildAppBar(bottomNavItems[currentIndex]['navigation']),
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children:
                  bottomNavItems
                      .map((item) => _buildScreen(item['navigation']))
                      .toList(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor:
                  state.remoteConfigData['bottomNavBarBackground'] != null
                      ? AppColors.parseColor(
                        state.remoteConfigData['bottomNavBarBackground'],
                      )
                      : Colors.red,
              currentIndex: currentIndex,
              onTap: onNavTapped,
              selectedItemColor: AppColors.parseColor(
                bottomNavItems[currentIndex]['color'],
              ),
              items:
                  bottomNavItems.map((item) {
                    return BottomNavigationBarItem(
                      icon: Icon(
                        _getIconData(item['iconData']),
                        color: AppColors.parseColor(item['color']),
                      ),
                      label: item['label'],
                    );
                  }).toList(),
            ),
          );
        } else if (state is DashboardFailure) {
          return Scaffold(body: Center(child: Text(state.error)));
        }
        return const SizedBox.shrink();
      },
    );
  }

  /// Builds the App Bar dynamically
  AppBar buildAppBar(String screenKey) {
    var screenData = screens[screenKey] ?? {};
    return AppBar(
      title: Text(
        screenData['appBar']['title'] ?? '',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: AppColors.parseColor(
        screenData['appBar']['backgroundColor'] ?? "#000000",
      ),
    );
  }

  /// Builds the screen body dynamically
  Widget _buildScreen(String screenKey) {
    var screenData = screens[screenKey] ?? {};
    return Center(
      child: Text(
        screenData['body']['value'] ?? 'No content available',
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    return _iconMap[iconName] ?? Icons.help_outline;
  }

  static final Map<String, IconData> _iconMap = {
    "home": Icons.home,
    "work": Icons.work,
    "person": Icons.person,
    "settings": Icons.settings,
    "dashboard": Icons.dashboard,
    "notifications": Icons.notifications,
    "search": Icons.search,
    "favorite": Icons.favorite,
    "info": Icons.info,
    "message": Icons.message,
    "shopping_cart": Icons.shopping_cart,
    "services": Icons.room_service,
    "call": Icons.call,
  };
}
