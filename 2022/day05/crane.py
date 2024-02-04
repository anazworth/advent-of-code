import re

class Crane():
    def __init__(self, input):
        crates, instructions = input.split('\n\n')
        self.crates=crates.split("\n")
        self.instructions = instructions.split("\n")
        self.instructions = [x for x in self.instructions if x != '']

    def top_crate(self):
        stacks = []
        for _ in range(50):
            stacks.append([])

        for line in self.crates:
            for i, char in enumerate(line):
                if char.isalpha():
                    stacks[i].append(char)

        stacks = [x for x in stacks if x != []]

        for stack in stacks:
            stack.reverse()

        for instruction in self.instructions:
            amount, start, end = re.findall(r'(\d+)', instruction)
            for _ in range(int(amount)):
                stacks[int(end)-1].append(stacks[int(start)-1].pop())
            

        result = ""
        for stack in stacks:
            for char in stack.pop():
                result += char

        return result

    def top_crate_2(self):
        stacks = []
        for _ in range(50):
            stacks.append([])
        for line in self.crates:
            for i, char in enumerate(line):
                if char.isalpha():
                    stacks[i].append(char)

        stacks = [x for x in stacks if x != []]

        for stack in stacks:
            stack.reverse()

        for instruction in self.instructions:
            amount, start, end = re.findall(r'(\d+)', instruction)
            temp = []
            for _ in range(int(amount)):
                temp.append(stacks[int(start)-1].pop())
            temp.reverse()
            for crate in temp:
                stacks[int(end)-1].append(crate)

        result = ""
        for stack in stacks:
            for char in stack.pop():
                result += char
        return result
