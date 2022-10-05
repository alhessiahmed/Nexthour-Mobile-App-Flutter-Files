import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:nexthour/models/AppUiShortingModel.dart';
import 'package:nexthour/providers/app_ui_shorting_provider.dart';
import '../../common/facebook_ads.dart';
import '/models/episode.dart';
import '/providers/app_config.dart';
import '/providers/main_data_provider.dart';
import '/providers/menu_data_provider.dart';
import '/providers/movie_tv_provider.dart';
import '/ui/shared/actors_horizontal_list.dart';
import '/ui/shared/heading1.dart';
import '/ui/screens/horizental_genre_list.dart';
import '/ui/screens/horizontal_movies_list.dart';
import '/ui/screens/horizontal_tvseries_list.dart';
import '/ui/screens/top_video_list.dart';
import '/ui/shared/live_video_list.dart';
import '/ui/widgets/blog_view.dart';
import 'package:provider/provider.dart';
import 'featured-list.dart';
import 'home-screen-shimmer.dart';

class VideosPage extends StatefulWidget {
  VideosPage({Key? key, this.loading, this.menuId}) : super(key: key);
  final loading;
  final menuId;

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  bool get wantKeepAlive => true;

  GlobalKey _keyRed = GlobalKey();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var meData;
  ScrollController controller = ScrollController(initialScrollOffset: 0.0);
  bool _visible = false;
  var menuDataList;
  var moviesList;
  var tvSeriesList;
  var liveDataList;
  var topVideosList;
  var blogList;
  var actorsList;
  var actorsListLen;
  var topVideosListLen;
  var liveDataListLen;
  var moviesListLen;
  var upComingMovie;
  var upComingMovieLen;
  var tvSeriesListLen;
  var blogListLen;
  var featuredList;
  var featuredListLen;

  MenuDataProvider menuDataProvider = MenuDataProvider();
  MovieTVProvider movieTvDataProvider = MovieTVProvider();
  @override
  void initState() {
    super.initState();

    animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.2, end: 1.0).animate(animation);

