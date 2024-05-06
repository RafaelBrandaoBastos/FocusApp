import 'package:flutter/material.dart';
import 'package:flux_focus_and_productivity/theme/theme.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _isSignedIn = false;
  String _userName = '';
  String _userEmail = '';
  String _userPhotoUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightModeBackgroundColor,
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: LightModeBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: _isSignedIn
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_userPhotoUrl.isNotEmpty)
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(_userPhotoUrl),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      _userName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _userEmail,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/logo.png'),
                      width: 100,
                    ),
                    const SizedBox(height: 25),
                    _SquareButton(
                      onPressed: () {
                        _signInWithGoogle(context);
                      },
                      label: 'New Account',
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        setState(() {
          _isSignedIn = true;
          _userName = googleUser.displayName ?? '';
          _userEmail = googleUser.email ?? '';
          _userPhotoUrl = googleUser.photoUrl ?? '';
        });
      } else {
        // Sign in canceled by user
      }
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }
}

class _SquareButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const _SquareButton({
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: 150, 
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppLightBlue),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
