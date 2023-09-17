import 'package:api_learning/cubit/note_state.dart';
import 'package:api_learning/repository/notes_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/notes.dart';

class NoteAddCubit extends Cubit<NoteState> {
  NoteAddCubit({required this.notesRepository}) : super(NoteInitialState());
  final NotesRepository notesRepository;

  addNotes({required String title, required String body}) async {
    emit(NoteLoadingState());
    final _res = await notesRepository.addNotes(title: title, body: body);
    if(_res.status){
      emit(NoteSuccessState(notes: _res.data.cast<Notes>()));

    }else{
      emit(NoteErrorState(message: _res.message));//DataResponse.dart
    }
  }
 

  
  
}
