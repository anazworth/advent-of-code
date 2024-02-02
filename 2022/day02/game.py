class Game():

    def __init__(self, input):
        self.input = input

    def calculate(self):
        input = self.input.split('\n')

        points_dict = {
            "A X": 4,
            "A Y": 8,
            "A Z": 3,
            "B X": 1,
            "B Y": 5,
            "B Z": 9,
            "C X": 7,
            "C Y": 2,
            "C Z": 6,
        }

        for line in input:
            if line == "":
                continue
            input[input.index(line)] = points_dict[line]
        input = filter(lambda x: x != "", input)
        return sum(input)

    def calculate_p2(self):
        input = self.input.split('\n')
        points_dict = { # X -> Lose, Y -> Draw, Z -> Win
            "A X": 3,
            "A Y": 4,
            "A Z": 8,
            "B X": 1,
            "B Y": 5,
            "B Z": 9,
            "C X": 2,
            "C Y": 6,
            "C Z": 7,
        }

        for line in input:
            if line == "":
                continue
            input[input.index(line)] = points_dict[line]
        input = filter(lambda x: x != "", input)
        return sum(input)
