import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height:40),
                SizedBox(
                  width: 350,
                  child: Text(
                    'Find your Happiness with Us!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  width: 350,
                  child: SizedBox(
                    width: 300,
                    child: Center(
                      child: SearchBar(
                        hintText: 'search your destination',
                        trailing: [Icon(Icons.search)],
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
            
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: horipics.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 165,
                        margin: EdgeInsets.symmetric(horizontal: 6),         
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          image: DecorationImage(
                            image: AssetImage(horipics[index]['img']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.all(8),
                        child: Text(
                          horipics[index]['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.black45,
                          ),
                        ),
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
      ),
    );
  }
}
