 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../utils/helper/fonctions.dart';
import '../blocs/connexion/connexion_bloc.dart';


class ConnexionForm extends StatelessWidget {
  const ConnexionForm({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnexionBloc, ConnexionState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          showToast(context,  utf8.decode(state.errorMessage.codeUnits),
              backgroundColor:Theme.of(context).colorScheme.error,
              textColor:Theme.of(context).colorScheme.onError);

        }
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final isSmallScreen = constraints.maxWidth < 600;
          final buttonStyle = ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11.0),
            ),
            textStyle: TextStyle(fontSize: isSmallScreen ? 14.0 : 16.0),
            padding: isSmallScreen ? const EdgeInsets.all(14) : const EdgeInsets.all(16),
          );
          return  Center(
            heightFactor: 2.2,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.all(8)),
                    _EmailInput(),
                    const Padding(padding: EdgeInsets.all(8)),
                    _UsernameInput(),
                    const Padding(padding: EdgeInsets.all(8)),
                    _PasswordInput(),
                    const Padding(padding: EdgeInsets.all(6)),
                    _LoginButton(buttonStyle),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnexionBloc, ConnexionState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return TextFormField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<ConnexionBloc>().add(ConnexionEmailChanged(email)),
          decoration: InputDecoration(
            prefixIcon:  Icon(
              color:  Theme.of(context).colorScheme.primary,
              Icons.email_outlined,
            ),
            labelText: "Email",
            labelStyle: TextStyle(fontSize: isSmallScreen ? 14.0 : 18.0),
            contentPadding:
            isSmallScreen ? const EdgeInsets.all(20) : const EdgeInsets.all(22),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide.none,
            ),
            filled: true,
           fillColor: Theme.of(context).colorScheme.surfaceVariant,
            errorText: state.email.displayError != null
                ? "email invalid"
                : null,
          ),
        );
      },
    );
  }
}

 class _UsernameInput extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return BlocBuilder<ConnexionBloc, ConnexionState>(
       buildWhen: (previous, current) => previous.username != current.username,
       builder: (context, state) {
         final isSmallScreen = MediaQuery.of(context).size.width < 600;
         return TextFormField(
           key: const Key('loginForm_usernameInput_textField'),
           onChanged: (username) =>
               context.read<ConnexionBloc>().add(ConnexionUsernameChanged(username)),
           decoration: InputDecoration(
             prefixIcon:  Icon(
               color:  Theme.of(context).colorScheme.primary,
               Icons.person,
             ),
             labelText: "Username",
             labelStyle: TextStyle(fontSize: isSmallScreen ? 14.0 : 18.0),
             contentPadding:
             isSmallScreen ? const EdgeInsets.all(20) : const EdgeInsets.all(22),
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(11),
               borderSide: BorderSide.none,
             ),
             filled: true,
             fillColor: Theme.of(context).colorScheme.surfaceVariant,
             errorText: state.username.displayError != null
                 ? "username invalid"
                 : null,
           ),
         );
       },
     );
   }
 }

class _PasswordInput extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _PasswordInputState();

}
class _PasswordInputState extends State<_PasswordInput>{
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnexionBloc,ConnexionState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        final isSmallScreen = MediaQuery.of(context).size.width < 600;
        return Column(
          children:[
            TextFormField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<ConnexionBloc>().add(ConnexionPasswordChanged(password)),

            obscureText: obscureText,

            decoration: InputDecoration(
              prefixIcon: Icon(
                color: Theme.of(context).colorScheme.primary,
                Icons.password_outlined,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide.none,
              ),
             // filled: true,
              suffixIcon: IconButton(
                icon: Icon(
                  color: Theme.of(context).colorScheme.primary,
                  obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              ),

              labelText: 'Mots de passe',
              labelStyle: TextStyle(fontSize: isSmallScreen ? 14.0 : 18.0),
              contentPadding:
              isSmallScreen ? const EdgeInsets.all(20) : const EdgeInsets.all(22),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant,
              errorText: state.password.displayError != null
                  ? 'Mots de passe invalid'
                  : null,
            ),
          ),
        ]
        );
      },
    );
  }


}

class _LoginButton extends StatelessWidget {
  final ButtonStyle style;
  const _LoginButton(this.style);
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return BlocBuilder<ConnexionBloc, ConnexionState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : FilledButton(
          style: style,
          key: const Key('loginForm_continue_raisedButton'),
          onPressed: state.isValid ? ()  {
              context.read<ConnexionBloc>().add(const ConnexionSubmitted());

          }
              : null,
          child: Text(
            'Connexion',
            style: TextStyle(
              fontSize: isSmallScreen ? 15.0 : 16.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        );
      },
    );
  }
}



