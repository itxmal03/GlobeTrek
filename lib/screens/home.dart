import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:globe_trek/core/constants/size_config.dart';
import 'package:globe_trek/screens/all_popular_places_screen.dart';
import 'package:globe_trek/viewModels/popular_places_view_model.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List horipics = [
    {'img': 'assets/images/hori1.jpeg', 'name': 'Bali Highlands'},
    {'img': 'assets/images/hori2.jpeg', 'name': 'Maldives'},
    {'img': 'assets/images/hori3.jpeg', 'name': 'Banff, Canada'},
    {'img': 'assets/images/hori4.jpg', 'name': 'Swiss Alps'},
  ];

  List vertipics = [
    {
      'img': 'assets/images/verti1.jpg',
      'name': 'Murree',
      'subtitle': 'Mist in the Pines',
    },
    {
      'img': 'assets/images/verti2.jpg',
      'name': 'Nathia Gali',
      'subtitle': 'Nature’s Whispering Trails',
    },
    {
      'img': 'assets/images/verti3.jpeg',
      'name': 'Swat Valley',
      'subtitle': 'Mini Switzerland of Pakistan',
    },
    {
      'img': 'assets/images/verti5.jpg',
      'name': 'Hunza',
      'subtitle': 'Where Peaks Touch the Sky',
    },
  ];

  @override
  void initState() {
    super.initState();
    final popularVM = Provider.of<PopularPlacesViewModel>(
      context,
      listen: false,
    );
    popularVM.getPlaces();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 30),
              SizedBox(height: 20),
              Container(
                height: SizeConfig.hp(25),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage("assets/image.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.black54, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Explore the World",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllPopularPlacesScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,  
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 240,
                child: Consumer<PopularPlacesViewModel>(
                  builder: (context, val, child) {
                    if (val.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (val.placesList.isEmpty) {
                      return Center(child: Text("No places found"));
                    }
                    final popularImagesList = val.placesList;
                    
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 165,
                          margin: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                popularImagesList[index].image!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),

                                bottomRight: Radius.circular(16),
                              ),
                              color: Colors.black54,
                            ),
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            child: Text(
                              popularImagesList[index].name!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    );
               
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nearest Places',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ListView.builder(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: vertipics.length,
                shrinkWrap: true,

                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ListTile(
                      title: Text(
                        vertipics[index]['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(vertipics[index]['subtitle']),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(11),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Explore',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(11),
                        child: Image.asset(
                          vertipics[index]['img'],
                          fit: BoxFit.cover,
                          width: 100,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
