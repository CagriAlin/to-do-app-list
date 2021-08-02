import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_list/shared/cubit/states.dart';
import 'package:to_do_app_list/shared/components.dart';
import 'package:to_do_app_list/shared/cubit/cubit.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).newTasks;
          return buildTask(tasks: tasks, context: context);
        });
  }
}
