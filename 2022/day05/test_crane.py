import crane

EXAMPLE = """    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
"""

def test_top_crate():
    c = crane.Crane(EXAMPLE)
    assert c.top_crate() == "CMZ"

def test_top_crate_2():
    c = crane.Crane(EXAMPLE)
    assert c.top_crate_2() == "MCD"
