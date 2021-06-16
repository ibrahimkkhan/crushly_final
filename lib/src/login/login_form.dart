import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login.dart';
// import 'package:influinsta_login/src/screens/sign_up.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
        BlocProvider.of<LoginBloc>(context).add(
          LoginButtonPressed(
            email: _usernameController.text,
            password: _passwordController.text,
          ),
        );
    }


    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                          BorderSide(width: 1.5, color: Colors.orange),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                            BorderSide(width: 1, color: Colors.orange)),
                        focusColor: Colors.orange,
                        hoverColor: Colors.orange,
                        isDense: true,
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black)),
                    controller: _usernameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide:
                          BorderSide(width: 1.5, color: Colors.orange),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide:
                            BorderSide(width: 1, color: Colors.orange)),
                        focusColor: Colors.orange,
                        hoverColor: Colors.orange,
                        isDense: true,
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black)),
                    controller: _passwordController,
                  ),
                ),
                ElevatedButton(
                  onPressed: state is! LoginLoading
                      ? _onLoginButtonPressed
                      : null,
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                Container(
                  child: state is LoginLoading
                      ? CircularProgressIndicator()
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
