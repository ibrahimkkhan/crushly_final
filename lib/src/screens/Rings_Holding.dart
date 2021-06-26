import 'package:carousel_slider/carousel_slider.dart';

import '../blocs/Ring_Bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RingsPage extends StatefulWidget {
  _RingsPageState createState() => _RingsPageState();
}

class _RingsPageState extends State<RingsPage> with TickerProviderStateMixin {
  late AnimationController controller;
  bool isPanelUp = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 100), value: 0.0);
    controller.addStatusListener((status) {
      setState(() {
        status == AnimationStatus.completed || status == AnimationStatus.forward
            ? isPanelUp = true
            : isPanelUp = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size sizeAware = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AnimatedSwitcher(
            transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
            duration: Duration(milliseconds: 250),
            child: isPanelUp
                ? Text(
                    "Rings Offered",
                    key: ValueKey(1),
                    style: TextStyle(color: Colors.black),
                  )
                : Text(
                    "Rings Holding",
                    key: ValueKey(2),
                    style: TextStyle(color: Colors.black),
                  )),
        backgroundColor: Colors.white24,
      ),
      body: Container(
        height: sizeAware.height,
        width: sizeAware.width,
        child: BothPanels(controller),
      ),
    );
  }
}

class BothPanels extends StatefulWidget {
  BothPanels(this.controller);

  final AnimationController controller;

  _BothPanelsState createState() => _BothPanelsState();
}

class _BothPanelsState extends State<BothPanels> {
  late RingBloc ringBloc;

  @override
  void initState() {
    ringBloc = RingBloc();
    super.initState();

    ringBloc.add(GetHolOffRings());
    obacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(widget.controller);
  }

  @override
  void dispose() {
    ringBloc.close();
    super.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = widget.controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  late Animation<double> obacityAnimation;
  static const double headerHieght = 50.0;

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final hieght = constraints.biggest.height;
    final backPanelHeight = hieght - headerHieght;
    final frontPanelHieght = -headerHieght;
    return RelativeRectTween(
            begin: RelativeRect.fromLTRB(
                0.0, backPanelHeight, 0.0, frontPanelHieght),
            end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(
            CurvedAnimation(curve: Curves.linear, parent: widget.controller));
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(child: holdingRings(context)),
          PositionedTransition(
            rect: getPanelAnimation(constraints),
            child: Material(
              elevation: 20,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35)),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      widget.controller
                          .fling(velocity: isPanelVisible ? -1.0 : 1.0);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35)),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: headerHieght,
                      child: isPanelVisible
                          ? Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            )
                          : FadeTransition(
                              opacity: obacityAnimation,
                              child: Center(
                                child: Text(
                                  "Rings Offered",
                                  style: TextStyle(
                                      fontSize: 21,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                    ),
                  ),
                  Expanded(child: ringsOffered(context))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  bool loadingAccept = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: ringBloc,
      listenWhen: (prev, cur) => cur is ErrorAccorrd,
      listener: (context, state) {
        if (state is ErrorAccorrd) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: LayoutBuilder(
        builder: bothPanels,
      ),
    );
  }

  Widget ringsOffered(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;

    return BlocBuilder(
      bloc: ringBloc,
      buildWhen: (prev, cur) => !(cur is ErrorAccorrd),
      builder: (context, state) {
        if (state is HolOffRingsReady) {
          loadingAccept = false;
          if (state.offeredRings.isNotEmpty) {
            return Container(
              padding: EdgeInsets.only(bottom: 40),
              height: sizeAware.height,
              color: Colors.grey.withOpacity(0.3),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(
                      height: sizeAware.height * 0.5,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                    ),
                    items: state.offeredRings.map(
                      (ring) {
                        return Stack(
                          overflow: Overflow.visible,
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              height: MediaQuery.of(context).size.height * 0.8,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "lib/Fonts/a.jpg",
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  ring.owner.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Positioned(
                              top: sizeAware.height * 0.42,
                              left: sizeAware.width * 0.08,
                              child: Material(
                                elevation: 18,
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  width: sizeAware.width * 0.65,
                                  height: sizeAware.height * 0.15,
                                  child: loadingAccept
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Container(
                                              width: 55,
                                              height: 55,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.green),
                                              child: GestureDetector(
                                                onTap: () {
                                                  ringBloc.add(AcceptOffer(
                                                      "true", ring.id));
                                                  setState(() {
                                                    loadingAccept = true;
                                                  });
                                                },
                                                child: Container(
                                                    width: 55,
                                                    height: 55,
                                                    child: Icon(
                                                      Icons.done,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ),
                                            Container(
                                                width: 55,
                                                height: 55,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.red),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    ringBloc.add(AcceptOffer(
                                                        "false", ring.id));
                                                    setState(() {
                                                      loadingAccept = true;
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.cancel,
                                                    color: Colors.white,
                                                  ),
                                                ))
                                          ],
                                        ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              color: Colors.grey.withOpacity(0.3),
              child: Center(
                child: Text("No offered Rings"),
              ),
            );
          }
        }
        if (state is Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        return Container();
      },
    );
  }

  Widget holdingRings(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    return BlocBuilder(
      bloc: ringBloc,
      buildWhen: (prev, cur) => !(cur is ErrorAccorrd),
      builder: (context, state) {
        if (state is HolOffRingsReady) {
          if (state.holdingRings.isNotEmpty) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: sizeAware.height * 0.6,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                      ),
                      items: state.holdingRings.map(
                        (ring) {
                          return Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: Material(
                                  borderRadius: BorderRadius.circular(32),
                                  elevation: 10,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(32),
                                      child: Image.asset(
                                        "lib/Fonts/b.jpeg",
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    ring.owner.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: FlatButton(
                                  child: Text("return the ring",
                                      style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    ringBloc.add(ReturnRing(ring.id));
                                  },
                                ),
                              )
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(
                  //     bottom: 60,
                  //   ),
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.circle, color: Colors.grey),
                  //   child: IconButton(
                  //     icon: Icon(
                  //       Icons.message,
                  //       color: Colors.white,
                  //       size: 30,
                  //     ),
                  //     onPressed: () {},
                  //   ),
                  // )
                ]);
          } else {
            return Center(
              child: Text("No Holding Rings"),
            );
          }
        }
        if (state is ErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container();
      },
    );
  }
}
