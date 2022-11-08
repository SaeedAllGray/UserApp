import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/application/auth_service.dart';
import 'package:user_app/presentation/login/bloc/login_bloc.dart';
import 'package:user_app/presentation/user_list/user_list_page.dart';
import '../../src/localization/l10n.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc bloc = LoginBloc();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSucceedState) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const UserListPage(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                context.l10n.login,
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: context.l10n.email,
                    ),
                    onChanged: (email) => bloc.add(
                        ValidateEmailAndPasswordEvent(
                            email, passwordController.text)),
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: context.l10n.password,
                    ),
                    onChanged: (password) => bloc.add(
                        ValidateEmailAndPasswordEvent(
                            emailController.text, password)),
                  ),
                  ElevatedButton(
                    onPressed: state is ShouldActicateTheButton
                        ? () => bloc.add(LoginWithEmailEvent(
                            emailController.text, passwordController.text))
                        : null,
                    child: Text(context.l10n.login),
                  ),
                  state is LoginFailedState
                      ? Text(
                          context.l10n.loginFailed,
                          style: const TextStyle(color: Colors.red),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
