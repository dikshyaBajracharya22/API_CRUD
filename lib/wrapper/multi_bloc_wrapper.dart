import 'package:api_learning/cubit/note_delete_cubit.dart';
import 'package:api_learning/cubit/notes_update_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/note_add_cubit.dart';
import '../cubit/note_listing_cubit.dart';
import '../repository/notes_repository.dart';

class MultiBlocWrapper extends StatelessWidget {
  final Widget child;
  const MultiBlocWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NoteDeleteCubit(
            notesRepository: RepositoryProvider.of<NotesRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => NoteListingCubit(
            noteDeleteCubit: BlocProvider.of<NoteDeleteCubit>(context),
            notesRepository: RepositoryProvider.of<NotesRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => NoteAddCubit(
            notesRepository: RepositoryProvider.of<NotesRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => NoteUpdateCubit(
            notesRepository: RepositoryProvider.of<NotesRepository>(context),
          ),
        ),
      ],
      child: child,
    );
  }
}
