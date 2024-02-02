class Calories():
    
    def __init__(self, input):
        self.input = input

    def calculate(self):
        elves = []
        input = self.input.split("\n\n")


        for elf in input:
            elves.append(elf.split("\n"))


        for elf in elves:
            total = 0
            for calorie in elf:
                if calorie == "":
                    continue
                total += int(calorie)
            elves[elves.index(elf)] = total

        elves.sort()

        return max(elves), sum(elves[-3:])
