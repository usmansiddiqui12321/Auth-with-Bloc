import 'package:auth_with_bloc/Cubit/PhoneAuthCubit/auth_cubit.dart';
import 'package:auth_with_bloc/Cubit/PhoneAuthCubit/auth_states.dart';
import 'package:auth_with_bloc/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class VerifyPhoneNumber extends StatelessWidget {
  TextEditingController verifyController = TextEditingController();

  VerifyPhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Verification",
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
                    controller: verifyController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "6 - Digit OTP",
                        counterText: ""),
                  ),
                  const SizedBox(height: 10),
                  BlocConsumer<AuthCubit, AuthStates>(
                    listener: (context, state) {
                      if (state is AuthLoggedInState) {
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Homepage()));
                      } else if (state is AuthErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 3),
                        ));
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
                              BlocProvider.of<AuthCubit>(context)
                                  .VerifyOtp(otp: verifyController.text);
                            },
                            child: const Text("Verify")),
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
