import 'package:flutter/material.dart';

class Movies extends StatefulWidget {
  @override
  _MoviesAppState createState() => _MoviesAppState();
}

class _MoviesAppState extends State<Movies> {
  final List movieList = Movie.getMovies();
  final List movies = [
    "Avatar",
    "I am Legend",
    "300",
    "The Avengers",
    "The Wolf of Wall Street",
    "Interstaller",
    "Beauty and the Beast",
    "Game of Thrones",
    "Vikings",
    "Gotham",
    "Power",
    "Narcos",
    "Breaking Bad",
    "Doctor Strange",
    "Rogue one : A star wars Story",
    "Assassins Creed",
    "Luke Cage",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      backgroundColor: Colors.blue.shade300,
      body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(children: <Widget>[
              movieCard(movieList[index], context),
              Positioned(top: 10, child: movieImage(movieList[index].images[1]))
            ]);
            // return Card(
            //   elevation: 9,
            //   margin: EdgeInsets.only(left: 2, bottom: 10, right: 3),
            //   color: Colors.grey[100],
            //   child: ListTile(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => MoviesList(
            //                     movieName: movieList.elementAt(index).title,
            //                     movie: movieList[index],
            //                   )));
            //     },
            //     //onTap: () {debugPrint("${movies[index]}");},
            //     leading: CircleAvatar(
            //       backgroundColor: Colors.black,
            //       child: Container(
            //         //child: Text("M"),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(14),
            //             image: DecorationImage(
            //                 image: NetworkImage(movieList[index].images[0]),
            //                 fit: BoxFit.cover)),
            //       ),
            //     ),
            //     title: Text(movieList[index].title),
            //     subtitle: Text(movieList[index].title
            //         //"Entertainment",
            //         ),
            //     trailing: Text("..."),
            //   ),
            // );
          }),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
        child: Container(
            margin: EdgeInsets.only(left: 50),
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Card(
              shadowColor: Colors.red[200],
              elevation: 20,
              color: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.only(left: 54.0, right: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                                child: Text(
                              movie.title,
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            )),
                            Text(
                              "Rating: ${movie.imdbrating}",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.orange),
                            )
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text("Released: ${movie.released}"),
                          Text(movie.runtime),
                          Text(movie.rated)
                        ],
                      )
                    ]),
              ),
            )),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MoviesList(
                        movieName: movie.title,
                        movie: movie,
                      )));
        });
  }

  Widget movieImage(String imageurl) {
    return Container(
      //margin: EdgeInsets.only(top:5),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(imageurl))),
    );
  }
}

// Route (new page or screen)----
class MoviesList extends StatelessWidget {
  final String movieName;
  final Movie movie;
  const MoviesList({Key key, this.movieName, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MoviesDetails"),
        backgroundColor: Colors.blueGrey.shade500,
      ),
      body: ListView(
        children: <Widget>[
          MovieListThumbnail(
            thumbnail: movie.images[0],
          ),
          MovieListHeaderWithPoster(movie: movie),
          //SizedBox(width: 20,),
          //HorizontalLine(),
          MovieListCast(movie: movie),
          HorizontalLine(),
          MovieListExtraPosters(posters: movie.images)
        ],
      ),
      // body: Center(
      //   child: Container(
      //     child: RaisedButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       child: Text("Content : ${this.movie.title}"),
      //     ),
      //   ),
      // ),
    );
  }
}

class MovieListThumbnail extends StatelessWidget {
  final String thumbnail;

  const MovieListThumbnail({Key key, this.thumbnail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(thumbnail), fit: BoxFit.cover)),
            ),
            Icon(
              Icons.play_circle_outline,
              color: Colors.white,
              size: 100,
            ),
          ],
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        )
      ],
    );
  }
}

class MovieListHeaderWithPoster extends StatelessWidget {
  final Movie movie;

  const MovieListHeaderWithPoster({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: <Widget>[
          MovieListPoster(poster: movie.images[0].toString()),
          SizedBox(width: 15),
          Expanded(child: MovieListHeader(movie: movie))
        ],
      ),
    );
  }
}

class MovieListHeader extends StatelessWidget {
  final Movie movie;

  const MovieListHeader({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${movie.year} : ${movie.genre}".toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.w400, color: Colors.green, fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("${movie.title}".toUpperCase(),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        Text.rich(TextSpan(
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            children: <TextSpan>[
              TextSpan(text: movie.plot),
              TextSpan(
                  text: "More..",
                  style: TextStyle(fontSize: 16, color: Colors.blue[600]))
            ]))
      ],
    );
  }
}

