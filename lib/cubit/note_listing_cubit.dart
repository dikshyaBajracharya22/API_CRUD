import 'dart:async';

import 'package:api_learning/cubit/note_delete_cubit.dart';
import 'package:api_learning/cubit/note_state.dart';
import 'package:api_learning/repository/notes_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/notes.dart';

class NoteListingCubit extends Cubit<NoteState> {
  NoteListingCubit(
      {required this.notesRepository, required this.noteDeleteCubit})
      : super(NoteInitialState()) {
   
    noteDeleteSubscription = noteDeleteCubit.stream.listen((event) {
      //reload after delete InterBlocConnection
      if (event is NoteSuccessState) {
        print(notesRepository.notes);
        // fetchNotes();
      }
    });
  }

  final NotesRepository notesRepository;
  final NoteDeleteCubit noteDeleteCubit;

  StreamSubscription? noteDeleteSubscription;

  _refreshNotes() {
    //not to reload whole api after delete but the part only
    emit(NoteLoadingState());
    emit(NoteSuccessState(notes: notesRepository.notes));
  }

//load api datas
  fetchNotes() async {
    emit(NoteLoadingState());
    final _res = await notesRepository.fetchNotes();
    // if(_res["status"]==true){
    //from this
    if (_res.status) {
      //true
      // emit(NoteSuccessState(notes: List.of(_res["data"]).cast<Notes>()));
      //from this

      emit(NoteSuccessState(
          notes: _res.data.cast<
              Notes>())); 
    } else {
      emit(NoteErrorState(message: _res.message));
    }
  }

  @override
  Future<void> close() {
    noteDeleteSubscription?.cancel();
    // TODO: implement close
    return super.close();
  }
}
