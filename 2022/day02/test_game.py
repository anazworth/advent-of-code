from game import Game

EXAMPLE = """
A Y
B X
C Z
"""

def test_calculate():
    game = Game(EXAMPLE)
    result = game.calculate()
    assert result == 15

def test_calculate_two():
    game = Game(EXAMPLE)
    result = game.calculate_p2()
    assert result == 12
