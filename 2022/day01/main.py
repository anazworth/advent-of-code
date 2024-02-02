from calories import Calories

def main():
    with open("input.txt", "r") as file:
        input = file.read()
    c = Calories(input)
    result, result_two = c.calculate()
    print("Part one:", result)
    print("Part two:", result_two)


if __name__ == "__main__":
    main()
