import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:study_mobx/stores/login_store.dart';
import 'package:study_mobx/widgets/custom_icon_button.dart';
import 'package:study_mobx/widgets/custom_text_field.dart';

import 'list_screen.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  late LoginStore loginStore;

  late ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    loginStore = Provider.of<LoginStore>(context);

    disposer = reaction(
      (_) => loginStore.loggedIn,
      (loggedIn){
        if (loggedIn != null && loggedIn as bool) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_)=>ListScreen())
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Observer(
                      builder: (_){
                        return CustomTextField(
                          hint: 'E-mail',
                          prefix: Icon(Icons.account_circle),
                          textInputType: TextInputType.emailAddress,
                          onChanged: loginStore.setEmail,
                          enabled: !loginStore.loading,
                        );
                      },
                    ),
                    const SizedBox(height: 16,),
                    Observer(
                      builder: (_){
                        return CustomTextField(
                          hint: 'Senha',
                          prefix: Icon(Icons.lock),
                          obscure: !loginStore.passwordVisible,
                          onChanged: loginStore.setPassword,
                          enabled: !loginStore.loading,
                          suffix: CustomIconButton(
                            radius: 32,
                            iconData: loginStore.passwordVisible ?
                              Icons.visibility_off : Icons.visibility,
                            onTap: loginStore.togglePasswordVisibility,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16,),
                    Observer(
                      builder: (_){
                        return SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              )
                            ),
                            child: loginStore.loading
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(Colors.white),
                                  )
                                : Text('Login'),
                            onPressed: () async {
                              if (loginStore.loginPressed != null) {
                                await loginStore.loginPressed!();
                              }
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }


}