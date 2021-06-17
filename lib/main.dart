import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/authentication/user_repository.dart';
import 'src/authentication/authentication.dart';
import 'src/login/login.dart';
import 'src/screens/welcome/welcome.dart';
import 'package:bloc/bloc.dart';

void main() {
  runApp(
    App()
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Welcome(),
    );
  }
}


// void main() {
//   final userRepository = UserRepository();
//   runApp(
//     BlocProvider<AuthenticationBloc>(
//       create: (context) {
//         return AuthenticationBloc(userRepository: userRepository)
//           ..add(AppStarted());
//       },
//       child: App(userRepository: userRepository),
//     ),
//   );
// }
//
// class App extends StatelessWidget {
//   final UserRepository userRepository ;
//
//
//   App({Key? key, required this.userRepository}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           // This is the theme of your application.
//           //
//           // Try running your application with "flutter run". You'll see the
//           // application has a blue toolbar. Then, without quitting the app, try
//           // changing the primarySwatch below to Colors.green and then invoke
//           // "hot reload" (press "r" in the console where you ran "flutter run",
//           // or simply save your changes to "hot reload" in a Flutter IDE).
//           // Notice that the counter didn't reset back to zero; the application
//           // is not restarted.
//           primarySwatch: Colors.blue,
//         ),
//         home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//             builder: (context, state) {
//               return LoginPage(userRepository: userRepository);
//             })
//     );
//   }
// }

