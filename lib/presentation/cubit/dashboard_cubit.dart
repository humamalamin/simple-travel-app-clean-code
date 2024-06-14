
import 'package:course_travel/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardCubit extends Cubit<int> {
  DashboardCubit() : super(0);

  change(int i) => emit(i);

  final List menuDashboard =  [
    ['Home', Icons.home, const HomePage()],
    ['Near', Icons.near_me, const Center(child: Text('Near'),)],
    ['Favorite', Icons.favorite, const Center(child: Text('Favorite'),)],
    ['Profile', Icons.person, const Center(child: Text('Profile'),)],
  ];

  Widget getPage() => menuDashboard[state][2];
}