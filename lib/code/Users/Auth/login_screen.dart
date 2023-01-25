import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:municipal_track/code/Users/Auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var formKey = GlobalKey<FormState>();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var isObscure = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: cons.maxHeight
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Login screen header
                  Center(
                    child: SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 285,
                      child: Image.asset("assets/images/logo.png"),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.all(Radius.circular(60),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, -3),
                          )
                        ],

                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                        child: Column(
                          children: [
                            //login with phone number form
                            Form(
                              key: formKey,
                              child: Column(
                                children: [

                                  ///Phone number
                                  TextFormField(
                                    controller: phoneNumberController,
                                    validator: (val) =>
                                    val == ""
                                        ? "Please enter your Phone Number"
                                        : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.phone,
                                        color: Colors.black,
                                      ),
                                      hintText: "+27 Phone Number...",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          )
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          )
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              30),
                                          borderSide: const BorderSide(
                                            color: Colors.white60,
                                          )
                                      ),
                                      contentPadding: const EdgeInsets
                                          .symmetric(
                                          horizontal: 14,
                                          vertical: 6
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  const SizedBox(height: 18,),

                                  ///Password
                                  Obx(
                                        () =>
                                        TextFormField(
                                          controller: passwordController,
                                          obscureText: isObscure.value,
                                          validator: (val) =>
                                          val == ""
                                              ? "Please enter your password"
                                              : null,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.vpn_key_sharp,
                                              color: Colors.black,
                                            ),
                                            suffixIcon: Obx(
                                                    () =>
                                                    GestureDetector(
                                                      onTap: () {
                                                        isObscure.value =
                                                        !isObscure.value;
                                                      },
                                                      child: Icon(
                                                        isObscure.value
                                                            ? Icons
                                                            .visibility_off
                                                            : Icons.visibility,
                                                        color: Colors.black,
                                                      ),
                                                    )
                                            ),
                                            hintText: "Password...",
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(30),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(30),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(30),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .circular(30),
                                                borderSide: const BorderSide(
                                                  color: Colors.white60,
                                                )
                                            ),
                                            contentPadding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 14,
                                                vertical: 6
                                            ),
                                            fillColor: Colors.white,
                                            filled: true,
                                          ),
                                        ),
                                  ),

                                  const SizedBox(height: 18,),

                                  ///Button for login
                                  Material(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      onTap: () {

                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 28,
                                        ),
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )

                                ],

                              ),
                            ),

                            const SizedBox(height: 16,),

                            //register new account if none
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an Account?"),
                                TextButton(
                                  onPressed: () {
                                    Get.to(SignUpScreen());
                                  },
                                  child: const Text("Register Here",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const Text("Or",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 16)),

                            //admin sing in instead.
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Are you an Admin?"),
                                TextButton(
                                  onPressed: () {

                                  },
                                  child: const Text("Click Here",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
