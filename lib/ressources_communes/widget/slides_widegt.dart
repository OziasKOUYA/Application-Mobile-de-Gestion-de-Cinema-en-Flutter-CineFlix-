import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SlideCarousel extends StatefulWidget {
  const SlideCarousel({super.key});

  @override
  _SlideCarouselState createState() => _SlideCarouselState();
}

class _SlideCarouselState extends State<SlideCarousel> {
  int _currentPage = 0;
  List<String> imageUrls = [
    'https://images2.fanpop.com/images/photos/5000000/Fast-Furious-the-fast-and-the-furious-movies-5012351-1600-1200.jpg',
    'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/a0030adb-2a60-440b-a5a1-9f47e635be6f/d1c98ke-ddf4d747-272e-4b3b-a9f3-087ef2666074.jpg/v1/fill/w_1920,h_1200,q_75,strp/bad_boys_2_logon_by_obi_wan234.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwic3ViIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl0sIm9iaiI6W1t7InBhdGgiOiIvaS9hMDAzMGFkYi0yYTYwLTQ0MGItYTVhMS05ZjQ3ZTYzNWJlNmYvZDFjOThrZS1kZGY0ZDc0Ny0yNzJlLTRiM2ItYTlmMy0wODdlZjI2NjYwNzQuanBnIiwid2lkdGgiOiI8PTE5MjAiLCJoZWlnaHQiOiI8PTEyMDAifV1dfQ.Xz32V7G4dqVRGnc-eKHviOJig9IdJbhQDJW8oR2-aGg',
    'https://image.tmdb.org/t/p/original/gkv55IlSO2QioqqGFzOVl6Q6O1I.jpg'
  ];
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      _buildCarousel(context),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imageUrls.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _carouselController.animateToPage(entry.key),
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  shape: BoxShape.circle,
                                ),
                                child: _currentPage == entry.key
                                    ? Center(
                                  child: Container(
                                    width: 8.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                                    : Container(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
            ],
          );

  }

  Widget _buildCarousel(BuildContext context) {
    return Center(
      child: CarouselSlider.builder(
        carouselController: _carouselController,
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(11)),
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: imageUrls[itemIndex],
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
              fit: BoxFit.cover,
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          aspectRatio: 2.3,
          onPageChanged: (index, reason) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
      ),
    );
  }






}



