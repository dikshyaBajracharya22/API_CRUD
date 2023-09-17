import 'package:api_learning/cubit/note_add_cubit.dart';
import 'package:api_learning/cubit/note_listing_cubit.dart';
import 'package:api_learning/cubit/note_state.dart';
import 'package:api_learning/cubit/notes_update_cubit.dart';
import 'package:api_learning/utils/snackbar_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
//Post or Update Page
import 'model/notes.dart';

//=================================Post============================
class NotesForm extends StatefulWidget {
  final Notes? notes; //Notes.dart
  const NotesForm({Key? key, this.notes}) : super(key: key);

  @override
  State<NotesForm> createState() => _NotesFormState();
}

class _NotesFormState extends State<NotesForm> {
  TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _bodycontroller = TextEditingController();
  // TextEditingController _userIdController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //=============================Edit/Update=============================
    _titlecontroller.text =
        widget.notes?.title ?? ""; 
    _bodycontroller.text = widget.notes?.body ??
        ""; 
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NoteAddCubit, NoteState>(
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
              SnackbarUtils.showSnackBar(
                  context: context,
                  message: "Notes added succesfully");
              context
                  .read<NoteListingCubit>()
                  .fetchNotes(); // to reload the data after save
              Navigator.of(context).pop();
            } else if (state is NoteErrorState) {
              SnackbarUtils.showSnackBar(
                  context: context, message: state.message);
            }
            // TODO: implement listener
          },
        ),
       BlocListener<NoteUpdateCubit, NoteState>(
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
              SnackbarUtils.showSnackBar(
                  context: context,
                  message: "Notes updated succesfully");
              context
                  .read<NoteListingCubit>()
                  .fetchNotes(); // to reload the data after save
              Navigator.of(context).pop();
            } else if (state is NoteErrorState) {
              SnackbarUtils.showSnackBar(
                  context: context, message: state.message);
            }
            // TODO: implement listener
          },
        ),
      ],
      child: LoadingOverlay(
        isLoading: _isLoading,
        child: Scaffold(
          appBar: AppBar(),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text("Title"),
                TextFormField(
                  controller: _titlecontroller,
                  decoration: InputDecoration(hintText: "Title"),
                ),
                SizedBox(height: 20),
                Text("Body"),
                SizedBox(height: 4),
                TextFormField(
                  controller: _bodycontroller,
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintText: "Body", border: OutlineInputBorder()),
                ),

                // SizedBox(height: 20),
                // TextFormField(
                //   controller: _userIdController,
                //   decoration: InputDecoration(hintText: "User Id"),
                // ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: Colors.red,
                        onPressed: () async {
                          if (widget.notes == null) {//parameter null means add page
                            context.read<NoteAddCubit>().addNotes(
                                title: _titlecontroller.text,
                                body: _bodycontroller.text);
                          } else {
                            context.read<NoteUpdateCubit>().updateNotes(
                                id: widget.notes!.id,
                                title: _titlecontroller.text,
                                body: _bodycontroller.text);
                          }
                        },
                        child: Text(
                          widget.notes == null ? "Save" : "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
























// import 'package:api_learning/cubit/note_add_cubit.dart';
// import 'package:api_learning/cubit/note_listing_cubit.dart';
// import 'package:api_learning/cubit/note_state.dart';
// import 'package:api_learning/cubit/notes_update.dart';
// import 'package:api_learning/providers/notes_provider.dart';
// import 'package:api_learning/utils/snackbar_utils.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loading_overlay/loading_overlay.dart';
// import 'package:provider/provider.dart';
// //Post or Update Page
// import 'notes.dart';

// //=================================Post============================
// class NotesForm extends StatefulWidget {
//   final Notes? notes; //Notes.dart
//   const NotesForm({Key? key, this.notes}) : super(key: key);

//   @override
//   State<NotesForm> createState() => _NotesFormState();
// }

// class _NotesFormState extends State<NotesForm> {
//   TextEditingController _titlecontroller = TextEditingController();
//   TextEditingController _bodycontroller = TextEditingController();
//   // TextEditingController _userIdController = TextEditingController();
//   bool _isLoading = false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //=============================Edit/Update=============================
//     _titlecontroller.text =
//         widget.notes?.title ?? ""; //initially vairakhney update ko lagi
//     _bodycontroller.text = widget.notes?.body ??
//         ""; //notes ko value agadi _notesProvider.notes[index] rakhecha update garni case ma  so . body garepachi api ko body insert huncha
//     //ani post matra garni case ma notes vanni parmeter empty so ?? ""yo condiodion meet huncha ani post ma khali texfield aucha
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocListener(
//       listeners: [
//         BlocListener<NoteAddCubit, NoteState>(
//           listener: (context, state) {
//             if (state is NoteLoadingState) {
//               setState(() {
//                 _isLoading = true;
//               });
//             } else {
//               setState(() {
//                 _isLoading = false;
//               });
//             }
//             if (state is NoteSuccessState) {
//               SnackbarUtils.showSnackBar(
//                   context: context,
//                   message: "Notes updates succesfully");
//               context
//                   .read<NoteListingCubit>()
//                   .fetchNotes(); // to reload the data after save
//               Navigator.of(context).pop();
//             } else if (state is NoteErrorState) {
//               SnackbarUtils.showSnackBar(
//                   context: context, message: state.message);
//             }
//             // TODO: implement listener
//           },
//         ),
//        BlocListener<NoteUpdateCubit, NoteState>(
//           listener: (context, state) {
//             if (state is NoteLoadingState) {
//               setState(() {
//                 _isLoading = true;
//               });
//             } else {
//               setState(() {
//                 _isLoading = false;
//               });
//             }
//             if (state is NoteSuccessState) {
//               SnackbarUtils.showSnackBar(
//                   context: context,
//                   message: "Notes updated succesfully");
//               context
//                   .read<NoteListingCubit>()
//                   .fetchNotes(); // to reload the data after save
//               Navigator.of(context).pop();
//             } else if (state is NoteErrorState) {
//               SnackbarUtils.showSnackBar(
//                   context: context, message: state.message);
//             }
//             // TODO: implement listener
//           },
//         ),
//       ],
//       child: LoadingOverlay(
//         isLoading: _isLoading,
//         child: Scaffold(
//           appBar: AppBar(),
//           body: Container(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 20),
//                 Text("Title"),
//                 TextFormField(
//                   controller: _titlecontroller,
//                   decoration: InputDecoration(hintText: "Title"),
//                 ),
//                 SizedBox(height: 20),
//                 Text("Body"),
//                 SizedBox(height: 4),
//                 TextFormField(
//                   controller: _bodycontroller,
//                   maxLines: 4,
//                   decoration: InputDecoration(
//                       hintText: "Body", border: OutlineInputBorder()),
//                 ),

//                 // SizedBox(height: 20),
//                 // TextFormField(
//                 //   controller: _userIdController,
//                 //   decoration: InputDecoration(hintText: "User Id"),
//                 // ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: MaterialButton(
//                         color: Colors.red,
//                         onPressed: () async {
//                           if (widget.notes == null) {//parameter null means add page
//                             context.read<NoteAddCubit>().addNotes(
//                                 title: _titlecontroller.text,
//                                 body: _bodycontroller.text);
//                           } else {
//                             context.read<NoteUpdateCubit>().updateNotes(
//                                 id: widget.notes!.id,
//                                 title: _titlecontroller.text,
//                                 body: _bodycontroller.text);
//                           }
//                         },
//                         child: Text(
//                           widget.notes == null ? "Save" : "Update",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
