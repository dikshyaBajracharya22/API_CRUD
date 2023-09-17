import 'package:api_learning/cubit/note_add_cubit.dart';
import 'package:api_learning/cubit/note_delete_cubit.dart';
import 'package:api_learning/cubit/note_listing_cubit.dart';
import 'package:api_learning/cubit/note_state.dart';
import 'package:api_learning/model/notes.dart';
import 'package:api_learning/notes_form_add.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

//==========Get=====================
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NoteListingCubit>().fetchNotes(); // get datas
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteDeleteCubit, NoteState>(
      listener: (context, state) {
        if (state is NoteLoadingState) {
          setState(() {
            _isLoading = true;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }

        if (state is NoteSuccessState) {
        //reload after delete
          context.read<NoteListingCubit>().fetchNotes();
          

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            "Deleted",
            maxLines: 1,
          )));
        } else if (state is NoteErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            "Deleted",
            maxLines: 1,
          )));
        }
        // TODO: implement listener
      },
      child: LoadingOverlay(
        isLoading: _isLoading,
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final _result = await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        NotesForm())); 
                if (_result == true) {
                  // to reload afai after upload
                  setState(() {});
                }
              },
              child: Icon(Icons.add),
            ),
            appBar: AppBar(
              title: Text("Api Demo"),
            ),
            body: BlocBuilder<NoteListingCubit,
                    NoteState> //BlocBuilder checks all states
                (builder: (context, state) {
              if (state is NoteLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is NoteErrorState) {
                return Container(
                  child: Text(state.message),
                );
              } else if (state is NoteSuccessState) {
                return ListView.builder(
                    itemCount: state.notes
                        .length, 
                    itemBuilder: ((context1, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NotesForm(
                                    notes: state.notes[index])));
                          },
                          // title: Text(snapshot.data![index]["title"]),
                          title: Text(state.notes[index].title),
                          subtitle: Text(state.notes[index].body),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              await context
                                  .read<NoteDeleteCubit>()
                                  .deleteNote(id: state.notes[index].id);
                            },
                          ),
                        ),
                      );
                    }));
              } else {
                return Container();
              }
            })),
      ),
    );
  }
}