class MovieListPoster extends StatelessWidget {
  final String poster;

  const MovieListPoster({Key key, this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      elevation: 15,
      shadowColor: Colors.pink,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 200,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(poster), fit: BoxFit.cover)),
        ),
      ),
    );
  }
}

class MovieListCast extends StatelessWidget {
  final Movie movie;

  const MovieListCast({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: <Widget>[
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Director", value: movie.director),
          MovieField(field: "Awards", value: movie.awards)
        ]),
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field;
  final String value;

  const MovieField({Key key, this.field, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "$field: ",
          style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 15,
              fontWeight: FontWeight.w300),
        ),
        Expanded(
            child: Text(
          value,
          style: TextStyle(
              fontSize: 13, color: Colors.black, fontWeight: FontWeight.w300),
        ))
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Container(
        height: 1,
        color: Colors.blueGrey,
      ),
    );
  }
}

class MovieListExtraPosters extends StatelessWidget {
  final List posters;

  const MovieListExtraPosters({Key key, this.posters}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "More Movie Posters...".toUpperCase(),
              style: TextStyle(fontSize: 14, color: Colors.red),
            ),
          ),
        ),
        Container(
          height: 200,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 160,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(posters[index]),
                              fit: BoxFit.cover)),
                    ),
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    width: 8,
                  ),
              itemCount: posters.length),
        )
      ],
    );
  }
}

//##########################################################################################################//

