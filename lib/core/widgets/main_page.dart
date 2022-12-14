import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/screen_state.dart';
import 'package:itdols/features/jobs/presentation/jobs_page.dart';
import 'package:itdols/features/places/presentation/places_page.dart';
import 'package:itdols/features/routes/presentation/routes_page.dart';

class MainPage extends ConsumerWidget {
  MainPage({super.key});

  int _curentPage = 0;

  var pages = {
    0: Container(), // TODO: swap to calculation screen
    1: JobsPage(),
    2: PlacesPage(),
    3: RoutePage(),
  };

  var icons = {
    0: {'icon': Icons.timeline, 'selectedIcon': Icons.timeline, 'label': 'Расчёт'},
    1: {'icon': Icons.cases_outlined, 'selectedIcon': Icons.cases_rounded, 'label': 'Дела'},
    2: {'icon': Icons.place_outlined, 'selectedIcon': Icons.place, 'label': 'Места'},
    3: {'icon': Icons.route_outlined, 'selectedIcon': Icons.route, 'label': 'Пути'},
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _curentPage = ref.watch(screenStateHolder);
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            NavigationRail(
              labelType: NavigationRailLabelType.all,
              selectedIndex: _curentPage,
              onDestinationSelected: (value) => ref.read(screenStateHolder.notifier).setScreen(value),
              destinations: List.generate(
                icons.length,
                (index) => NavigationRailDestination(
                  icon: Icon(icons[index]!['icon'] as IconData),
                  selectedIcon: Icon(icons[index]!['selectedIcon'] as IconData),
                  label: Text(icons[index]!['label'] as String),
                ),
              ),
            ),
            const VerticalDivider(
              width: 1,
              thickness: 1,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (p0, p1) => pages[_curentPage] as Widget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
