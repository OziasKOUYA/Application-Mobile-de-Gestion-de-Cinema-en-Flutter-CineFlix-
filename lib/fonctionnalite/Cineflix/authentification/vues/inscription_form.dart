import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import 'package:reactive_forms/reactive_forms.dart';

import '../../../../utils/helper/fonctions.dart';
import '../cubits/inscription_cubit/inscription_cubit.dart';
import '../cubits/inscription_cubit/inscription_states.dart';


class InscriptionForm extends StatefulWidget {



  @override
  _InscriptionFormState createState() => _InscriptionFormState();
}

class _InscriptionFormState extends State<InscriptionForm> {



  FormGroup form = FormGroup({
    'username': FormControl<String>(
      validators: [Validators.required],
    ),
  'email': FormControl<String>(validators: [Validators.email]),
  'password1': FormControl<String>(
  validators: [Validators.required, Validators.pattern(RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$'))],
  ),
  'password2': FormControl<String>(validators:
  [Validators.required]),
}, validators: [
Validators.mustMatch('password1', 'password2')
]);

  bool obscureText = true;





  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          formGroup: form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                SizedBox(height:FuzHelperFunctions.screenHeight(context)/30),
                  ReactiveTextField<String>(
                  formControlName: 'email',

                  decoration:  InputDecoration(
                    prefixIcon:  Icon(
                      color:  Theme.of(context).colorScheme.primary,
                      Icons.email_outlined,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide.none,
                    ),
                    labelText: "Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validationMessages: {
                    'required': (error) => "Champs requis",
                    'email':(error)=>"Mail invalid"
                  },
                ),
                SizedBox(height:FuzHelperFunctions.screenHeight(context)/30),
                ReactiveTextField<String>(
                  formControlName: 'username',
                  decoration:  InputDecoration(
                    prefixIcon:  Icon(
                      color:  Theme.of(context).colorScheme.primary,
                      Icons.location_history_outlined,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide.none,
                    ),
                    labelText: "Username",
                  ),
                  validationMessages: {
                    'required': (error) => "Champs requis",
                  },
                ),
                SizedBox(height:FuzHelperFunctions.screenHeight(context)/30),
                ReactiveTextField<String>(
                  formControlName: 'password1',
                  decoration: InputDecoration(
                    prefixIcon:  Icon(
                      color:  Theme.of(context).colorScheme.primary,
                      Icons.password_outlined,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide.none,
                    ),
                    labelText: "Mot de passe",
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                  ),
                  obscureText:obscureText ,
                  validationMessages: {
                    'required': (error) => "Champs requis",
                    'pattern': (error) => "Pattern",
                  },
                ),
                SizedBox(height:FuzHelperFunctions.screenHeight(context)/30),
                ReactiveTextField<String>(
                  formControlName: 'password2',
                  decoration: InputDecoration(
                    prefixIcon:  Icon(
                      color:  Theme.of(context).colorScheme.primary,
                      Icons.check,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide.none,
                    ),
                    labelText: "Confirmer votre mot de passe",
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                  ),
                  obscureText:obscureText ,
                  validationMessages: {
                    'required': (error) => "Champs requis",
                    'mustMatch': (error) => "Dois etre similaire au champs precedant",
                  },
                ),

                SizedBox(height:FuzHelperFunctions.screenHeight(context)/30),
              BlocListener<SignupCubit, SignupState>(
                  listener: (context, state) {
                    if (state.status == SignupStatus.success) {
                      Navigator.pop(context);
                    }
                  },
                  child: ReactiveFormConsumer(
                    builder: (context, form, child) {
                      return ElevatedButton(
                        onPressed: form.valid
                            ? () {
                          if (form.valid ) {
                            final formData = form.value;
                            context.read<SignupCubit>().submitForm(formData);
                          } else {
                            form.markAllAsTouched();
                          }
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.watch<SignupCubit>().state.buttonColor,
                        ),
                        child: context.watch<SignupCubit>().state.status == SignupStatus.loading
                            ? CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        )
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (context.watch<SignupCubit>().state.buttonIcon != null)
                              Icon(context.watch<SignupCubit>().state.buttonIcon, color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 8),
                            Text(
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:Theme.of(context).colorScheme.primary ),
                              context.watch<SignupCubit>().state.status == SignupStatus.failed
                                  ? context.watch<SignupCubit>().state.message ?? "Erreur"
                                  : (context.watch<SignupCubit>().state.status == SignupStatus.success
                                  ? "Succes"
                                  : "S'inscrire"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}

