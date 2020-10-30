import 'package:flutter/material.dart';
import 'dart:ui' as ui;

const common_duration = 200;

/// `name`: имя маршрута
Route createBlurRouteWithBlurBackground(Widget page, String name,
    {Object arguments}) {
  return PageRouteBuilder(
    opaque: false, // Делает новую страницу прозрачной
    transitionDuration:
        Duration(milliseconds: common_duration), // Скорость перехода
    reverseTransitionDuration:
        Duration(milliseconds: common_duration), // Скорость возврата
    settings: RouteSettings(name: name, arguments: arguments),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return MyBlurPage(child: child);
    },
  );
}

/// My Overlay opacity custom widget
class MyBlurPage extends StatefulWidget {
  /// Виджет с основным контентом страницы
  final Widget child;

  /// Продолжительность анимации в миллисекундах
  final int duration;

  /// Степень размытости фона
  final double opacity;

  /// Статический метод для обратной анимации
  ///
  /// Его НУЖНО вызывать из дочернего контента, т к
  /// по умолчанию окно закрывается только при косании размытой области
  /// MyBlurPage.pop(context);
  static void pop(BuildContext context) => _MyBlurPageState.reverse(context);

  const MyBlurPage(
      {Key key,
      this.child,
      this.duration = common_duration,
      this.opacity = 0}) // 0 = Не размывать
      : super(key: key);
  @override
  _MyBlurPageState createState() =>
      _MyBlurPageState(child: child, duration: duration, opacity: opacity);
}

class _MyBlurPageState extends State<MyBlurPage>
    with SingleTickerProviderStateMixin {
  final int duration;
  final double opacity;
  final Widget child;
  _MyBlurPageState(
      {@required this.duration, @required this.opacity, @required this.child});

  // Создание объекта анимации для размытия фона
  Animation<double> animationBlur;
  // Создание объекта анимации для прозрачности контента
  Animation<double> animationOpacity;
  // Создание контроллера анимации прозрачности фона
  // (статическая, т к используется в статическом методе)
  static AnimationController animationController;

  @override
  void initState() {
    super.initState();

    // Инициализация контроллера
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: duration));

    // Инициализация анимации размытости фона
    animationBlur = Tween(begin: 0.0, end: opacity).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    ));

    // Инициализация анимации прозрачности контента
    animationOpacity = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    ));

    // Запуск анимации
    animationController.forward();
  }

  // Статичский метод для обратной анимации
  static void reverse(BuildContext context) {
    // При касании запустить обратную анимацию
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // reverse(context); // Опционально (возврат на пред. экран при клике по blur)
      },
      child: Container(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Анимация фона
            AnimatedBuilder(
              animation: animationController,
              child: Container(
                color: Colors.transparent,
              ),
              builder: (context, child) {
                return BackdropFilter(
                  filter: ui.ImageFilter.blur(
                    sigmaX: animationBlur.value,
                    sigmaY: animationBlur.value,
                  ),
                  child: child,
                );
              },
            ),

            // Анимация контента
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: animationOpacity.value,
                  child: child,
                );
              },
              child: Container(
                child: GestureDetector(
                  // Переопределим для внутреннего виджета:
                  onTap: () {},
                  // Контент страцницы:
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
