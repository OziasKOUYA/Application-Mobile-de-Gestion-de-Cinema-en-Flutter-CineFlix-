import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cineflix/fonctionnalite/Cineflix/film/bloc/film_bloc.dart';
import 'package:cineflix/fonctionnalite/Cineflix/film/film_services/film_service.dart';
import 'package:cineflix/fonctionnalite/Cineflix/projection/bloc/projection_bloc.dart';
import 'package:cineflix/fonctionnalite/Cineflix/projection/projection_service.dart';
import 'package:cineflix/fonctionnalite/Cineflix/salle/Salle_service.dart';
import 'package:cineflix/fonctionnalite/Cineflix/salle/bloc/salle_bloc.dart';
import 'package:cineflix/fonctionnalite/Cineflix/ticket/bloc/ticket_bloc.dart';
import 'package:cineflix/fonctionnalite/Cineflix/ticket/ticket_service.dart';
import 'package:cineflix/utils/Theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'acces/app_bloc/app_bloc.dart';
import 'acces/onBoarding_bloc/onboarding_bloc.dart';
import 'acces/vues/home_guest_screen.dart';
import 'acces/vues/home_user_vue.dart';
import 'acces/vues/onBoarding.dart';
import 'acces/vues/splash_screen.dart';
import 'fonctionnalite/Cineflix/authentification/authentification_service.dart';
import 'fonctionnalite/Cineflix/authentification/blocs/authentification/authentification_bloc.dart';
import 'fonctionnalite/Cineflix/authentification/blocs/connexion/connexion_bloc.dart';
import 'fonctionnalite/Cineflix/authentification/cubits/inscription_cubit/inscription_cubit.dart';





class App extends StatefulWidget {
  final AdaptiveThemeMode savedThemeMode;
  final SharedPreferences sharedPreferences;
  const App({super.key, required this.savedThemeMode, required this.sharedPreferences});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final SharedPreferences _sharedPreferences;
  late final AuthentificationService _authentificationService;
  late final FilmService _filmService;
  late final ProjectionService _projectionService;
  late final SalleService _salleService;
  late final TicketService _ticketService;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sharedPreferences = widget.sharedPreferences;
    _authentificationService =AuthentificationService();
    _filmService =FilmService();
    _projectionService =ProjectionService();
    _salleService= SalleService();
    _ticketService =TicketService();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: _sharedPreferences,
          ),
          RepositoryProvider.value(
            value: _authentificationService,
          ),
          RepositoryProvider.value(
              value: _filmService, ),
          RepositoryProvider.value(
              value: _projectionService,),
          RepositoryProvider.value(
              value: _salleService, ),
          RepositoryProvider.value(
              value: _ticketService,)
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => AppBloc(),
          ),
          BlocProvider(
            create: (context) => OnboardingBloc(),
          ),

          BlocProvider<AuthentificationBloc>(
            create: (_) => AuthentificationBloc(
              authentificationService: _authentificationService,
            ),
          ),
          BlocProvider<ConnexionBloc>(
            create: (context) => ConnexionBloc(
                authentificationService: _authentificationService
            ),
          ),
          BlocProvider<FilmBloc>(
            create: (context) => FilmBloc(
                filmService: _filmService
            ),
          ),
          BlocProvider<ProjectionBloc>(
            create: (context) => ProjectionBloc(
                projectionService: _projectionService
            ),
          ),
          BlocProvider< SalleBloc>(
            create: (context) => SalleBloc(
                salleService: _salleService
            ),
          ),
          BlocProvider<TicketBloc>(
            create: (context) => TicketBloc(
                ticketService: _ticketService
            ),
          ),


          BlocProvider<SignupCubit>(
            create:(context) => SignupCubit(authentificationService: _authentificationService),
          ),
        ], child:  AppView(savedThemeMode:widget.savedThemeMode)
        )
    );
  }
}

class AppView extends StatefulWidget {
  final AdaptiveThemeMode savedThemeMode;
  const AppView({Key? key, required this.savedThemeMode}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  Locale _selectedLocale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: FuzAppTheme.lightTheme,
      dark: FuzAppTheme.darkTheme,
      initial: widget.savedThemeMode,
      builder: (theme, darkTheme) {
        return BlocListener<AuthentificationBloc, AuthentificationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthentificationStatus.authenticated:

                  _navigator.pushAndRemoveUntil<void>(
                    HomeUserScreen.route(),
                        (route) => false,
                  );

                break;
              case AuthentificationStatus.unknown:
                _navigator.pushAndRemoveUntil<void>(
                  OnboardingScreen.route(),
                      (route) => false,
                );
                break;
              case AuthentificationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomeGuestScreen.route(),
                      (route) => false,
                );
                break;
              case AuthentificationStatus.autoLoginAttempt:
                context.read<AuthentificationBloc>().add(const AuthentificationAutoLoginRequested());
                break;
            }
          },
          child: MaterialApp(
            navigatorKey: _navigatorKey,
            theme: theme,
            darkTheme: darkTheme,
            home: const SplashScreen(),
            onGenerateRoute: (_) {
              return SplashScreen.route(); // Default page
            },
          ),
        );
      },
    );
  }
}
