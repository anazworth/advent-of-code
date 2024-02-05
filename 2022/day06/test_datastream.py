import datastream

example_1 = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
example_2 = "bvwbjplbgvbhsrlpgdmjqwftvncz"
example_3 = "nppdvjthqldpwncqszvftbrmjlhg"
example_4 = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
example_5 = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"

def test_start_of_packet():
    ds = datastream.Datastream(example_1)
    assert ds.start_of_packet() == 7

    ds = datastream.Datastream(example_2)
    assert ds.start_of_packet() == 5

    ds = datastream.Datastream(example_3)
    assert ds.start_of_packet() == 6

    ds = datastream.Datastream(example_4)
    assert ds.start_of_packet() == 10

    ds = datastream.Datastream(example_5)
    assert ds.start_of_packet() == 11

def test_start_of_message():
    ds = datastream.Datastream(example_1)
    assert ds.start_of_message() == 19

    ds = datastream.Datastream(example_2)
    assert ds.start_of_message() == 23

    ds = datastream.Datastream(example_3)
    assert ds.start_of_message() == 23

    ds = datastream.Datastream(example_4)
    assert ds.start_of_message() == 29

    ds = datastream.Datastream(example_5)
    assert ds.start_of_message() == 26
