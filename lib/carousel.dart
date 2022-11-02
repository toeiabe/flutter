import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Carousel extends StatefulWidget {
  final List<String> images;
  const Carousel({super.key, required this.images});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  bool _isLoading = true;

  int _index = 0;
  List<Widget> _animatedImage = [];
  final AutoScrollController _controller =
      AutoScrollController(axis: Axis.horizontal);
  int _scrollIndex = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var i = 0;
      for (var imageUrl in widget.images) {
        precacheImage(NetworkImage(imageUrl), context);

        NetworkImage(imageUrl).resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
            (info, call) {
              i++;
              if (i == widget.images.length - 1) {
                setState(() {
                  _isLoading = false;
                });
              }

              // do something
            },
          ),
        );
      }

      addimageList();
      setState(() {});
    });
  }

  void addimageList() {
    for (int i = 0; i < widget.images.length; i++) {
      _animatedImage.add(
        AnimatedOpacity(
          opacity: i == _index ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.images[i]),
              ),
            ),
          ),
        ),
      );
    }
  }

  Future _scroll() async {
    await _controller.scrollToIndex(_scrollIndex,
        preferPosition: AutoScrollPosition.begin);
  }

  @override
  Widget build(BuildContext context) {
    String? swipeDirection;
    String? swipeDirectionScroll;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width * 0.75;

    return Container(
      child: _isLoading
          ? SizedBox(
              height: height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                GestureDetector(
                  onHorizontalDragEnd: (detail) {
                    if (detail.primaryVelocity == null) {
                      return;
                    } else if (detail.primaryVelocity! < 0) {
                      if (_index >= widget.images.length - 1) {
                        return;
                      }
                      setState(() {
                        _index++;
                        _animatedImage = [];
                        addimageList();
                        if (_index > _scrollIndex + 3 ||
                            _index < _scrollIndex) {
                          if (_index <= widget.images.length - 4) {
                            _scrollIndex = _index;
                          } else {
                            _scrollIndex = widget.images.length - 4;
                          }
                          _scroll();
                        }
                      });
                    } else if (detail.primaryVelocity! > 0) {
                      if (_index <= 0) {
                        return;
                      }
                      setState(() {
                        _index--;
                        _animatedImage = [];
                        addimageList();
                        if (_index > _scrollIndex + 3 ||
                            _index < _scrollIndex) {
                          if (_index <= widget.images.length - 4) {
                            _scrollIndex = _index;
                          } else {
                            _scrollIndex = widget.images.length - 4;
                          }
                          _scroll();
                        }
                      });
                    }
                  },
                  child: Stack(
                    children: [
                      ..._animatedImage,
                      SizedBox(
                        width: width,
                        height: height,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                if (_index <= 0) {
                                  return;
                                }
                                setState(() {
                                  _index--;
                                  _animatedImage = [];
                                  addimageList();
                                  if (_index > _scrollIndex + 3 ||
                                      _index < _scrollIndex) {
                                    if (_index <= widget.images.length - 4) {
                                      _scrollIndex = _index;
                                    } else {
                                      _scrollIndex = widget.images.length - 4;
                                    }
                                    _scroll();
                                  }
                                });
                              },
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: () {
                                if (_index >= widget.images.length - 1) {
                                  return;
                                }
                                setState(() {
                                  _index++;
                                  _animatedImage = [];
                                  addimageList();
                                  if (_index > _scrollIndex + 3 ||
                                      _index < _scrollIndex) {
                                    if (_index <= widget.images.length - 4) {
                                      _scrollIndex = _index;
                                    } else {
                                      _scrollIndex = widget.images.length - 4;
                                    }
                                    _scroll();
                                  }
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onHorizontalDragEnd: (detail) {
                    if (detail.primaryVelocity == null) {
                      return;
                    } else if (detail.primaryVelocity! < 0) {
                      if (_scrollIndex <= widget.images.length - 5) {
                        setState(() {
                          _scrollIndex++;
                          _scroll();
                        });
                      }
                    } else if (detail.primaryVelocity! > 0) {
                      setState(() {
                        if (_scrollIndex > 0) {
                          _scrollIndex--;
                          _scroll();
                        }
                      });
                    }
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: height * 0.2,
                        child: ListView.separated(
                          itemCount: widget.images.length,
                          separatorBuilder: (context, i) => const SizedBox(
                            width: 10,
                          ),
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _controller,
                          itemBuilder: ((context, i) => AutoScrollTag(
                                key: ValueKey(i),
                                controller: _controller,
                                index: i,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _index = i;
                                      _animatedImage = [];
                                      addimageList();
                                    });
                                  },
                                  child: Container(
                                    width: (width - 30) / 4,
                                    height: height * 0.2,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(widget.images[i]),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: width,
                        height: height * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                setState(() {
                                  if (_scrollIndex > 0) {
                                    _scrollIndex--;
                                    _scroll();
                                  }
                                });
                              },
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: () {
                                if (_scrollIndex <= widget.images.length - 5) {
                                  setState(() {
                                    _scrollIndex++;
                                    _scroll();
                                  });
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