class Movie {
  static List getMovies() => [
        Movie(
            "Avatar",
            "2009",
            "PG-13",
            "18 Dec 2009",
            "162 min",
            "Action, Adventure, Fantasy",
            "James Cameron",
            "James Cameron",
            "Sam Worthington, Zoe Saldana, Sigourney Weaver, Stephen Lang",
            "A paraplegic marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.",
            "English, Spanish",
            "USA, UK",
            "Won 3 Oscars. Another 80 wins & 121 nominations.",
            "http://ia.media-imdb.com/images/M/MV5BMTYwOTEwNjAzMl5BMl5BanBnXkFtZTcwODc5MTUwMw@@._V1_SX300.jpg",
            "83",
            "7.9",
            "890,617",
            "tt0499549",
            "movie",
            "True", [
          //"https://www.google.com/imgres?imgurl=https%3A%2F%2Fs3.amazonaws.com%2Fffe-ugc%2Favatar%2Fassets%2F00692962-426c-11e7-883d-000d3a3122f5.jpg%3Fv%3D2&imgrefurl=https%3A%2F%2Fwww.avatar.com%2Ffilms&tbnid=bkYkCIThgcBObM&vet=12ahUKEwj27pCVvZjrAhXtKbcAHYT3D8cQMygZegUIARD0AQ..i&docid=OWU0PfCv7W4RmM&w=1200&h=630&q=images%20of%20Avatar&ved=2ahUKEwj27pCVvZjrAhXtKbcAHYT3D8cQMygZegUIARD0AQ",
          //"https://www.google.com/imgres?imgurl=https%3A%2F%2Fresizing.flixster.com%2F787LjiaSqVGgWVzogHentyq-vTc%3D%2F206x305%2Fv1.bTsxMTE3Njc5MjtqOzE4NTc5OzEyMDA7ODAwOzEyMDA&imgrefurl=https%3A%2F%2Fwww.rottentomatoes.com%2Fm%2Favatar&tbnid=gXFtCT0pHhnOSM&vet=12ahUKEwj27pCVvZjrAhXtKbcAHYT3D8cQMygKegUIARDQAQ..i&docid=aE_uOwgyZ8vojM&w=206&h=305&q=images%20of%20Avatar&ved=2ahUKEwj27pCVvZjrAhXtKbcAHYT3D8cQMygKegUIARDQAQ",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMjEyOTYyMzUxNl5BMl5BanBnXkFtZTcwNTg0MTUzNA@@._V1_SX1500_CR0,0,1500,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BNzM2MDk3MTcyMV5BMl5BanBnXkFtZTcwNjg0MTUzNA@@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTY2ODQ3NjMyMl5BMl5BanBnXkFtZTcwODg0MTUzNA@@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTMxOTEwNDcxN15BMl5BanBnXkFtZTcwOTg0MTUzNA@@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTYxMDg1Nzk1MV5BMl5BanBnXkFtZTcwMDk0MTUzNA@@._V1_SX1500_CR0,0,1500,999_AL_.jpg"
        ]),
        Movie(
            "I Am Legend",
            "2007",
            "PG-13",
            "14 Dec 2007",
            "101 min",
            "Drama, Horror, Sci-Fi",
            "Francis Lawrence",
            "Mark Protosevich (screenplay), Akiva Goldsman (screenplay), Richard Matheson (novel), John William Corrington, Joyce Hooper Corrington",
            "Will Smith, Alice Braga, Charlie Tahan, Salli Richardson-Whitfield",
            "Years after a plague kills most of humanity and transforms the rest into monsters, the sole survivor in New York City struggles valiantly to find a cure.",
            "English",
            "USA",
            "9 wins & 21 nominations.",
            "http://ia.media-imdb.com/images/M/MV5BMTU4NzMyNDk1OV5BMl5BanBnXkFtZTcwOTEwMzU1MQ@@._V1_SX300.jpg",
            "65",
            "7.2",
            "533,874",
            "tt0480249",
            "movie",
            "True", [
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTI0NTI4NjE3NV5BMl5BanBnXkFtZTYwMDA0Nzc4._V1_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTIwMDg2MDU4M15BMl5BanBnXkFtZTYwMTA0Nzc4._V1_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTc5MDM1OTU5OV5BMl5BanBnXkFtZTYwMjA0Nzc4._V1_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTA0MTI2NjMzMzFeQTJeQWpwZ15BbWU2MDMwNDc3OA@@._V1_.jpg"
        ]),
        Movie(
            "300",
            "2006",
            "R",
            "09 Mar 2007",
            "117 min",
            "Action, Drama, Fantasy",
            "Zack Snyder",
            "Zack Snyder (screenplay), Kurt Johnstad (screenplay), Michael Gordon (screenplay), Frank Miller (graphic novel), Lynn Varley (graphic novel)",
            "Gerard Butler, Lena Headey, Dominic West, David Wenham",
            "King Leonidas of Sparta and a force of 300 men fight the Persians at Thermopylae in 480 B.C.",
            "English",
            "USA",
            "16 wins & 42 nominations.",
            "http://ia.media-imdb.com/images/M/MV5BMjAzNTkzNjcxNl5BMl5BanBnXkFtZTYwNDA4NjE3._V1_SX300.jpg",
            "52",
            "7.7",
            "611,046",
            "tt0416449",
            "movie",
            "True", [
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTMwNTg5MzMwMV5BMl5BanBnXkFtZTcwMzA2NTIyMw@@._V1_SX1777_CR0,0,1777,937_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTQwNTgyNTMzNF5BMl5BanBnXkFtZTcwNDA2NTIyMw@@._V1_SX1777_CR0,0,1777,935_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTc0MjQzOTEwMV5BMl5BanBnXkFtZTcwMzE2NTIyMw@@._V1_SX1777_CR0,0,1777,947_AL_.jpg"
        ]),
        Movie(
            "The Avengers",
            "2012",
            "PG-13",
            "04 May 2012",
            "143 min",
            "Action, Sci-Fi, Thriller",
            "Joss Whedon",
            "Joss Whedon (screenplay), Zak Penn (story), Joss Whedon (story)",
            "Robert Downey Jr., Chris Evans, Mark Ruffalo, Chris Hemsworth",
            "Earth's mightiest heroes must come together and learn to fight as a team if they are to stop the mischievous Loki and his alien army from enslaving humanity.",
            "English, Russian",
            "USA",
            "Nominated for 1 Oscar. Another 34 wins & 75 nominations.",
            "http://ia.media-imdb.com/images/M/MV5BMTk2NTI1MTU4N15BMl5BanBnXkFtZTcwODg0OTY0Nw@@._V1_SX300.jpg",
            "69",
            "8.1",
            "1,003,301",
            "tt0848228",
            "movie",
            "True", [
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTA0NjY0NzE4OTReQTJeQWpwZ15BbWU3MDczODg2Nzc@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMjE1MzEzMjcyM15BMl5BanBnXkFtZTcwNDM4ODY3Nw@@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMjMwMzM2MTg1M15BMl5BanBnXkFtZTcwNjM4ODY3Nw@@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ4NzM2Mjc5MV5BMl5BanBnXkFtZTcwMTkwOTY3Nw@@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTc3MzQ3NjA5N15BMl5BanBnXkFtZTcwMzY5OTY3Nw@@._V1_SX1777_CR0,0,1777,999_AL_.jpg"
        ]),
        Movie(
            "The Wolf of Wall Street",
            "2013",
            "R",
            "25 Dec 2013",
            "180 min",
            "Biography, Comedy, Crime",
            "Martin Scorsese",
            "Terence Winter (screenplay), Jordan Belfort (book)",
            "Leonardo DiCaprio, Jonah Hill, Margot Robbie, Matthew McConaughey",
            "Based on the true story of Jordan Belfort, from his rise to a wealthy stock-broker living the high life to his fall involving crime, corruption and the federal government.",
            "English, French",
            "USA",
            "Nominated for 5 Oscars. Another 35 wins & 154 nominations.",
            "http://ia.media-imdb.com/images/M/MV5BMjIxMjgxNTk0MF5BMl5BanBnXkFtZTgwNjIyOTg2MDE@._V1_SX300.jpg",
            "75",
            "8.2",
            "786,985",
            "tt0993846",
            "movie",
            "True", [
          "https://images-na.ssl-images-amazon.com/images/M/MV5BNDIwMDIxNzk3Ml5BMl5BanBnXkFtZTgwMTg0MzQ4MDE@._V1_SX1500_CR0,0,1500,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTc0NzAxODAyMl5BMl5BanBnXkFtZTgwMDg0MzQ4MDE@._V1_SX1500_CR0,0,1500,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTExMDk1MDE4NzVeQTJeQWpwZ15BbWU4MDM4NDM0ODAx._V1_SX1500_CR0,0,1500,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTg3MTY4NDk4Nl5BMl5BanBnXkFtZTgwNjc0MzQ4MDE@._V1_SX1500_CR0,0,1500,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTgzMTg4MDI0Ml5BMl5BanBnXkFtZTgwOTY0MzQ4MDE@._V1_SY1000_CR0,0,1553,1000_AL_.jpg"
        ]),
        Movie(
            "Interstellar",
            "2014",
            "PG-13",
            "07 Nov 2014",
            "169 min",
            "Adventure, Drama, Sci-Fi",
            "Christopher Nolan",
            "Jonathan Nolan, Christopher Nolan",
            "Ellen Burstyn, Matthew McConaughey, Mackenzie Foy, John Lithgow",
            "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
            "English",
            "USA, UK",
            "Won 1 Oscar. Another 39 wins & 134 nominations.",
            "http://ia.media-imdb.com/images/M/MV5BMjIxNTU4MzY4MF5BMl5BanBnXkFtZTgwMzM4ODI3MjE@._V1_SX300.jpg",
            "74",
            "8.6",
            "937,412",
            "tt0816692",
            "movie",
            "True", [
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMjA3NTEwOTMxMV5BMl5BanBnXkFtZTgwMjMyODgxMzE@._V1_SX1500_CR0,0,1500,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMzQ5ODE2MzEwM15BMl5BanBnXkFtZTgwMTMyODgxMzE@._V1_SX1500_CR0,0,1500,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTg4Njk4MzY0Nl5BMl5BanBnXkFtZTgwMzIyODgxMzE@._V1_SX1500_CR0,0,1500,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMzE3MTM0MTc3Ml5BMl5BanBnXkFtZTgwMDIyODgxMzE@._V1_SX1500_CR0,0,1500,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BNjYzNjE2NDk3N15BMl5BanBnXkFtZTgwNzEyODgxMzE@._V1_SX1500_CR0,0,1500,999_AL_.jpg"
        ]),
        Movie(
            "Game of Thrones",
            "2011–",
            "TV-MA",
            "17 Apr 2011",
            "56 min",
            "Adventure, Drama, Fantasy",
            "N/A",
            "David Benioff, D.B. Weiss",
            "Peter Dinklage, Lena Headey, Emilia Clarke, Kit Harington",
            "While a civil war brews between several noble families in Westeros, the children of the former rulers of the land attempt to rise up to power. Meanwhile a forgotten race, bent on destruction, plans to return after thousands of years in the North.",
            "English",
            "USA, UK",
            "Won 1 Golden Globe. Another 185 wins & 334 nominations.",
            "http://ia.media-imdb.com/images/M/MV5BMjM5OTQ1MTY5Nl5BMl5BanBnXkFtZTgwMjM3NzMxODE@._V1_SX300.jpg",
            "N/A",
            "9.5",
            "1,046,830",
            "tt0944947",
            "series",
            "True", [
          "https://images-na.ssl-images-amazon.com/images/M/MV5BNDc1MGUyNzItNWRkOC00MjM1LWJjNjMtZTZlYWIxMGRmYzVlXkEyXkFqcGdeQXVyMzU3MDEyNjk@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BZjZkN2M5ODgtMjQ2OC00ZjAxLWE1MjMtZDE0OTNmNGM0NWEwXkEyXkFqcGdeQXVyNjUxNzgwNTE@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMDk4Y2Y1MDAtNGVmMC00ZTlhLTlmMmQtYjcyN2VkNzUzZjg2XkEyXkFqcGdeQXVyNjUxNzgwNTE@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BNjZjNWIzMzQtZWZjYy00ZTkwLWJiMTYtOWRkZDBhNWJhY2JmXkEyXkFqcGdeQXVyMjk3NTUyOTc@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BNTMyMTRjZWEtM2UxMS00ZjU5LWIxMTYtZDA5YmJhZmRjYTc4XkEyXkFqcGdeQXVyMjk3NTUyOTc@._V1_SX1777_CR0,0,1777,999_AL_.jpg"
        ]),
        Movie(
            "Vikings",
            "2013–",
            "TV-14",
            "03 Mar 2013",
            "44 min",
            "Action, Drama, History",
            "N/A",
            "Michael Hirst",
            "Travis Fimmel, Clive Standen, Gustaf Skarsgård, Katheryn Winnick",
            "The world of the Vikings is brought to life through the journey of Ragnar Lothbrok, the first Viking to emerge from Norse legend and onto the pages of history - a man on the edge of myth.",
            "English, Old English, Norse, Old, Latin",
            "Ireland, Canada",
            "Nominated for 7 Primetime Emmys. Another 17 wins & 49 nominations.",
            "http://ia.media-imdb.com/images/M/MV5BOTEzNzI3MDc0N15BMl5BanBnXkFtZTgwMzk1MzA5NzE@._V1_SX300.jpg",
            "N/A",
            "8.6",
            "198,041",
            "tt2306299",
            "series",
            "True", [
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMjM5MTM1ODUxNV5BMl5BanBnXkFtZTgwNTAzOTI2ODE@._V1_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BNzU2NDcxODMyOF5BMl5BanBnXkFtZTgwNDAzOTI2ODE@._V1_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMjMzMzIzOTU2M15BMl5BanBnXkFtZTgwODMzMTkyODE@._V1_SY1000_SX1500_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ2NTQ2MDA3NF5BMl5BanBnXkFtZTgwODkxMDUxODE@._V1_SY1000_SX1500_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTcxOTQ3NTA5N15BMl5BanBnXkFtZTgwMzExMDUxODE@._V1_SY1000_SX1500_AL_.jpg"
        ]),
        Movie(
            "Gotham",
            "2014–",
            "TV-14",
            "01 Aug 2014",
            "42 min",
            "Action, Crime, Drama",
            "N/A",
            "Bruno Heller",
            "Ben McKenzie, Donal Logue, David Mazouz, Sean Pertwee",
            "The story behind Detective James Gordon's rise to prominence in Gotham City in the years before Batman's arrival.",
            "English",
            "USA",
            "Nominated for 4 Primetime Emmys. Another 3 wins & 22 nominations.",
            "http://ia.media-imdb.com/images/M/MV5BMTY2MjMwNDE4OV5BMl5BanBnXkFtZTgwNjI1NjU0OTE@._V1_SX300.jpg",
            "N/A",
            "8.0",
            "133,375",
            "tt3749900",
            "series",
            "True", [
          "https://images-na.ssl-images-amazon.com/images/M/MV5BNDI3ODYyODY4OV5BMl5BanBnXkFtZTgwNjE5NDMwMDI@._V1_SY1000_SX1500_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMjA5OTExMTIwNF5BMl5BanBnXkFtZTgwMjI5NDMwMDI@._V1_SY1000_SX1500_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTA3MDY2NjA3MzBeQTJeQWpwZ15BbWU4MDU0MDkzODgx._V1_SX1499_CR0,0,1499,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMjM3MzYzNDgzOV5BMl5BanBnXkFtZTgwMjQwOTM4ODE@._V1_SY1000_CR0,0,1498,1000_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMjQwODAyNjk0NF5BMl5BanBnXkFtZTgwODU4MzMyODE@._V1_SY1000_CR0,0,1500,1000_AL_.jpg"
        ]),
        Movie(
            "Power",
            "2014–",
            "TV-MA",
            "N/A",
            "50 min",
            "Crime, Drama",
            "N/A",
            "Courtney Kemp Agboh",
            "Omari Hardwick, Joseph Sikora, Andy Bean, Lela Loren",
            "James \"Ghost\" St. Patrick, a wealthy New York night club owner who has it all, catering for the city's elite and dreaming big, lives a double life as a drug kingpin.",
            "English",
            "USA",
            "1 win & 6 nominations.",
            "http://ia.media-imdb.com/images/M/MV5BOTA4NTkzMjUzOF5BMl5BanBnXkFtZTgwNzg5ODkxOTE@._V1_SX300.jpg",
            "N/A",
            "8.0",
            "14,770",
            "tt3281796",
            "series",
            "True", [
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTc2ODg0MzMzM15BMl5BanBnXkFtZTgwODYxODA5NTE@._V1_SY1000_SX1500_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTcyMjA0MzczNV5BMl5BanBnXkFtZTgwNTIyODA5NTE@._V1_SY1000_SX1500_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTk0MTI0NzQ2NV5BMl5BanBnXkFtZTgwMDkxODA5NTE@._V1_SY1000_SX1500_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ4Mzk1ODcxM15BMl5BanBnXkFtZTgwNDQyODA5NTE@._V1_SY1000_SX1500_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTUwNTE0NDI1M15BMl5BanBnXkFtZTgwMDQyODA5NTE@._V1_SY1000_SX1500_AL_.jpg"
        ]),
        Movie(
            "Narcos",
            "2015–",
            "TV-MA",
            "28 Aug 2015",
            "49 min",
            "Biography, Crime, Drama",
            "N/A",
            "Carlo Bernard, Chris Brancato, Doug Miro, Paul Eckstein",
            "Wagner Moura, Boyd Holbrook, Pedro Pascal, Joanna Christie",
            "A chronicled look at the criminal exploits of Colombian drug lord Pablo Escobar.",
            "English, Spanish",
            "USA",
            "Nominated for 2 Golden Globes. Another 4 nominations.",
            "http://ia.media-imdb.com/images/M/MV5BMTU0ODQ4NDg2OF5BMl5BanBnXkFtZTgwNzczNTE4OTE@._V1_SX300.jpg",
            "N/A",
            "8.9",
            "118,680",
            "tt2707408",
            "series",
            "True", [
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTk2MDMzMTc0MF5BMl5BanBnXkFtZTgwMTAyMzA1OTE@._V1_SX1500_CR0,0,1500,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMjIxMDkyOTEyNV5BMl5BanBnXkFtZTgwNjY3Mjc3OTE@._V1_SY1000_SX1500_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMjA2NDUwMTU2NV5BMl5BanBnXkFtZTgwNTI1Mzc3OTE@._V1_SY1000_CR0,0,1499,1000_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BODA1NjAyMTQ3Ml5BMl5BanBnXkFtZTgwNjI1Mzc3OTE@._V1_SY1000_CR0,0,1499,1000_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTU0NzQ0OTAwNl5BMl5BanBnXkFtZTgwMDAyMzA1OTE@._V1_SX1500_CR0,0,1500,999_AL_.jpg"
        ]),
        Movie(
            "Breaking Bad",
            "2008–2013",
            "TV-14",
            "20 Jan 2008",
            "49 min",
            "Crime, Drama, Thriller",
            "N/A",
            "Vince Gilligan",
            "Bryan Cranston, Anna Gunn, Aaron Paul, Dean Norris",
            "A high school chemistry teacher diagnosed with inoperable lung cancer turns to manufacturing and selling methamphetamine in order to secure his family's financial future.",
            "English, Spanish",
            "USA",
            "Won 2 Golden Globes. Another 132 wins & 218 nominations.",
            "http://ia.media-imdb.com/images/M/MV5BMTQ0ODYzODc0OV5BMl5BanBnXkFtZTgwMDk3OTcyMDE@._V1_SX300.jpg",
            "N/A",
            "9.5",
            "889,883",
            "tt0903747",
            "series",
            "True", [
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTgyMzI5NDc5Nl5BMl5BanBnXkFtZTgwMjM0MTI2MDE@._V1_SY1000_CR0,0,1498,1000_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTQ2NDkwNDk5NV5BMl5BanBnXkFtZTgwNDM0MTI2MDE@._V1_SY1000_CR0,0,1495,1000_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTM4NDcyNDMzMF5BMl5BanBnXkFtZTgwOTI0MTI2MDE@._V1_SY1000_CR0,0,1495,1000_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTAzMTczMjM3NjFeQTJeQWpwZ15BbWU4MDc1MTI1MzAx._V1_SY1000_CR0,0,1495,1000_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMjA5MTE3MTgwMF5BMl5BanBnXkFtZTgwOTQxMjUzMDE@._V1_SX1500_CR0,0,1500,999_AL_.jpg"
        ]),
        Movie(
            //bool ComingSoon: "true",
            "Doctor Strange",
            "2016",
            "N/A",
            "04 Nov 2016",
            "N/A",
            "Action, Adventure, Fantasy",
            "Scott Derrickson",
            "Scott Derrickson (screenplay), C. Robert Cargill (screenplay), Jon Spaihts (story by), Scott Derrickson (story by), C. Robert Cargill (story by), Steve Ditko (comic book)",
            "Rachel McAdams, Benedict Cumberbatch, Mads Mikkelsen, Tilda Swinton",
            "After his career is destroyed, a brilliant but arrogant and conceited surgeon gets a new lease on life when a sorcerer takes him under her wing and trains him to defend the world against evil.",
            "English",
            "USA",
            "N/A",
            "http://ia.media-imdb.com/images/M/MV5BNjgwNzAzNjk1Nl5BMl5BanBnXkFtZTgwMzQ2NjI1OTE@._V1_SX300.jpg",
            "N/A",
            "N/A",
            "N/A",
            "tt1211837",
            "movie",
            "True",
            [
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMjM3ODc1ODI5Ml5BMl5BanBnXkFtZTgwODMzMDY3OTE@._V1_.jpg",
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMTgxNTAyNTU0NV5BMl5BanBnXkFtZTgwNzMzMDY3OTE@._V1_.jpg",
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMjE5NDc5NzUwNV5BMl5BanBnXkFtZTgwMDM3MDM2NzE@._V1_.jpg"
            ]),
        Movie(
            "Rogue One: A Star Wars Story",
            "2016",
            "N/A",
            "16 Dec 2016",
            "N/A",
            "Action, Adventure, Sci-Fi",
            "Gareth Edwards",
            "Chris Weitz (screenplay), Tony Gilroy (screenplay), John Knoll (story), Gary Whitta (story), George Lucas (characters)",
            "Felicity Jones, Riz Ahmed, Mads Mikkelsen, Ben Mendelsohn",
            "The Rebellion makes a risky move to steal the plans to the Death Star, setting up the epic saga to follow.",
            "English",
            "USA",
            "1 nomination.",
            "https://images-na.ssl-images-amazon.com/images/M/MV5BMjQyMzI2OTA3OF5BMl5BanBnXkFtZTgwNDg5NjQ0OTE@._V1_SY1000_CR0,0,674,1000_AL_.jpg",
            "N/A",
            "N/A",
            "N/A",
            "tt3748528",
            "movie",
            "True", [
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMjE3MzA4Nzk3NV5BMl5BanBnXkFtZTgwNjAxMTc1ODE@._V1_SX1777_CR0,0,1777,744_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BNDMxMTQzMjQxM15BMl5BanBnXkFtZTgwNzAxMTc1ODE@._V1_SX1777_CR0,0,1777,744_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTUyNjkxOTk5NV5BMl5BanBnXkFtZTgwODAxMTc1ODE@._V1_SX1777_CR0,0,1777,744_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BNjM4MzExNDAyNl5BMl5BanBnXkFtZTgwOTAxMTc1ODE@._V1_SX1777_CR0,0,1777,744_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMjE3NTgxMDcyNV5BMl5BanBnXkFtZTgwMDExMTc1ODE@._V1_SX1777_CR0,0,1777,744_AL_.jpg"
        ]),
        Movie(
            "Assassin's Creed",
            "2016",
            "N/A",
            "21 Dec 2016",
            "N/A",
            "Action, Adventure, Fantasy",
            "Justin Kurzel",
            "Bill Collage (screenplay), Adam Cooper (screenplay), Michael Lesslie (screenplay)",
            "Michael Fassbender, Michael Kenneth Williams, Marion Cotillard, Jeremy Irons",
            "When Callum Lynch explores the memories of his ancestor Aguilar and gains the skills of a Master Assassin, he discovers he is a descendant of the secret Assassins society.",
            "English",
            "UK, France, USA, Hong Kong",
            "N/A",
            "http://ia.media-imdb.com/images/M/MV5BMTU2MTQwMjU1OF5BMl5BanBnXkFtZTgwMDA5NjU5ODE@._V1_SX300.jpg",
            "N/A",
            "N/A",
            "N/A",
            "tt2094766",
            "movie",
            "True", [
          "https://images-na.ssl-images-amazon.com/images/M/MV5BN2EyYzgyOWEtNTY2NS00NjRjLWJiNDYtMWViMjg5MWZjYjgzXkEyXkFqcGdeQXVyNjUwNzk3NDc@._V1_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTYwOWYzOTctOTc4My00ZmJkLTgzMTctMmUxNDI5ODQzYzNjXkEyXkFqcGdeQXVyNDAyODU1Njc@._V1_SX1500_CR0,0,1500,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BZTY5ZGUxMTAtYTU0OC00NGQ2LTkzNzgtZGZmNjlmNjY3MGU0XkEyXkFqcGdeQXVyNTY0MTkxMTg@._V1_SY1000_CR0,0,1500,1000_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BZjA0MWYwZTEtYzc5Yi00NGM2LTg1YTctNjY2YzQ0NDJhZDAwXkEyXkFqcGdeQXVyNDAyODU1Njc@._V1_SY1000_CR0,0,1499,1000_AL_.jpg"
        ]),
        Movie(
            //"ComingSoon": true,
            "Luke Cage",
            "2016–",
            "TV-MA",
            "30 Sep 2016",
            "55 min",
            "Action, Crime, Drama",
            "N/A",
            "Cheo Hodari Coker",
            "Mahershala Ali, Mike Colter, Frankie Faison, Erik LaRay Harvey",
            "Given superstrength and durability by a sabotaged experiment, a wrongly accused man escapes prison to become a superhero for hire.",
            "English",
            "USA",
            "N/A",
            "http://ia.media-imdb.com/images/M/MV5BMTcyMzc1MjI5MF5BMl5BanBnXkFtZTgwMzE4ODY2OTE@._V1_SX300.jpg",
            "N/A",
            "N/A",
            "N/A",
            "tt3322314",
            "series",
            "True",
            [
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMjMxNjc1NjI0NV5BMl5BanBnXkFtZTgwNzA0NzY0ODE@._V1_SY1000_CR0,0,1497,1000_AL_.jpg",
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMjI1MDg3NjY2OF5BMl5BanBnXkFtZTgwNDE1NDU4OTE@._V1_SY1000_CR0,0,1497,1000_AL_.jpg",
              "https://images-na.ssl-images-amazon.com/images/M/MV5BOTYzOTQyNDYxNl5BMl5BanBnXkFtZTgwNzA1NDU4OTE@._V1_SY1000_CR0,0,1498,1000_AL_.jpg",
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMTgxMjA3MTQ5Ml5BMl5BanBnXkFtZTgwOTA1NDU4OTE@._V1_SY1000_CR0,0,1498,1000_AL_.jpg",
              "https://images-na.ssl-images-amazon.com/images/M/MV5BMjMyNjg5ODYwNF5BMl5BanBnXkFtZTgwMTE1NDU4OTE@._V1_SY1000_CR0,0,1477,1000_AL_.jpg"
            ])
      ];

  String title;
  String year;
  String rated;
  String released;
  String runtime;
  String genre;
  String director;
  String writer;
  String actors;
  String plot;
  String language;
  String country;
  String awards;
  String poster;
  String metascore;
  String imdbrating;
  String imdbvotes;
  String imdbid;
  String type;
  String response;
  List images;

  Movie(
      this.title,
      this.year,
      this.rated,
      this.released,
      this.runtime,
      this.genre,
      this.director,
      this.writer,
      this.actors,
      this.plot,
      this.language,
      this.country,
      this.awards,
      this.poster,
      this.metascore,
      this.imdbrating,
      this.imdbvotes,
      this.imdbid,
      this.type,
      this.response,
      this.images);
}
