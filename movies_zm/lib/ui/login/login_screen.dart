import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/validation/validator.dart';
import '../../providers/user_identity/user_identity_provider.dart';
import '../../shared/bottom_animation.dart';
import '../movies_theme.dart';
import 'widget/form_data.dart';

class LoginScreen extends StatelessWidget with Validator {
  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    FormData _formData = FormData();
    final _formKey = GlobalKey<FormState>();
    final isRememberController = BehaviorSubject.seeded(false);

    Future<void> authenticate() async {
      if (_formKey.currentState.validate()) {
        final userIdentityProvider = context.read<UserIdentityProvider>();
        _formKey.currentState.save();
        await userIdentityProvider.authenticate(
            _formData.username, _formData.password, _formData.isRemember);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(
                  top: 200, left: 20, right: 20, bottom: 40),
              sliver: SliverToBoxAdapter(
                child:
                    Center(child: Text("Sign in", style: textTheme.headline3)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              sliver: SliverToBoxAdapter(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        style: textTheme.bodyText2,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) =>
                            _formData = _formData.copyWith(username: value),
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        validator: (value) => validateEmail(value),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        autocorrect: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: textTheme.bodyText2,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(hintText: 'Password'),
                        obscureText: true,
                        onSaved: (value) =>
                            _formData = _formData.copyWith(password: value),
                        validator: (value) => validatePassword(value),
                      ),
                      const SizedBox(height: 20),
                      StreamBuilder<bool>(
                          stream: isRememberController.stream,
                          builder: (context, isCheckedSnapshot) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  color: MoviesTheme.inputColor,
                                  child: Checkbox(
                                    fillColor: MaterialStateProperty.all(
                                        MoviesTheme.inputColor),
                                    checkColor: Colors.white,
                                    value: isCheckedSnapshot.data ?? false,
                                    onChanged: (bool value) {
                                      _formData =
                                          _formData.copyWith(isRemember: value);
                                      isRememberController.add(value);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Remember me',
                                  style: textTheme.bodyText2,
                                ),
                              ],
                            );
                          }),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        autofocus: true,
                        onPressed: () {
                          authenticate();
                        },
                        child: Text(
                          "Login",
                          style: textTheme.headline6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAnimation(),
    );
  }
}
