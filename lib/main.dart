import 'package:course_travel/common/app_route.dart';
import 'package:course_travel/injection.dart';
import 'package:course_travel/presentation/bloc/all_destination/all_destination_bloc_bloc.dart';
import 'package:course_travel/presentation/bloc/search_destination/search_destination_bloc.dart';
import 'package:course_travel/presentation/bloc/top_destination/top_destination_bloc.dart';
import 'package:course_travel/presentation/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((_) => DashboardCubit())),
        BlocProvider(create: ((_) => locator<AllDestinationBlocBloc>())),
        BlocProvider(create: ((_) => locator<TopDestinationBloc>())),
        BlocProvider(create: ((_) => locator<SearchDestinationBloc>())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: AppRoute.dashboard,
        onGenerateRoute: AppRoute.onGenerateRoute,
      )
    );
  }
}
