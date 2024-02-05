class Datastream():
    def __init__(self, input):
        self.input = input

    def start_of_packet(self):
        for i in range(4, len(self.input)):
            sub = self.input[i-4:i]
            if len(set(sub)) == 4:
                return i
        return -1

    def start_of_message(self):
        for i in range(14, len(self.input)):
            sub = self.input[i-14:i]
            if len(set(sub)) == 14:
                return i
        return -1
