import 'package:api_learning/cubit/note_state.dart';
import 'package:api_learning/repository/notes_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/notes.dart';

class NoteDeleteCubit extends Cubit<NoteState> {
  NoteDeleteCubit({required this.notesRepository}) : super(NoteInitialState());
  final NotesRepository notesRepository;

  deleteNote({required int id}) async {
    emit(NoteLoadingState());
    final _res = await notesRepository.deleteNotes(id: id);
    if(_res.status){//true //DataResponse.dart
      emit(NoteSuccessState(notes: _res.data.cast<Notes>()));//note type mageko state bata

    }else{
      emit(NoteErrorState(message: _res.message));//DataResponse.dart
    }
  }
  
  
}
