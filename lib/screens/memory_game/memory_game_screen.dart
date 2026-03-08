import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/screens/faq_screen.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/memory_game/models/game_theme.dart';
import 'package:myapp/screens/memory_game/widgets/level_complete_dialog.dart';
import 'package:myapp/screens/settings_screen.dart';
import 'package:myapp/text.dart';
import 'package:myapp/widgets/bottom_nav_bar.dart';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  State<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  int _selectedIndex = 1;
  GameTheme? _selectedTheme;
  late List<String> _shuffledItems;
  late List<bool> _isFlipped;
  int? _previousIndex;
  bool _isProcessing = false;
  int _moves = 0;
  Timer? _timer;
  int _seconds = 0;
  bool _isGameStarted = false;
  late List<GameTheme> _gameThemes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _gameThemes = getGameThemes(context);
    _selectedTheme ??= _gameThemes.first;
    _initializeGame();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
    });
  }

  void _initializeGame() {
    if (_selectedTheme == null) return;
    final items = [..._selectedTheme!.items, ..._selectedTheme!.items];
    items.shuffle();
    setState(() {
      _shuffledItems = items;
      _isFlipped = List<bool>.filled(items.length, false);
      _previousIndex = null;
      _isProcessing = false;
      _moves = 0;
      _isGameStarted = false;
      _resetTimer();
    });
  }

  void _startGame() {
    if (_isGameStarted) return;

    setState(() {
      _isGameStarted = true;
      _isProcessing = true;
      _isFlipped = List<bool>.filled(_shuffledItems.length, true);
    });

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isFlipped = List<bool>.filled(_shuffledItems.length, false);
          _isProcessing = false;
        });
        _startTimer();
      }
    });
  }

  void _onCardTapped(int index) {
    if (!_isGameStarted || _isProcessing || _isFlipped[index]) return;

    if (_previousIndex != null) {
      setState(() {
        _moves++;
      });
    }

    setState(() {
      _isFlipped[index] = true;
      _isProcessing = true;
    });

    if (_previousIndex == null) {
      _previousIndex = index;
      setState(() {
        _isProcessing = false;
      });
    } else {
      if (_shuffledItems[_previousIndex!] == _shuffledItems[index]) {
        _previousIndex = null;
        if (_isFlipped.every((flipped) => flipped)) {
          _timer?.cancel();
          _showGameWonDialog();
        }
        setState(() {
          _isProcessing = false;
        });
      } else {
        Timer(const Duration(milliseconds: 800), () {
          if (mounted) {
            setState(() {
              _isFlipped[_previousIndex!] = false;
              _isFlipped[index] = false;
              _previousIndex = null;
              _isProcessing = false;
            });
          }
        });
      }
    }
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }

  void _showGameWonDialog() {
    _timer?.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withAlpha((0.7 * 255).round()),
      builder: (context) => LevelCompleteDialog(
        moves: _moves,
        time: _formatTime(_seconds),
        onReplay: () {
          Navigator.of(context).pop();
          _initializeGame();
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FAQScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTexts = AppTexts.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          appTexts.memoryGame,
          style: const TextStyle(
            fontFamily: 'Oswald',
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 121, 26, 139),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildThemeSelector(),
            _buildGameControls(),
            _buildStats(),
            Expanded(child: _buildGameBoard()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildStats() {
    final appTexts = AppTexts.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem(appTexts.time, _formatTime(_seconds)),
          _buildStatItem(appTexts.moves, _moves.toString()),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Oswald',
            fontSize: 24,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildThemeSelector() {
    final appTexts = AppTexts.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
            child: Text(
              appTexts.chooseTheme,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Color.fromARGB(255, 121, 26, 139),
                fontSize: 16,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: const Color.fromARGB(255, 121, 26, 139),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 121, 26, 139).withAlpha(38),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<GameTheme>(
                value: _selectedTheme,
                isExpanded: true,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color.fromARGB(255, 121, 26, 139),
                ),
                items: _gameThemes.map((theme) {
                  return DropdownMenuItem<GameTheme>(
                    value: theme,
                    child: Row(
                      children: [
                        Icon(
                          theme.icon,
                          color: const Color.fromARGB(255, 121, 26, 139),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          theme.name,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Color.fromARGB(255, 121, 26, 139),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (theme) {
                  if (!_isGameStarted && theme != null) {
                    setState(() {
                      _selectedTheme = theme;
                      _initializeGame();
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameControls() {
    final appTexts = AppTexts.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _isGameStarted ? null : _startGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isGameStarted
                  ? Colors.grey
                  : const Color.fromARGB(255, 121, 26, 139),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            child: Text(
              appTexts.startGame,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: _isGameStarted ? _initializeGame : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isGameStarted
                  ? const Color.fromARGB(255, 121, 26, 139)
                  : Colors.grey,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            child: Text(
              appTexts.resetGame,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameBoard() {
    return LayoutBuilder(builder: (context, constraints) {
      final crossAxisCount = (constraints.maxWidth / 80).floor();
      return GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount > 0 ? crossAxisCount : 1,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1.0,
        ),
        itemCount: _shuffledItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onCardTapped(index),
            child: Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_isFlipped[index] ? 3.14 : 0),
              child: Card(
                elevation: 8.0,
                shape: const CircleBorder(),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _isFlipped[index]
                        ? LinearGradient(
                            colors: [Colors.grey[200]!, Colors.grey[400]!],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : const LinearGradient(
                            colors: [Color(0xFFF9E79F), Color(0xFFF1C40F)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(100),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: _isFlipped[index]
                        ? Transform(
                            alignment: FractionalOffset.center,
                            transform: Matrix4.identity()..rotateY(3.14),
                            child: Text(
                              _shuffledItems[index],
                              style: TextStyle(
                                fontSize: _selectedTheme!.name ==
                                        AppTexts.of(context).numbers
                                    ? 40.0
                                    : 28.0,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.question_mark,
                            color: Colors.white,
                            size: 40,
                          ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
