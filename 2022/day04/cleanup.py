import re

class Cleanup():
    def __init__(self, input):
        input = input.split('\n')
        self.input = [x for x in input if x != '']

    def total_pairs_contained(self):
        sum_contained, sum_overlapped = 0, 0

        for line in self.input:
            str_1, str_2 = line.split(',')
            arr_1 = re.findall(r'\d+', str_1)
            arr_2 = re.findall(r'\d+', str_2)
            arr_1 = list(map(int, arr_1))
            arr_2 = list(map(int, arr_2))
            
            left = list(range(arr_1[0], arr_1[1]+1))
            right = list(range(arr_2[0], arr_2[1]+1))

            sum_contained += 1 if Cleanup.is_contained(left, right) else 0
            sum_overlapped += 1 if Cleanup.is_overlap(left, right) else 0

        return sum_contained, sum_overlapped

    @staticmethod
    def is_contained(arr_1, arr_2):
        if set(arr_1).issubset(set(arr_2)):
            return True
        elif set(arr_2).issubset(set(arr_1)):
            return True
        return False

    @staticmethod
    def is_overlap(arr_1, arr_2):
        if set(arr_1).intersection(set(arr_2)):
            return True
        return False

