import 'package:boilerplate/data/database/controller/db_controller.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/ui/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

User loggedInUser;
DBController _dbController = DBController();
//Google SignIn:----------------------------------------------------------------
final GoogleSignIn _googleSignIn = GoogleSignIn();
//Firebase Auth:----------------------------------------------------------------
final FirebaseAuth _auth = FirebaseAuth.instance;

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  _FormStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => userEmail, validateUserEmail),
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validateConfirmPassword),
      reaction((_) => userName, validateUserName),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String userEmail = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  String userName = '';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @computed
  bool get canUserName =>
      !formErrorStore.hasErrorInUserName && userName.isNotEmpty;

  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin &&
      userEmail.isNotEmpty &&
      password.isNotEmpty;

  @computed
  bool get canRegister =>
      !formErrorStore.hasErrorsInRegister &&
      userEmail.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty;

  @computed
  bool get canForgetPassword =>
      !formErrorStore.hasErrorInForgotPassword && userEmail.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setUserId(String value) {
    userEmail = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @action
  void setUserName(String value) {
    userName = value;
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.userEmail = "Email can't be empty";
    } else if (!isEmail(value)) {
      formErrorStore.userEmail = 'Please enter a valid email address';
    } else {
      formErrorStore.userEmail = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "Password can't be empty";
    } else if (value.length < 6) {
      formErrorStore.password = "Password must be at-least 6 characters long";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      formErrorStore.confirmPassword = "Confirm password can't be empty";
    } else if (value != password) {
      formErrorStore.confirmPassword = "Password doesn't match";
    } else {
      formErrorStore.confirmPassword = null;
    }
  }

  @action
  void validateUserName(String value) {
    if (value.isEmpty) {
      formErrorStore.userName = "Name can't be empty";
    } else if (value.length < 2) {
      formErrorStore.userName = "Your name should be longer";
    } else {
      formErrorStore.userName = null;
    }
  }

  @action
  Future register() async {
    loading = true;
    await _auth
        .createUserWithEmailAndPassword(email: userEmail, password: password)
        .then((value) {
      loading = false;
      success = true;
    }).catchError((e) {
      loading = false;
      success = false;
      if (e.toString().contains("ERROR_USER_NOT_FOUND"))
        errorStore.errorMessage = "Incorrect email or password";
      else if (e.toString().contains("ERROR_EMAIL_ALREADY_IN_USE"))
        errorStore.errorMessage = "User already exists";
      else
        errorStore.errorMessage =
            "Something went wrong, please check your internet connection and try again";
      print(e);
    });
  }

  @action
  Future login() async {
    loading = true;

    await _auth
        .signInWithEmailAndPassword(email: userEmail, password: password)
        .then((value) {
      loading = false;
      _checkUserWhileLogin();
    }).catchError((e) {
      loading = false;
      success = false;
      errorStore.errorMessage = (e
                  .toString()
                  .contains("ERROR_USER_NOT_FOUND") ||
              e.toString().contains("ERROR_WRONG_PASSWORD"))
          ? "Incorrect email or password"
          : "Something went wrong, please check your internet connection and try again";
      print(e);
    });
  }

  _checkUserWhileLogin() async {
    loggedInUser = _auth.currentUser;
    checkUser = await _dbController.checkUser(loggedInUser.email);
    success = true;
    print(checkUser);
  }

  @action
  Future forgotPassword() async {
    loading = true;
  }

  @action
  Future logout() async {
    loading = true;
    await _auth.signOut();
    loading = false;
    return await Future.value(true);
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateUserEmail(userEmail);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String userEmail;

  @observable
  String password;

  @observable
  String confirmPassword;

  @observable
  String userName;

  @computed
  bool get hasErrorsInLogin => userEmail != null || password != null;

  @computed
  bool get hasErrorsInRegister =>
      userEmail != null || password != null || confirmPassword != null;

  @computed
  bool get hasErrorInForgotPassword => userEmail != null;

  @computed
  bool get hasErrorInUserName => userName != null;
}
