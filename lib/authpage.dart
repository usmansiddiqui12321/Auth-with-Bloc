import 'package:auth_with_bloc/Cubit/PhoneAuthCubit/auth_cubit.dart';
import 'package:auth_with_bloc/Cubit/PhoneAuthCubit/auth_states.dart';
import 'package:auth_with_bloc/verifyphoneNumber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AuthPage extends StatelessWidget {
  TextEditingController otpController = TextEditingController();

  AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Sign In with Phone",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    controller: otpController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Phone Number",
                        counterText: ""),
                  ),
                  const SizedBox(height: 10),
                  BlocConsumer<AuthCubit, AuthStates>(
                    listener: (context, state) {
                      if (state is AuthCodeSentState) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                     VerifyPhoneNumber()));
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CupertinoButton(
                            color: Colors.blue,
                            onPressed: () {
                              String phoneNumber = "+92${otpController.text}";
                              BlocProvider.of<AuthCubit>(context)
                                  .SendOtp(phoneNumber: phoneNumber);
                            },
                            child: const Text("SignIn")),
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
