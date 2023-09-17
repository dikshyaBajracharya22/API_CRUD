import 'package:api_learning/cubit/note_add_cubit.dart';
import 'package:api_learning/cubit/note_listing_cubit.dart';
import 'package:api_learning/repository/notes_repository.dart';
import 'package:api_learning/wrapper/multi_bloc_wrapper.dart';
import 'package:api_learning/wrapper/multi_repository_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryWrapper(
      
      child: MultiBlocWrapper(
       
        child: MaterialApp(
          title: "Api Demo",
          home: HomePage(),
        ),
      ),
    );
  }
}
