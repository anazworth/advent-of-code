from game import Game

def main():
    with open("input.txt", "r") as file:
        file = file.read()
    g = Game(file)
    print("Part one:", g.calculate())
    print("Part two:", g.calculate_p2())

if __name__ == "__main__":
    main()
