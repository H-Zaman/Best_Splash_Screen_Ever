import 'package:flutter/material.dart';
import 'package:mysplash/src/colors.dart';
import 'package:mysplash/src/quarter_circle.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{

  late AnimationController _firstAnimationController;
  late Animation<double> _firstAnimation;

  late AnimationController _secondAnimationController;
  late Animation<double> _secondAnimation;




  @override
  void initState() {
    super.initState();
    _firstAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1250)
    );

    _secondAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150)
    );

    _firstAnimation = Tween<double>(
      begin: 1.0,
      end: 30.0
    ).animate(_firstAnimationController);

    _secondAnimation = CurvedAnimation(
      parent: _secondAnimationController,
      curve: Curves.linear,
    );

    _firstAnimation.addListener(() {
      if(_firstAnimation.isCompleted){
        _secondAnimationController.forward();
        setState(() {
          animatedBorderLines = true;
        });
      }
    });
    _firstAnimationController.forward();

  }

  bool animatedBorderLines = false;

  @override
  Widget build(BuildContext context) {

    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: _mediaQuery.padding.top,
          bottom: _mediaQuery.padding.bottom,
          left: _mediaQuery.padding.left,
          right: _mediaQuery.padding.right,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                /// TOP HALF
                Expanded(
                  child: Row(
                    children: [
                      /// 1ST SECTION
                      Expanded(
                        child: Container(
                          color: Colors.black,
                          child: Center(
                            child: _CircularBox(
                              animation: _firstAnimation,
                              color: AppColors.GREEN
                            )
                          ),
                        ),
                      ),

                      /// 2ND SECTION
                      Expanded(
                        child: Container(
                          color: Colors.black,
                          child: Center(
                            child: _CircularBox(
                              animation: _firstAnimation,
                              color: AppColors.YELLOW
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// BOTTOM HALF
                Expanded(
                  child: Row(
                    children: [
                      /// 3RD SECTION
                      Expanded(
                        child: Container(
                          color: Colors.black,
                          child: Center(
                            child: _CircularBox(
                              animation: _firstAnimation,
                              color: AppColors.PURPLE
                            )
                          ),
                        ),
                      ),

                      /// 4TH SECTION
                      Expanded(
                        child: Container(
                          color: Colors.black,
                          child: Center(
                            child: _CircularBox(
                              animation: _firstAnimation,
                              color: AppColors.PINK
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


              ],
            ),

            /// center thingy
            // Center(
            //   child: AnimatedBuilder(
            //     animation: _secondAnimation,
            //     builder: (_,__) => AnimatedOpacity(
            //       duration: Duration(milliseconds: 150),
            //       opacity: _secondAnimationController.isCompleted ? 0 : 1,
            //       child: RotationTransition(
            //         turns: _secondAnimation,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Row(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 SizedBox(
            //                   height: 25,
            //                   width: 25,
            //                   child: QuarterCircle(
            //                     color: AppColors.GREEN,
            //                     circleAlignment: CircleAlignment.bottomRight,
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: 25,
            //                   width: 25,
            //                   child: QuarterCircle(
            //                     color: AppColors.YELLOW,
            //                     circleAlignment: CircleAlignment.bottomLeft,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             Row(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 SizedBox(
            //                   height: 25,
            //                   width: 25,
            //                   child: QuarterCircle(
            //                     color: AppColors.PURPLE,
            //                     circleAlignment: CircleAlignment.topRight,
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height: 25,
            //                   width: 25,
            //                   child: QuarterCircle(
            //                     color: AppColors.PINK,
            //                     circleAlignment: CircleAlignment.topLeft,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     )
            //   ),
            // ),


            /// top left
            _Line(
              left: 0,
              right: animatedBorderLines ? 6 : _mediaQuery.size.width,
              top: 0,
              color: AppColors.PINK
            ),

            /// top right
            _Line(
              right: 0,
              top: 0,
              bottom: animatedBorderLines ? 6 : _mediaQuery.size.height,
              color: AppColors.YELLOW
            ),

            /// bottom right
            _Line(
              right: 0,
              bottom: 0,
              left: animatedBorderLines ? 6 : _mediaQuery.size.width,
              color: AppColors.GREEN,
            ),

            /// bottom left
            _Line(
              left: 0,
              bottom: 0,
              top: animatedBorderLines ? 6 : _mediaQuery.size.height,
              color: AppColors.BLUE
            ),
          ],
        ),
      )
    );
  }
}

class _CircularBox extends StatelessWidget {
  final Animation animation;
  final Color color;
  const _CircularBox({
    required this.animation,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child){
        return AnimatedOpacity(
          duration: Duration(milliseconds: 400),
          opacity: animation.isCompleted ? 0 : 1,
          child: Container(
            height: animation.value,
            width: animation.value,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle
            ),
          ),
        );
      },
    );
  }
}

class _Line extends StatelessWidget {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final Color color;
  const _Line({Key? key, this.top, this.left, this.right, this.bottom, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      right: right,
      left: left,
      bottom: bottom,
      top: top,
      duration: Duration(milliseconds: 1250),
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: color,
        ),
      ),
    );
  }
}
