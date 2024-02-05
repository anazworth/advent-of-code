import datastream

with open("input.txt", "r") as file:
    input = file.read()

ds = datastream.Datastream(input)
print("Part 1:", ds.start_of_packet())
print("Part 2:", ds.start_of_message())