    animation.forward();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      try {
        menuDataProvider =
            Provider.of<MenuDataProvider>(context, listen: false);
        await menuDataProvider.getMenusData(context, widget.menuId);

        movieTvDataProvider =
            Provider.of<MovieTVProvider>(context, listen: false);

        moviesList = menuDataProvider.menuCatMoviesList;
        tvSeriesList = menuDataProvider.menuCatTvSeriesList;
        liveDataList = menuDataProvider.liveDataList;
        menuDataList = menuDataProvider.menuDataList;
        topVideosList = movieTvDataProvider.topVideoList;
        blogList =
            Provider.of<AppConfig>(context, listen: false).appModel!.blogs;
        actorsList =
            Provider.of<MainProvider>(context, listen: false).actorList;
        moviesList.removeWhere((item) =>
            item.live == '1' || item.live == 1 || item.type != DatumType.M);
        tvSeriesList.removeWhere((item) =>
            item.live == '1' || item.live == 1 || item.type != DatumType.T);
        var newList = new List.from(moviesList)..addAll(tvSeriesList);
        featuredList = List.from(newList
            .where((item) => item.featured == "1" || item.featured == 1));
        upComingMovie = List.from(moviesList
            .where((item) => item.isUpcoming == "1" || item.isUpcoming == 1));
        actorsList = actorsList..shuffle();
        topVideosList = topVideosList..shuffle();
        blogList = blogList..shuffle();
        menuDataList = menuDataList..shuffle();
        moviesList = moviesList..shuffle();
        tvSeriesList = tvSeriesList..shuffle();
        featuredListLen = featuredList.length;
        actorsListLen = actorsList.length;
        topVideosListLen = topVideosList.length;
        liveDataListLen = liveDataList.length;
        moviesListLen = moviesList.length;
        tvSeriesListLen = tvSeriesList.length;
        blogListLen = blogList.length;
        upComingMovieLen = upComingMovie.length;

        await Provider.of<AppUIShortingProvider>(context, listen: false)
            .loadData(context);

        if (mounted) {
          setState(() {
            _visible = true;
          });
        }
      } catch (err) {
        return null;
      }
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    getMenuData();
  }

  getMenuData() async {
    try {
      menuDataProvider = Provider.of<MenuDataProvider>(context, listen: false);
      await menuDataProvider.getMenusData(context, widget.menuId);

      movieTvDataProvider =
          Provider.of<MovieTVProvider>(context, listen: false);
      moviesList = menuDataProvider.menuCatMoviesList;

      liveDataList = menuDataProvider.liveDataList;
      menuDataList = menuDataProvider.menuDataList;
      topVideosList = movieTvDataProvider.topVideoList;
      blogList = Provider.of<AppConfig>(context, listen: false).appModel!.blogs;
      actorsList = Provider.of<MainProvider>(context, listen: false).actorList;
      var newList = new List.from(moviesList)..addAll(tvSeriesList);
      featuredList = List.from(
          newList.where((item) => item.featured == "1" || item.featured == 1));
      upComingMovie = List.from(moviesList
          .where((item) => item.isUpcoming == "1" || item.isUpcoming == 1));
      moviesList.removeWhere((item) =>
          item.live == '1' || item.live == 1 || item.type != DatumType.M);
      tvSeriesList = menuDataProvider.menuCatTvSeriesList;

      tvSeriesList.removeWhere((item) =>
          item.live == '1' || item.live == 1 || item.type != DatumType.T);
      print("dta count: ${liveDataList.length}");

      await Provider.of<AppUIShortingProvider>(context, listen: false)
          .loadData(context);

      setState(() {
        actorsList = actorsList..shuffle();
        topVideosList = topVideosList..shuffle();
        blogList = blogList..shuffle();
        menuDataList = menuDataList..shuffle();
        moviesList = moviesList..shuffle();
        tvSeriesList = tvSeriesList..shuffle();
        featuredListLen = featuredList.length;
        actorsListLen = actorsList.length;
        topVideosListLen = topVideosList.length;
        liveDataListLen = liveDataList.length;
        moviesListLen = moviesList.length;
        tvSeriesListLen = tvSeriesList.length;
        blogListLen = blogList.length;
        upComingMovieLen = upComingMovie.length;
      });
    } catch (err) {
      return null;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  List<Widget> widgetList() {
    List<Widget> widgets = [
      SizedBox.shrink(),
      SizedBox.shrink(),
      SizedBox.shrink(),
      SizedBox.shrink(),
      SizedBox.shrink(),
      SizedBox.shrink(),
      SizedBox.shrink(),
      SizedBox.shrink(),
      SizedBox.shrink(),
      SizedBox.shrink(),
      showNativeAd_(),
    ];

    AppUiShortingModel appUiShortingModel =
        Provider.of<AppUIShortingProvider>(context, listen: false)
            .appUiShortingModel;

    appUiShortingModel.appUiShorting?.forEach((element) {
      if (element.name == "genre") {
        widgets[element.position! - 1] = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            HorizontalGenreList(
              loading: widget.loading,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        );
      } else if (element.name == "movies") {
        widgets[element.position! - 1] = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            moviesListLen == 0
                ? SizedBox.shrink()
                : Heading1(translate("Movies_"), "Mov", widget.loading),
            moviesListLen == 0
                ? SizedBox.shrink()
                : MoviesList(
                    type: DatumType.M,
                    loading: widget.loading,
                    data: moviesList),
            moviesListLen == 0
                ? SizedBox.shrink()
                : SizedBox(
                    height: 15.0,
                  ),
          ],
        );
      } else if (element.name == "tv_series") {
        widgets[element.position! - 1] = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            tvSeriesListLen == 0
                ? SizedBox.shrink()
                : Heading1(translate("TV_Series"), "TV", widget.loading),
            tvSeriesListLen == 0
                ? SizedBox.shrink()
                : TvSeriesList(
                    type: DatumType.T,
                    loading: widget.loading,
                    data: tvSeriesList),
            tvSeriesListLen == 0
                ? SizedBox.shrink()
                : SizedBox(
                    height: 15.0,
                  ),
          ],
        );
      } else if (element.name == "trending") {
        widgets[element.position! - 1] = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            topVideosListLen == 0
                ? SizedBox.shrink()
                : Heading1(
                    translate("Top_Movies___TV_Series"), "Top", widget.loading),
            topVideosListLen == 0
                ? SizedBox.shrink()
                : SizedBox(
                    height: 15.0,
                  ),
            topVideosListLen == 0
                ? SizedBox.shrink()
                : Container(
                    height: 350,
                    child: TopVideoList(
                      loading: widget.loading,
                    ),
                  ),
            featuredListLen == 0 || featuredList == null
                ? SizedBox.shrink()
                : Heading1(translate("Featured_"), "F", widget.loading),
            featuredListLen == 0 || featuredList == null
                ? SizedBox.shrink()
                : FeaturedList(menuByCat: featuredList),
          ],
        );
      } else if (element.name == "coming_soon") {
        widgets[element.position! - 1] = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            upComingMovieLen == 0 || upComingMovieLen == null
                ? SizedBox.shrink()
                : Heading1(translate("Coming_Soon"), "U", widget.loading),
            upComingMovieLen == 0 || upComingMovieLen == null
                ? SizedBox.shrink()
                : FeaturedList(menuByCat: upComingMovie),
          ],
        );
      } else if (element.name == "blog") {
        widgets[element.position! - 1] = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            blogListLen == 0
                ? SizedBox.shrink()
                : Heading1(translate("Our_Blog_Posts"), "Blog", widget.loading),
            blogListLen == 0
                ? SizedBox.shrink()
                : SizedBox(
                    height: 15.0,
                  ),
            blogListLen == 0 ? SizedBox.shrink() : BlogView(),
          ],
        );
      } else if (element.name == "live") {
        widgets[element.position! - 1] = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            liveDataListLen == 0
                ? SizedBox.shrink()
                : SizedBox(
                    height: 15.0,
                  ),
            liveDataListLen == 0
                ? SizedBox.shrink()
                : Heading2(translate("LIVE_"), "Live"),
            liveDataListLen == 0 ? SizedBox.shrink() : LiveVideoList(),
            liveDataListLen == 0
                ? SizedBox.shrink()
                : SizedBox(
                    height: 15.0,
                  ),
          ],
        );
      } else if (element.name == "artist") {
        widgets[element.position! - 1] = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            actorsListLen == 0
                ? SizedBox.shrink()
                : Heading1(translate("Artist_"), "Actor", widget.loading),
            actorsListLen == 0
                ? SizedBox.shrink()
                : SizedBox(
                    height: 15.0,
                  ),
            actorsListLen == 0
                ? SizedBox.shrink()
                : ActorsHorizontalList(loading: widget.loading),
            actorsListLen == 0
                ? SizedBox.shrink()
                : SizedBox(
                    height: 15.0,
                  ),
          ],
        );
      }
    });

    return widgets;
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshList,
      color: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).primaryColorLight,
      child: FadeTransition(
        opacity: _fadeInFadeOut,
        child: Container(
          child: _visible == false
              ? Center(
                  child: HomeScreenShimmer(
                    loading: true,
                  ),
                )
              : menuDataList.length == 0
                  ? Center(
                      child: Text(
                        translate("No_data_available"),
                        style: TextStyle(fontSize: 16.0),
                      ),
                    )
                  : Container(
                      child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: Column(
                          key: _keyRed,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: widgetList(),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animation.dispose();
    controller.dispose();
    super.dispose();
  }
}

void showDemoActionSheet(
    {required BuildContext context, required Widget child}) {
  showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child).then((String? value) {});
}
