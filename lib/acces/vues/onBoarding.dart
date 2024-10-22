import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/helper/fonctions.dart';
import '../onBoarding_bloc/onboarding_bloc.dart';
import '../onBoarding_bloc/onboarding_events.dart';
import '../onBoarding_bloc/onboarding_states.dart';
import 'home_guest_screen.dart';



class OnboardingScreen extends StatelessWidget {

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => OnboardingScreen());
  }
  final PageController controller = PageController(initialPage: 0);
  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:BlocBuilder<OnboardingBloc, OnboardingStates>(
        builder: (context, state) {
          return  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: BlocProvider.of<OnboardingBloc>(context).state.pageIndex != 2,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
                            return const HomeGuestScreen();
                          }), (route) => false,);
                        },
                        child: Text("",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),


              ),
              DotsIndicator(
                dotsCount: 3,
                position: BlocProvider.of<OnboardingBloc>(context).state.pageIndex,
                decorator: DotsDecorator(
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              Expanded(child:
              PageView(
                controller: controller,
                onPageChanged: (value) {
                  state.pageIndex = value;
                  BlocProvider.of<OnboardingBloc>(context)
                      .add(OnboardingEvents());
                },
                children: [
                  _page(

                    context: context,
                    pageIndex: 0,
                    imageUrl: "",
                    title:"" ,
                    desc:"",
                  ),
                  _page(
                    context: context,
                    pageIndex: 1,
                    imageUrl: "",
                    title:"" ,
                    desc:"",
                  ),
                  _page(
                    context: context,
                    pageIndex: 2,
                    imageUrl: "",
                    title:"" ,
                    desc:"",
                  ),
                ],
              ),
              ),


            ],
          );
        },
      ),
      )
    );
  }

  Widget _page({
    required pageIndex,
    required imageUrl,
    required title,
    required desc,
    required BuildContext context,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [


        AspectRatio(
          aspectRatio: 0.9,
          child: Image.asset(imageUrl),
        ),

        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(color:Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold ),
        ),
      //  const SizedBox(height: 10),
        Text(
            desc,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  pageIndex == 2
                      ? Navigator.of(context)
                      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) {
                    return const HomeGuestScreen();
                  }), (route) => false,
                  )
                      : controller.animateToPage(pageIndex + 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate);
                },
                child:Container(
                  width: FuzHelperFunctions.screenWidth(context)/3.5,
                  height: FuzHelperFunctions.screenHeight(context)/20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: Theme.of(context).colorScheme.primary
                    ),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Text("",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(color:Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold ),
                  ),
                )

              )

            ],
          ),
        ),
      ],
    );
  }
}
