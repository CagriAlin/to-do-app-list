import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:to_do_app_list/shared/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.white,
  bool isUpperCase = false,
  double radius = 3.0,
  @required Function? function,
  @required String? text,
}) {
  return Container();
}

Widget defaultTextField({
  @required TextEditingController? controller,
  @required TextInputType? type,
  Function()? onTap,
  Function(String)? onChange,
  @required String? Function(String?)? onValidate,
  String Function(String?)? onSubmit,
  bool isPassword = false,
  @required String? label,
  @required IconData? prefix,
  IconData? suffix,
  Function()? suffixPress,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    onChanged: onChange,
    onTap: onTap,
    onFieldSubmitted: onSubmit,
    validator: onValidate,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(onPressed: suffixPress, icon: Icon(suffix))
          : null,
      border: OutlineInputBorder(),
    ),
  );
}

Widget buildTaskItem(Map? model, context) {
  AppCubit cubit = AppCubit.get(context);
  return Dismissible(
    onDismissed: (direction) {
      cubit.deleteRows(model!['id']);
    },
    key: Key(model!['id'].toString()),
    child: Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 35.0,
              child: Text('${model['time']}'),
            ),
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${model['date']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                cubit.updateDB(status: 'done', id: model['id']);
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () {
                cubit.updateDB(status: 'delete', id: model['id']);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ],
      ),
    ),
  );
}

Widget buildTask({BuildContext? context, List<Map?>? tasks}) {
  return Conditional.single(
    context: context!,
    widgetBuilder: (context) => ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(tasks![index], context),
      separatorBuilder: (context, index) =>
          Container(width: double.infinity, height: 1.0),
      itemCount: tasks!.length,
    ),
    conditionBuilder: (context) => tasks!.length > 0,
    fallbackBuilder: (context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Image(
            image: AssetImage('assets/to-do-list.png'),
            fit : BoxFit.fill,
          ),
          Text(
            'No Tasks added yet start add some',
            style: TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
