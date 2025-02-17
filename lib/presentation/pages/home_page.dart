import 'package:course_travel/api/urls.dart';
import 'package:course_travel/domain/entities/destination_entity.dart';
import 'package:course_travel/presentation/bloc/top_destination/top_destination_bloc.dart';
import 'package:course_travel/presentation/widgets/circle_loading.dart';
import 'package:course_travel/presentation/widgets/text_failure.dart';
import 'package:d_method/d_method.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final topPageController = PageController();
  refresh() {
    context.read<TopDestinationBloc>().add(OnGetTopDestination());
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async => refresh(),
      child: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          header(),
          const SizedBox(
            height: 20,
          ),
          search(),
          const SizedBox(
            height: 24,
          ),
          categories(),
          const SizedBox(
            height: 20,
          ),
          topDestination(),
          const SizedBox(
            height: 30,
          ),
          allDestination(),
        ],
      ),
    );
  }

  Padding header() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  )),
              padding: const EdgeInsets.all(2),
              child: const CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Hi, der',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const Spacer(),
            const Badge(
              backgroundColor: Colors.red,
              alignment: Alignment(0.6, -0.6),
              child: Icon(Icons.notifications_none),
            )
          ],
        ));
  }

  search() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.only(left: 24),
        child: Row(children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Search destination here...',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.all(0)),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton.filledTonal(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 24,
              )),
        ]));
  }

  categories() {
    List list = ['Beach', 'Lake', 'Mountain', 'Forest', 'City'];

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(list.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? 30 : 10,
                  right: index == list.length - 1 ? 30 : 10,
                  bottom: 10,
                  top: 4),
              child: Material(
                  elevation: 4,
                  color: Colors.white,
                  shadowColor: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    child: Text(list[index],
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                  )),
            );
          }),
        ));
  }

  topDestination() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Top Destination',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              BlocBuilder<TopDestinationBloc, TopDestinationState>(
                builder: (context, state) {
                  if (state is TopDestinationLoaded) {
                    return SmoothPageIndicator(
                      controller: topPageController,
                      count: state.data.length,
                      effect: WormEffect(
                        dotColor: Colors.grey[300]!,
                        activeDotColor: Theme.of(context).primaryColor,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    );
                  }

                  return const SizedBox();
                },
              )
            ],
          )
        ),
        const SizedBox(height: 16,),
        BlocBuilder<TopDestinationBloc, TopDestinationState>(
          builder: (context, state) {
            if (state is TopDestinationLoading) {
              return const CircleLoading();
            }

            if (state is TopDestinationFailure) {
              return TextFailure(message: state.message);
            }

            if (state is TopDestinationLoaded) {
              List<DestinationEntity> list = state.data;
              return AspectRatio(
                aspectRatio: 1,
                child: PageView.builder(
                  itemBuilder: (context, index){
                    DestinationEntity destination = list[index];

                    return itemTopDestination(destination);
                  },
                  itemCount: list.length,
                  controller: topPageController,
                  physics: const BouncingScrollPhysics(),
                ),
              );
            }
            return const SizedBox(height: 120,);
          }
        )
      ],
    );
  }

  Widget itemTopDestination(DestinationEntity destination) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: ExtendedImage.network(
                URLs.image(destination.cover),
                width: double.infinity,
                fit: BoxFit.cover,
                handleLoadingProgress: true,
                loadStateChanged: (ExtendedImageState state) {
                  if (state.extendedImageLoadState == LoadState.failed) {
                    return AspectRatio(
                      aspectRatio: 16/9,
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey,
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
              
                  if (state.extendedImageLoadState == LoadState.loading) {
                    return AspectRatio(
                      aspectRatio: 16/9,
                      child: Material(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey,
                        child: const CircleLoading(),
                      ),
                    );
                  }
              
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.name,
                      style: const TextStyle(
                        height: 1,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          alignment: Alignment.centerLeft,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ),
                        const SizedBox(width: 4,),
                        Text(
                          destination.location,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.fiber_manual_record,
                            color: Colors.grey,
                            size: 10,
                          ),
                        ),
                        const SizedBox(width: 4,),
                        Text(
                          destination.category,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: destination.rate,
                        allowHalfRating: true,
                        unratedColor: Colors.grey,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                        itemSize: 15,
                        ignoreGestures: true,
                      ),
                      const SizedBox(width: 4,),
                      Text(
                          '(${DMethod.numberAutoDigit(destination.rate)})',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border)
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  allDestination() {
    return const SizedBox();
  }
}
