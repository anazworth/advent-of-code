from cleanup import Cleanup

EXAMPLE = """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
"""

def test_is_contained():
    assert Cleanup.is_contained([1, 2, 3], [1, 2, 3, 4, 5]) == True
    assert Cleanup.is_contained([1, 2, 3, 4, 5], [1, 2, 3]) == True
    assert Cleanup.is_contained([1, 2, 3], [1, 2, 4, 5]) == False
    assert Cleanup.is_contained([1, 2, 4, 5], [1, 2, 3]) == False

def test_total_pairs_contained():
    c = Cleanup(EXAMPLE)
    assert c.total_pairs_contained()[0] == 2

def test_total_pairs_overlapped():
    c = Cleanup(EXAMPLE)
    assert c.total_pairs_contained()[1] == 4

