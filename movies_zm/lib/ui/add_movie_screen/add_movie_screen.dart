import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/add_movies_data.dart';
import '../../core/models/movies_data.dart';
import '../../core/services/add_movies_service.dart';
import '../../core/validation/validator.dart';
import '../../providers/movies/movies_provider.dart';
import '../../shared/bottom_animation.dart';

import '../../shared/image_widget/image_widget.dart';
import '../movies_screen/movies_screen.dart';
import 'widget/form_data.dart';

class AddMovieScreen extends StatefulWidget with Validator {
  static const route = '/addMoviesScreen';
  AddMovieScreen({Key key}) : super(key: key);

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

final _formKey = GlobalKey<FormState>();

class _AddMovieScreenState extends State<AddMovieScreen> {
  Future<void> uploadImage() async {
    _formKey.currentState.save();
    final moviesData = ModalRoute.of(context).settings.arguments as MoviesData;
    if (moviesData != null) {
      await context.read<MoviesServices>().updateMovie(
          AddMoviesData(
              name: _formData.name != '' ? _formData.name : moviesData.title,
              publicationYear: _formData.publicationYear != ''
                  ? _formData.publicationYear
                  : moviesData.publicationYear,
              id: moviesData.id),
          _formData.filePath != null
              ? _formData.filePath != ''
                  ? _formData.filePath
                  : ''
              : '');
    } else {
      await context.read<MoviesServices>().addMovie(
          AddMoviesData(
              name: _formData.name, publicationYear: _formData.publicationYear),
          _formData.filePath);
    }
  }

  void addedPath(filePath) {
    _formData = _formData.copyWith(filePath: filePath);
  }

  FormData _formData = FormData();
  @override
  Widget build(BuildContext context) {
    final moviesData = ModalRoute.of(context).settings.arguments as MoviesData;

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40,
            left: 20,
            right: 20,
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text("Create a new movie", style: textTheme.headline4),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        autocorrect: false,
                        initialValue: moviesData != null ? moviesData.title : '',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: textTheme.bodyText2,
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                            hintText:
                                moviesData != null ? moviesData.title : 'Title'),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) =>
                            _formData = _formData.copyWith(name: value),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        autocorrect: false,
                        initialValue:
                            moviesData != null ? moviesData.publicationYear : '',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: textTheme.bodyText2,
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                            hintText: moviesData != null
                                ? moviesData.publicationYear
                                : 'PublicationYear'),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) => _formData =
                            _formData.copyWith(publicationYear: value),
                      ),
                      const SizedBox(height: 8),
                      ImageWidget(
                          addedPath, moviesData != null ? moviesData.url : ''),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        const Color(0xff224957),
                      )),
                      autofocus: true,
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButton(
                      autofocus: true,
                      onPressed: () {
                        uploadImage().then((value) {
                          final moviesProvider = context.read<MoviesProvider>();

                          moviesProvider.refreshMovies();

                          return Navigator.of(context)
                              .pushReplacementNamed(MoviesScreen.route);
                        });
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAnimation(),
    );
  }
}
