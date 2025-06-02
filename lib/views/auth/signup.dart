import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiring_competitions_admin_portal/backend/models/user_model.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/custom_auth_provider.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/firestore_provider.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_colors.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_error.dart';
import 'package:hiring_competitions_admin_portal/views/auth/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class Signup extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Signup({super.key});

  Future<void> signupValidator(BuildContext context) async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    final authProvider = Provider.of<CustomAuthProvider>(context, listen : false);
    final firestoreProvider = Provider.of<FirestoreProvider>(context, listen: false);

    if(name == "" || email == "" || password == "") {
      CustomError("error").showToast(context, "Please enter the credentials");
    } else {

      // Create account
      final res = await authProvider.signup(name, email, password);

      if(res == null) {
        final user = UserModel(name, email, 'Pending');
        final uid = authProvider.user!.uid;

        // Add User
        final res = await firestoreProvider.addUser(user, uid);

        if(res == null) {

          // Get User
          final userDoc = await firestoreProvider.getAdminStatus(uid);
          
          if(userDoc != null) {
            final data = userDoc.data() as Map<String, dynamic>?;
            final status = data?['status'];

            // Check Status
            if(status == 'Pending') {
              CustomError("error").showToast(context, "Your account is awaiting approval. Please contact the admin for confirmation.");
            } else {
              context.go('/home');
            }
          }
        } else {
          CustomError("error").showToast(context, res);
        }
      } else {
        CustomError("error").showToast(context, res);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<CustomAuthProvider>(context);
    final firestoreProvider = Provider.of<FirestoreProvider>(context);
    return Scaffold(
      backgroundColor: CustomColors().background,
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Hiring ",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: CustomColors().primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Competitions",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: CustomColors().primaryText,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(10, 0, 0, 0),
                          blurRadius: 20,
                        )
                      ]
                    ),
                    child: Column(
                      children: [
                        Text("Signup", style: GoogleFonts.poppins(
                          fontSize: 30,
                          color: CustomColors().primaryText,
                          fontWeight: FontWeight.w600
                        ),),
                        SizedBox(height: 24,),

                        CustomTextField(title: "Name", icon: Icon(Icons.person_outline_outlined),controller: _nameController,),
                        SizedBox(height: 12,),
                        CustomTextField(title: "Email", icon: Icon(Icons.email_outlined), controller: _emailController,),
                        SizedBox(height: 12,),
                        CustomTextField(title: "Password", icon: Icon(Icons.lock_outline), controller: _passwordController,),
                        SizedBox(height: 24,),

                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => signupValidator(context),
                            child: Container(
                              width: 350,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: CustomColors().primary,
                                borderRadius: BorderRadius.circular(70),
                              ),
                              child: authProvider.isLoading! || firestoreProvider.isLoading!  
                                ? SizedBox(
                                  height: 23,
                                  width: 23,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.white,
                                  ),
                                ) 
                                : Text("Signup", style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16
                              ),),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),

                        SizedBox(
                          width: 350,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account? ", style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: CustomColors().secondaryText,
                              ),),
                              GestureDetector(
                                onTap: () {
                                  context.go('/login');
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Text("Login", style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: CustomColors().primaryText,
                                  ),),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
