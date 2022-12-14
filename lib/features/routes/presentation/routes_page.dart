import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/widgets/header_widget.dart';
import 'package:itdols/features/routes/domain/models/route_model.dart';
import 'package:itdols/features/routes/domain/states/routes_state.dart';
import 'package:itdols/features/routes/presentation/route_widget.dart';
import 'package:itdols/features/routes/routes_controller.dart';

class RoutePage extends ConsumerWidget {
  RoutePage({super.key});

  List<RouteModel>? routes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    routes = ref.watch(routesStateHolder);
    ref.read(routesController).getPlaces();
    return Column(
      children: [
        const HeaderWidget(
          label: 'Список путей',
        ),
        if (routes != null)
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: routes!.length,
              itemBuilder: (BuildContext context, int index) => RouteWidget(route: routes![index]),
              separatorBuilder: (BuildContext context, int index) => const Divider(
                color: Colors.grey,
                height: 1,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
            ),
          )
        else
          const Expanded(child: Center(child: CircularProgressIndicator())),
      ],
    );
  }
}
