import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:loginsignupusingbloc/bloc/login_bloc.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  @override
  void initState() {
    _loginBloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login "),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (current, previous) => current.email != previous.email,
            builder: (context, state) {
              return TextFormField(
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                decoration: const InputDecoration(
                    hintText: "Email", border: OutlineInputBorder()),
                onChanged: (value) {
                  context.read<LoginBloc>().add(EmailChanged(email: value));
                },
                onFieldSubmitted: (value) {},
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (current, previous) =>
                current.password != previous.password,
            builder: (context, state) {
              return TextFormField(
                keyboardType: TextInputType.emailAddress,
                focusNode: passwordFocusNode,
                decoration: const InputDecoration(
                    hintText: "Password", border: OutlineInputBorder()),
                onChanged: (value) {
                  context
                      .read<LoginBloc>()
                      .add(PasswordChanged(password: value));
                },
                onFieldSubmitted: (value) {},
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.loginStatus == LoginStatus.error) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text(state.message.toString()),
                  ));
              }
              if (state.loginStatus == LoginStatus.loading) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    content: Text("Submitting"),
                  ));
              }
              if (state.loginStatus == LoginStatus.success) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                    content: Text("Login successful"),
                  ));
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (current, previous) => false,
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(LoginApi());
                    },
                    child: const Text("Login"));
              },
            ),
          )
        ],
      ),
    );
  }
}
