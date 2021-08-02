import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_list/layouts/home_layouts.dart';
import 'package:to_do_app_list/shared/cubit/cubit.dart';
import 'bloc_observer.dart';
import 'package:flutter/services.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([]);
    return BlocProvider(
        create: (context) => AppCubit()..createDB(),
        child: MaterialApp(home: HomeLayout(),
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          debugShowCheckedModeBanner: false,
        ));

  }
}

