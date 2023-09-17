
import '../model/notes.dart';

abstract class NoteState {}

class NoteInitialState extends NoteState {}

class NoteLoadingState extends NoteState {}

class NoteSuccessState extends NoteState {
  final List<Notes> notes;// note type 
  NoteSuccessState({required this.notes});
}

class NoteErrorState extends NoteState {
  void test(){
   
  }
  final String message;
  NoteErrorState({required this.message});

}
