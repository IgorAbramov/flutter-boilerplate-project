import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/data/database/controller/db_controller.dart';
import 'package:boilerplate/models/users/pro.dart';
import 'package:boilerplate/models/users/trainee.dart';
import 'package:boilerplate/models/users/user.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/textfield_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

DBController _dbController = DBController();
int _currentIndex = 0;
bool _choiceMade1 = false;
bool _choiceMade2 = false;
bool _isPro = false;
bool _isLight = false;
List<Widget> _pages = List();
ScreenUtil screenUtil = ScreenUtil();
PageController _pageController = PageController();
final _store = FormStore();

class QuestionnairePage extends StatefulWidget {
  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  LanguageStore _languageStore;

  @override
  void initState() {
    super.initState();
    preparePages();
    // initializing stores
  }

  @override
  Widget build(BuildContext context) {
    _languageStore = Provider.of<LanguageStore>(context);
    return Scaffold(
      body: PageView.builder(
          itemCount: _pages.length,
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return _pages[_currentIndex];
          }),
    );
  }
}

class _ThemeQuestionPage extends StatefulWidget {
  @override
  __ThemeQuestionPageState createState() => __ThemeQuestionPageState();
}

class __ThemeQuestionPageState extends State<_ThemeQuestionPage> {
  ThemeStore _themeStore;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    _themeStore = Provider.of<ThemeStore>(context);
    return Container(
      color: Theme.of(context).primaryColor,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height / 3.5,
//            left: MediaQuery.of(context).size.width / 4.6,
            child: Center(
              child: _buildTextWidget(context,
                  "${AppLocalizations.of(context).translate("questionnaire_theme_page_text1")}\n${AppLocalizations.of(context).translate("questionnaire_theme_page_text2")}"),
            ),
          ),
          _buildBackButton(context),
          _buildForwardButton(context, () async {
            AppUser user = AppUser(
              id: loggedInUser.uid,
              email: loggedInUser.email,
              isPro: _isPro,
            );
            await _dbController.addUser(user, loggedInUser.uid);
            if (_isPro) {
              Pro trainer = Pro(
                id: loggedInUser.uid,
                email: loggedInUser.email,
                username: _store.userName,
                photoUrl: '',
                displayName: _store.userName,
                bio: '',
                experience: '',
                rating: 0.0,
                price: 0.0,
                speciality: '',
              );
              await _dbController.addPro(trainer, loggedInUser.uid);
            } else {
              Trainee trainee = Trainee(
                id: loggedInUser.uid,
                email: loggedInUser.email,
                username: _store.userName,
                photoUrl: '',
                displayName: _store.userName,
              );
              await _dbController.addTrainee(trainee, loggedInUser.uid);
            }
            Navigator.of(context).pushReplacementNamed(Routes.chat);
            print(
                "Username: ${_store.userName}\nisTrainer: $_isPro\nisLight: $_isLight");
          }),
          Positioned(
              top: MediaQuery.of(context).size.height / 2,
              left: MediaQuery.of(context).size.width / 6,
              child: _buildIconChoiceButton(
                  context,
                  Icon(
                    Icons.wb_sunny,
                    size: 60,
                  ),
                  AppLocalizations.of(context).translate("questionnaire_light"),
                  _choiceMade2,
                  _isLight, () {
                setState(() {
                  _choiceMade2 = true;
                  _isLight = true;
                });
                _themeStore.changeBrightnessToDark(false);
              })),
          Positioned(
            top: MediaQuery.of(context).size.height / 2,
            right: MediaQuery.of(context).size.width / 6,
            child: _buildIconChoiceButton(
                context,
                Icon(
                  Icons.brightness_3,
                  size: 60,
                ),
                AppLocalizations.of(context).translate("questionnaire_dark"),
                _choiceMade2,
                !_isLight, () {
              setState(() {
                _choiceMade2 = true;
                _isLight = false;
              });
              _themeStore.changeBrightnessToDark(true);
            }),
          ),
        ],
      ),
    );
  }
}

class _TrainerQuestionPage extends StatefulWidget {
  @override
  __TrainerQuestionPageState createState() => __TrainerQuestionPageState();
}

