// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `No internet connection`
  String get no_internet_connection {
    return Intl.message(
      'No internet connection',
      name: 'no_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get try_again {
    return Intl.message(
      'Try again',
      name: 'try_again',
      desc: '',
      args: [],
    );
  }

  /// `Add `
  String get add_button {
    return Intl.message(
      'Add ',
      name: 'add_button',
      desc: '',
      args: [],
    );
  }

  /// `Employee`
  String get employee {
    return Intl.message(
      'Employee',
      name: 'employee',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Set location on map?`
  String get location_on_map {
    return Intl.message(
      'Set location on map?',
      name: 'location_on_map',
      desc: '',
      args: [],
    );
  }

  /// `Today's tasks`
  String get today_tasks {
    return Intl.message(
      'Today\'s tasks',
      name: 'today_tasks',
      desc: '',
      args: [],
    );
  }

  /// `Last seen by employee`
  String get last_seen_employee {
    return Intl.message(
      'Last seen by employee',
      name: 'last_seen_employee',
      desc: '',
      args: [],
    );
  }

  /// `Login data`
  String get login_data {
    return Intl.message(
      'Login data',
      name: 'login_data',
      desc: '',
      args: [],
    );
  }

  /// `Employee data`
  String get employee_data {
    return Intl.message(
      'Employee data',
      name: 'employee_data',
      desc: '',
      args: [],
    );
  }

  /// `This feature is not working yet`
  String get feature_not_working {
    return Intl.message(
      'This feature is not working yet',
      name: 'feature_not_working',
      desc: '',
      args: [],
    );
  }

  /// `Cancel filter`
  String get cancel_filter {
    return Intl.message(
      'Cancel filter',
      name: 'cancel_filter',
      desc: '',
      args: [],
    );
  }

  /// `Filter options`
  String get filter_options {
    return Intl.message(
      'Filter options',
      name: 'filter_options',
      desc: '',
      args: [],
    );
  }

  /// `Choose `
  String get choose_title {
    return Intl.message(
      'Choose ',
      name: 'choose_title',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Choose role`
  String get choose_role {
    return Intl.message(
      'Choose role',
      name: 'choose_role',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, there is an error`
  String get sorry_error {
    return Intl.message(
      'Sorry, there is an error',
      name: 'sorry_error',
      desc: '',
      args: [],
    );
  }

  /// `No tasks`
  String get no_tasks {
    return Intl.message(
      'No tasks',
      name: 'no_tasks',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get no_data {
    return Intl.message(
      'No data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_password {
    return Intl.message(
      'Change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Basic data`
  String get basic_data {
    return Intl.message(
      'Basic data',
      name: 'basic_data',
      desc: '',
      args: [],
    );
  }

  /// `Go to location`
  String get go_to_location {
    return Intl.message(
      'Go to location',
      name: 'go_to_location',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, an error occurred`
  String get sorry_error_occurred {
    return Intl.message(
      'Sorry, an error occurred',
      name: 'sorry_error_occurred',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '1_enter_current_location' key

  /// `Edit task`
  String get edit_task {
    return Intl.message(
      'Edit task',
      name: 'edit_task',
      desc: '',
      args: [],
    );
  }

  /// `Delete task`
  String get delete_task {
    return Intl.message(
      'Delete task',
      name: 'delete_task',
      desc: '',
      args: [],
    );
  }

  /// `welcome back`
  String get welcome_back {
    return Intl.message(
      'welcome back',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `write your data for login`
  String get write_your_data_for_login {
    return Intl.message(
      'write your data for login',
      name: 'write_your_data_for_login',
      desc: '',
      args: [],
    );
  }

  /// `welcome,`
  String get welcome {
    return Intl.message(
      'welcome,',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
