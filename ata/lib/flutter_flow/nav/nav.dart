import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';

// import '/backend/backend.dart';
// import '../../auth/base_auth_user_provider.dart';
// import '../../backend/push_notifications/push_notifications_handler.dart'
//     show PushNotificationsHandler;
import '../../index.dart';
import '../../main.dart';
import 'serialization_util.dart';
// import '../../custom_code/widgets/get_hyperbooks.dart';
import '../../appwrite_interface.dart';
export 'package:go_router/go_router.dart';

export 'serialization_util.dart';

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({super.key, required this.child});

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

const String kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  // BaseAuthUser? initialUser;
  // BaseAuthUser? user;
  bool showSplashImage = false /*true*/;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => currentUser == null || showSplashImage;
  bool get loggedIn => (currentUser != null) /*user?.loggedIn ?? false*/;
  bool get initiallyLoggedIn => loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  /* void update(BaseAuthUser newUser) {
    final bool shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }
*/
  void stopShowingSplashImage() {
    //>print('(M100)');
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) {
  const String resetPasswordRoute = '/resetPassword';
  String initialRoute = '/';
  if (isIncomingResetPassword) {
    initialRoute = resetPasswordRoute;
    resetPasswordCommandRecived = true;
  }
  //>print('(IN20)${initialRoute}____${resetPasswordCommandRecived}');
  return (GoRouter(
    initialLocation: initialRoute,
    debugLogDiagnostics: true,
    refreshListenable: appStateNotifier,
    errorBuilder: (context, state) =>
        /*appStateNotifier.*/ loggedIn ? NavBarPage() : NavBarPage()/*#IntroductionWidget()*/,
    overridePlatformDefaultLocation: true,
    routes: [
      FFRoute(
        name: '_initialize',
        path: '/',
        builder: (context, _) => /*appStateNotifier.*/
            loggedIn ? NavBarPage() : NavBarPage() /*#IntroductionWidget()*/,
        routes: [
          FFRoute(
            name: 'createAccount',
            path: 'createAccount',
            builder: (context, params) => CreateAccountWidget(),
          ),
          FFRoute(
            name: 'login',
            path: 'login',
            builder: (context, params) => params.isEmpty
                ? NavBarPage(initialPage: 'login')
                : LoginWidget(),
          ),
          FFRoute(
            name: 'editProfile',
            path: 'editProfile',
            builder: (context, params) => EditProfileWidget(),
          ),
          FFRoute(
            name: 'profilePage',
            path: 'profilePage',
            builder: (context, params) => params.isEmpty
                ? NavBarPage(initialPage: 'profilePage')
                : ProfilePageWidget(),
          ),
          FFRoute(
            name: 'changePassword',
            path: 'changePassword',
            builder: (context, params) => ChangePasswordWidget(),
          ),
          FFRoute(
            name: 'registerPage',
            path: 'registerPage',
            builder: (context, params) => RegisterPageWidget(),
          ),
          FFRoute(
            name: 'phoneSignIn',
            path: 'phoneSignIn',
            builder: (context, params) => PhoneSignInWidget(),
          ),
          FFRoute(
            name: 'verifyPhone',
            path: 'verifyPhone',
            builder: (context, params) => VerifyPhoneWidget(),
          ),
          FFRoute(
            name: 'chapterEdit',
            path: 'chapterEdit',
            builder: (context, params) => ChapterEditWidget(
              chapter: params.getParam('chapter', ParamType.DocumentReference,
                  false, ['hyperbooks', 'chapters']) as DocumentReference?,
              title: params.getParam('title', ParamType.String) as String?,
              body: params.getParam('body', ParamType.String) as String?,
              hyperbookTitle: params.getParam(
                  'hyperbookTitle', ParamType.String) as String?,
              hyperbook: params.getParam(
                  'hyperbook',
                  ParamType.DocumentReference,
                  false,
                  ['hyperbooks']) as DocumentReference?,
              user: params.getParam(
                      'user', ParamType.DocumentReference, false, ['users'])
                  as DocumentReference?,
              authorDisplayName: params.getParam(
                  'authorDisplayName', ParamType.String) as String?,
              hyperbookBlurb: params.getParam(
                  'hyperbookBlurb', ParamType.String) as String?,
            ),
          ),
          FFRoute(
            name: 'settings',
            path: 'settings',
            builder: (context, params) => SettingsWidget(),
          ),
          FFRoute(
            name: 'map_display',
            path: 'mapDisplay',
            builder: (context, params) => NavBarPage(
              initialPage: '',
              page: LoginWidget(

              ),
            ),
          ),
          FFRoute(
            name: 'hyperbook_edit',
            path: 'hyperbookEdit',
            builder: (context, params) => HyperbookEditWidget(
              hyperbook: params.getParam(
                  'hyperbook',
                  ParamType.DocumentReference,
                  false,
                  ['hyperbooks']) as DocumentReference?,
              hyperbookTitle:
                  params.getParam('hyperbookTitle', ParamType.String) as String,
              hyperbookBlurb:
                  params.getParam('hyperbookBlurb', ParamType.String) as String,
              startChapter: params.getParam(
                  'startChapter',
                  ParamType.DocumentReference,
                  false,
                  ['hyperbooks', 'chapters']) as DocumentReference?,
              moderator: params.getParam(
                  'moderator',
                  ParamType.DocumentReference,
                  false,
                  ['users']) as DocumentReference?,
              nonMemberRole:
                  params.getParam('nonMemberRole', ParamType.String) as String,
            ),
          ),
          FFRoute(
            name: 'tutorial',
            path: 'tutorial',
            builder: (context, params) => NavBarPage(
              initialPage: '',
              page: TutorialWidget(),
            ),
          ),
          FFRoute(
            name: 'chapterRead',
            path: 'chapterRead',
            builder: (context, params) => ChapterReadWidget(
              chapterReference: params.getParam(
                  'chapterReference',
                  ParamType.DocumentReference,
                  false,
                  ['hyperbooks', 'chapters']) as DocumentReference?,
              title: params.getParam('title', ParamType.String) as String,
              body: params.getParam('body', ParamType.String) as String,
              hyperbookTitle:
                  params.getParam('hyperbookTitle', ParamType.String) as String,
              hyperbook: params.getParam(
                  'hyperbook',
                  ParamType.DocumentReference,
                  false,
                  ['hyperbooks']) as DocumentReference?,
              chapterState:
                  params.getParam('chapterState', ParamType.int) as int,
              chosenColors: params.getParam<Color>(
                  'chosenColors', ParamType.Color, true) as List<Color>,
              chapterReaderIndex:
                  params.getParam('chapterReaderIndex', ParamType.int) as int,
              readReference: params.getParam(
                  'readReference',
                  ParamType.DocumentReference,
                  false,
                  ['users', 'readReferences']) as DocumentReference?,
              hyperbookBlurb:
                  params.getParam('hyperbookBlurb', ParamType.String) as String,
              //  chapter: params.getParam(
              //      'chapter',
              //      ParamType.ChaptersRecord,
              //      false,
              //      ['hyperbooks', 'chapters']) as ChaptersRecord<Object?>?,
            ),
          ),

          /* builder: (context, params) => ChapterReadWidget(
            chapterReference: params.getParam(
                'chapterReference',
                ParamType.DocumentReference,
                false,
                ['hyperbooks', 'chapters']) as DocumentReference?,
            title: params.getParam('title', ParamType.String) as String,
            body: params.getParam('body', ParamType.String) as String,
            hyperbookTitle: params.getParam(
                'hyperbookTitle', ParamType.String) as String,
            hyperbook: params.getParam(
                'hyperbook',
                ParamType.DocumentReference,
                false,
                ['hyperbooks']) as DocumentReference?,
         ~   chapterState:
         ~   params.getParam('chapterState', ParamType.int) as int,
         ~   chosenColors: params.getParam<Color>(
         ~       'chosenColors', ParamType.Color, true) as List<Color>,
            chapterReaderIndex:
            params.getParam('chapterReaderIndex', ParamType.int) as int,
            readReference: params.getParam(
                'readReference',
                ParamType.DocumentReference,
                false,
                ['users', 'readReferences']) as DocumentReference?,
          //  chapter: params.getParam(
          //      'chapter',
          //      ParamType.ChaptersRecord,
          //      false,
          //      ['hyperbooks', 'chapters']) as ChaptersRecord<Object?>?,
          ),
        ),*/
          FFRoute(
            name: 'chapter_display',
            path: 'chapterDisplay',
            builder: (context, params) => ChapterDisplayWidget(
              hyperbook: params.getParam(
                  'hyperbook',
                  ParamType.DocumentReference,
                  false,
                  ['hyperbooks']) as DocumentReference?,
              hyperbookTitle:
                  params.getParam('hyperbookTitle', ParamType.String) as String,
            ),
          ),
          FFRoute(
            name: 'introduction',
            path: 'introduction',
            builder: (context, params) => params.isEmpty
                ? NavBarPage(initialPage: 'introduction')
                : NavBarPage(
                    initialPage: 'introduction',
                    page: TutorialWidget()/*#IntroductionWidget()*/,
                  ),
          ),
          FFRoute(
            name: 'backup_hyperbook',
            path: 'backupHyperbook',
            builder: (context, params) => BackupHyperbookWidget(
              hyperbook: params.getParam(
                  'hyperbook',
                  ParamType.DocumentReference,
                  false,
                  ['hyperbooks']) as DocumentReference?,
              hyperbookTitle:
                  params.getParam('hyperbookTitle', ParamType.String) as String,
            ),
          ),
          FFRoute(
              name: 'session_display',
              path: 'sessionDisplay',
              builder: (context, params) {
                //>print('(N810)${params.isEmpty}');
                return SessionDisplayWidget();
                /*
                  true *//*params.isEmpty*//*
                    ? NavBarPage(initialPage: 'hyperbook_display')
                    //    : HyperbookDisplayWidget(),
                    : GetHyperbooks();*/
              }),
          FFRoute(
              name: 'session_step_display',
              path: 'sessionStepDisplay',
              builder: (context, params) {
                //>print('(N810)${params.isEmpty}');
                return SessionStepDisplayWidget();
                /*
                  true *//*params.isEmpty*//*
                    ? NavBarPage(initialPage: 'hyperbook_display')
                    //    : HyperbookDisplayWidget(),
                    : GetHyperbooks();*/
              }),
          FFRoute(
            name: 'resetPassword',
            path: 'resetPassword',
            builder: (context, params) {
              //>print('(IN3)');
              return ResetPasswordWidget();
            },
          ),
        ].map((r) => r.toRoute(appStateNotifier)).toList(),
      ),
    ].map((r) => r.toRoute(appStateNotifier)).toList(),
  ));
}

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((MapEntry<String, String?> e) => e.value != null)
            .map((MapEntry<String, String?> e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) {
    print(
        '(N770)${mounted}&${GoRouter.of(this).shouldRedirect(ignoreRedirect)}');
    !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
        ? null
        : {
            //>print('(N775)${name}%${pathParameters}&${extra}'),
            goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            )
          };
  }

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra! as Map<String, dynamic> : {};
  Map<String, String> get queryParameters => uri.queryParameters;
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state,
      [this.asyncParams = const <String, Future Function(String p1)>{}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (MapEntry<String, dynamic> param) async {
            final doc = await asyncParams[param.key]!(param.value as String)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      )
          .onError((_, __) => <bool>[false])
          .then((List<bool> v) => v.every((bool e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
    List<String>? collectionNamePath,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(param, type, isList,
        collectionNamePath: collectionNamePath);
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const <String, Future Function(String p1)>{},
    this.routes = const <GoRoute>[],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (BuildContext context, GoRouterState state) {
          if (appStateNotifier.shouldRedirect) {
            final String redirectLocation =
                appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            //+       appStateNotifier.setRedirectLocationIfUnset(state.location);
            return '/introduction';
          }
          return null;
        },
        /* pageBuilder: (BuildContext context, GoRouterState state) {
          final FFParameters ffParams = FFParameters(state, asyncParams);
          final Widget page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (BuildContext context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          //>print('(N60A)${appStateNotifier.loggedIn}');
          final Widget child = appStateNotifier.loading ?
          NavBarPage(initialPage: 'login')

          appStateNotifier.loggedIn ? NavBarPage() : IntroductionWidget()
          */ /*Container(
                  color: Colors.transparent,
                  child: Image.asset(
                   // 'assets/images/hyperbook1.png',
                    'assets/images/LifeLogo1.png',
                    fit: BoxFit.fitWidth,
                  ),
                ) */ /*
              : PushNotificationsHandler(child: page);
          //>print('(N60B)${appStateNotifier.loggedIn}');
          final TransitionInfo transitionInfo = state.transitionInfo;
          //>print('(N60C)${transitionInfo.hasTransition}&&&&${child}****${child.toString()}');

          return */ /*transitionInfo.hasTransition*/ /* false
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,*/
        pageBuilder: (BuildContext context, GoRouterState state) {
          final FFParameters ffParams = FFParameters(state, asyncParams);
          final Widget page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (BuildContext context, _) =>
                      builder(context, ffParams),
                )
              : builder(context, ffParams);
          print(
              '(IN6)${appStateNotifier.loggedIn}++++${page}****${appStateNotifier.loading}!!!!${resetPasswordCommandRecived}');
          //%//>print('(N)');
          final Widget child = appStateNotifier.loading
              ?
              //NavBarPage(initialPage: 'login')
              appStateNotifier.loggedIn
                  ? NavBarPage()
                  : (resetPasswordCommandRecived)
                      ? ResetPasswordWidget()
                      : LoginWidget() //IntroductionWidget()
              /*Container(
                  color: Colors.transparent,
                  child: Image.asset(
                   // 'assets/images/hyperbook1.png',
                    'assets/images/LifeLogo1.png',
                    fit: BoxFit.fitWidth,
                  ),
                ) */
              : PushNotificationsHandler(child: page);

          final TransitionInfo transitionInfo = state.transitionInfo;
          print(
              '(IN7)${state}****${transitionInfo.hasTransition}££££${transitionInfo.hasTransition}????${child}');
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType =  kStandardPageTransitionType,
    this.duration = kStandardTransitionTime,
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(
        hasTransition: true,
      );
}