class __TrainerQuestionPageState extends State<_TrainerQuestionPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Container(
      color: Theme.of(context).primaryColor,
      child: Stack(
        children: <Widget>[
          _buildBackButton(context),
          _buildForwardButton(context, () {
            _pageController.animateToPage(_pageController.page.ceil() + 1,
                duration: Duration(milliseconds: 100), curve: Curves.easeIn);
          }),
          Positioned(
            top: MediaQuery.of(context).size.height / 3.5,
//            left: MediaQuery.of(context).size.width / 4,
            child: _buildTextWidget(
              context,
              AppLocalizations.of(context)
                  .translate("questionnaire_trainer_page_text"),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2.2,
            left: MediaQuery.of(context).size.width / 6,
            child: _buildIconChoiceButton(
                context,
                Icon(
                  Icons.child_care,
                  size: 60,
                )
//                Image.asset("assets/icons/student_icon.png")
                ,
                AppLocalizations.of(context).translate("questionnaire_trainee"),
                _choiceMade1,
                !_isPro, () {
              setState(() {
                _choiceMade1 = true;
                _isPro = false;
              });
            }),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2.2,
            right: MediaQuery.of(context).size.width / 6,
            child: _buildIconChoiceButton(
                context,
                Icon(
                  Icons.stars,
                  size: 60,
                )
//                Image.asset("assets/icons/coach_icon.png")
//                Icon(Icons.local_library)

                ,
                AppLocalizations.of(context).translate("questionnaire_trainer"),
                _choiceMade1,
                _isPro, () {
              setState(() {
                _choiceMade1 = true;
                _isPro = true;
              });
            }),
          ),
        ],
      ),
    );
  }
}

class _NameQuestionPage extends StatefulWidget {
  @override
  __NameQuestionPageState createState() => __NameQuestionPageState();
}

class __NameQuestionPageState extends State<_NameQuestionPage> {
  TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Container(
      color: Theme.of(context).primaryColor,
      child: Stack(
        children: <Widget>[
          _buildForwardButton(context, () {
            if (!_store.canUserName) {
              _showErrorMessage(
                  AppLocalizations.of(context).translate("error_enter_name"));
            } else
              _pageController.animateToPage(_pageController.page.ceil() + 1,
                  duration: Duration(milliseconds: 100), curve: Curves.easeIn);
          }),
          Center(
            child: Column(
              children: <Widget>[
                Spacer(),
                _buildTextWidget(
                    context,
                    AppLocalizations.of(context)
                        .translate('questionnaire_name_page_text')),
                _buildNameTextField(context),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  Widget _buildNameTextField(BuildContext context) {
    return Observer(builder: (context) {
      return TextFieldWithoutIconWidget(
        padding:
            EdgeInsets.only(top: 20.0, left: 50.0, right: 50.0, bottom: 20.0),
        hint: (_store.userName.isEmpty)
            ? AppLocalizations.of(context).translate('questionnaire_text_hint')
            : _store.userName,
        textController: _userNameController,
        onChanged: (value) {
          _store.setUserName(_userNameController.text.trim());
        },
        errorText: _store.formErrorStore.userName,
      );
    });
  }
}

preparePages() {
  _pages.add(_NameQuestionPage());
  _pages.add(_TrainerQuestionPage());
  _pages.add(_ThemeQuestionPage());
}

Widget _buildBackButton(BuildContext context) {
  return Positioned(
    top: MediaQuery.of(context).size.height / 20,
    left: MediaQuery.of(context).size.width / 14,
    child: IconButton(
      onPressed: () {
        if (_currentIndex > 0) {
          _pageController.animateToPage(_pageController.page.ceil() - 1,
              duration: Duration(milliseconds: 100), curve: Curves.easeIn);
        }
      },
      padding: EdgeInsets.all(0),
      icon: Icon(
        Icons.arrow_back_ios,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    ),
  );
}

Widget _buildForwardButton(BuildContext context, Function function) {
  return Positioned(
    bottom: MediaQuery.of(context).size.height / 20,
    right: MediaQuery.of(context).size.width / 10,
    child: Container(
      width: screenUtil.setWidth(280.0),
      height: screenUtil.setHeight(140.0),
      child: FlatButton(
        onPressed: function,
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.all(0),
        child: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).primaryColor,
        ),
      ),
    ),
  );
}

Widget _buildTextWidget(BuildContext context, String text) {
  return Container(
    height: screenUtil.setHeight(110.0),
    width: MediaQuery.of(context).size.width,
    child: Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).scaffoldBackgroundColor,
          fontWeight: FontWeight.w700,
          fontSize: 36,
        ),
      ),
    ),
  );
}

Widget _buildIconChoiceButton(BuildContext context, Widget child, String text,
    bool choiceMade, bool active, Function function) {
  return Column(
    children: <Widget>[
      Container(
        height: screenUtil.setHeight(300),
        width: screenUtil.setWidth(260),
        decoration: BoxDecoration(
            color: (choiceMade && active)
                ? Theme.of(context).accentColor
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: IconButton(
          icon: child,
          iconSize: screenUtil.setHeight(60.0),
          color: Theme.of(context).primaryColor,
          onPressed: function,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: screenUtil.setSp(48),
          ),
        ),
      ),
    ],
  );
}
