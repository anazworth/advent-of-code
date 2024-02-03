class Rucksack():
    def __init__(self, input):
        input = input.split('\n')
        self.input = [x for x in input if x != '']

    def sum_priorities(self):
        sum = 0

        for line in self.input:
            half = len(line) // 2
            left, right = line[:half], line[half:]

            left_map = {}

            for char in left:
                left_map[char] = left_map.get(char, 0) + 1

            for char in right:
                if char in left_map:
                    if 'a' <= char <= 'z':
                        sum += ord(char) - 96
                    if 'A' <= char <= 'Z':
                        sum += ord(char) - 38
                    break

        return sum

    def sum_badge_type(self):
        sum = 0

        # Split input into groups of 3
        input = [self.input[i:i+3] for i in range(0, len(self.input), 3)]


        for rucks in input:
            common_char = set(rucks[0]) & set(rucks[1]) & set(rucks[2])
            common_char = list(common_char)[0]

            if 'a' <= common_char <= 'z':
                sum += ord(common_char) - 96
            if 'A' <= common_char <= 'Z':
                sum += ord(common_char) - 38

        return sum

