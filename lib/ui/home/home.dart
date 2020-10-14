import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/ui/chat/chat_history.dart';
import 'package:boilerplate/ui/profile/profile_page.dart';
import 'package:boilerplate/ui/search/search_page.dart';
import 'package:boilerplate/ui/stats/stats_page.dart';
import 'package:boilerplate/ui/training/training_page.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //stores:---------------------------------------------------------------------
  ThemeStore _themeStore;
  LanguageStore _languageStore;
  FormStore _formStore;
  int _currentPage = 0;
  final List<Widget> _homePages = [
    ProfilePage(),
    TrainingPage(),
    SearchPage(),
    ChatHistory(),
    StatsPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _formStore = Provider.of<FormStore>(context);

    // check to see if already called api
//    if (!_postStore.loading) {
//      _postStore.getPosts();
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _buildAppBar(),
      body: _homePages[_currentPage],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  Widget _buildAppBar() {
    return AppBar(
      title: Text(AppLocalizations.of(context).translate('home_tv_home')),
      actions: _buildActions(context),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  // bottom bar methods:--------------------------------------------------------
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).primaryColorDark,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _currentPage,
      selectedItemColor: Theme.of(context).accentColor,
      onTap: _onTabTapped,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColorDark,
          label: 'Profile',
          icon: Icon(
            Icons.person,
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColorDark,
          label: 'Trainings',
          icon: Icon(
            Icons.access_alarm,
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColorDark,
          label: 'Search',
          icon: Icon(
            Icons.person_search,
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColorDark,
          label: 'Chats',
          icon: Icon(
            Icons.chat,
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Theme.of(context).primaryColorDark,
          label: 'Stats',
          icon: Icon(
            Icons.assessment_outlined,
          ),
        ),
      ],
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      _buildLanguageButton(),
      _buildThemeButton(),
      _buildLogoutButton(),
    ];
  }

  Widget _buildThemeButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: () {
            _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
          },
          icon: Icon(
            _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return IconButton(
      onPressed: () async {
        await SharedPreferences.getInstance().then((preference) async {
          preference.setBool(Preferences.is_logged_in, false);
          await _formStore.logout();
          Navigator.of(context).pushReplacementNamed(Routes.login);
        });
      },
      icon: Icon(
        Icons.power_settings_new,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  Widget _buildLanguageButton() {
    return IconButton(
      onPressed: () {
        _buildLanguageDialog();
      },
      icon: Icon(
        Icons.language,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
//        _handleErrorMessage(),
//        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
//    return Observer(
//      builder: (context) {
//        return _postStore.loading
//            ? CustomProgressIndicatorWidget()
//            : Material(child: _buildListView());
//      },
//    );
  }

  Widget _handleErrorMessage() {
//    return Observer(
//      builder: (context) {
//        return SizedBox.shrink();
//      },
//    );
  }

  // General Methods:-----------------------------------------------------------
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

  _buildLanguageDialog() {
    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        enableFullWidth: true,
        title: Text(
          AppLocalizations.of(context).translate('home_tv_choose_language'),
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontSize: 16.0,
          ),
        ),
        headerColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).primaryColor,
        closeButtonColor: Theme.of(context).scaffoldBackgroundColor,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(context).pop();
        },
        children: _languageStore.supportedLanguages
            .map(
              (object) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0.0),
                title: Text(
                  object.language,
                  style: TextStyle(
                    color: _languageStore.locale == object.locale
                        ? Theme.of(context).accentColor
                        : Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // change user language based on selected locale
                  _languageStore.changeLanguage(object.locale);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  _showDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
    });
  }
}
