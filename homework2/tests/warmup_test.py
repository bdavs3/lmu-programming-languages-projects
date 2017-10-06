import math
import pytest
from warmup import (change, strip_quotes, scramble, say, triples, powers,
                    interleave, Cylinder, make_crypto_functions, random_name)


def test_change():
    assert change(0) == (0, 0, 0, 0)
    assert change(97) == (3, 2, 0, 2)
    assert change(8) == (0, 0, 1, 3)
    assert change(250) == (10, 0, 0, 0)
    assert change(144) == (5, 1, 1, 4)
    assert change(97) == (3, 2, 0, 2)
    assert change(100000000000) == (4000000000, 0, 0, 0)
    with pytest.raises(ValueError) as excinfo:
        change(-50)
    assert str(excinfo.value) == 'amount cannot be negative'

def test_strip_quotes():
    assert strip_quotes('') == ''
    assert strip_quotes('Hello, world') == 'Hello, world'
    assert strip_quotes('"\'') == ''
    assert strip_quotes('a"""\'\'"z') == 'az'

def test_scramble():
    for s in ['a', 'rat', 'JavaScript testing', '', 'zzz', '^*&^*&^▱ÄÈËɡɳɷ']:
        assert sorted(s) == sorted(scramble(s))
    possibilities = set(['ABC', 'ACB', 'BAC', 'BCA', 'CAB', 'CBA'])
    for _ in range(200):
        possibilities.discard(scramble('ABC'))
    assert not possibilities

def test_say():
    assert say() == ''
    assert say('hi')() == 'hi'
    assert say('hi')('there')() == 'hi there'
    assert say('hello')('my')('name')('is')('Colette')() == 'hello my name is Colette'

def test_triples():
    assert triples(0) == []
    assert triples(5) == [(3, 4, 5)]
    assert triples(40) == [(3, 4, 5), (5, 12, 13), (6, 8, 10), (7, 24, 25), (8, 15, 17),
                           (9, 12, 15), (10, 24, 26), (12, 16, 20), (12, 35, 37),
                           (15, 20, 25), (15, 36, 39), (16, 30, 34), (18, 24, 30),
                           (20, 21, 29), (21, 28, 35), (24, 32, 40)]

def test_powers():
    p = powers(2, 10)
    assert next(p) == 1
    assert next(p) == 2
    assert next(p) == 4
    assert next(p) == 8
    with pytest.raises(StopIteration):
        next(p)
    assert list(powers(2, -5)) == []
    assert list(powers(7, 0)) == []
    assert list(powers(3, 1)) == [1]
    assert list(powers(2, 63)) == [1, 2, 4, 8, 16, 32]
    assert list(powers(2, 64)) == [1, 2, 4, 8, 16, 32, 64]

def test_interleave():
    assert interleave([]) == []
    assert interleave([1, 4, 6]) == [1, 4, 6]
    assert interleave([], 2, 3) == [2, 3]
    assert interleave([1], 9) == [1, 9]
    assert interleave([8, 8, 3, 9], 1) == [8, 1, 8, 3, 9]
    assert interleave([2], 7, '8', {}) == [2, 7, '8', {}]

def test_cylinder():
    c = Cylinder(radius=10, height=5)
    assert c.height == 5
    assert c.radius == 10
    c = Cylinder(height=5)
    assert c.height == 5
    assert c.radius == 1
    c = Cylinder(radius=5)
    assert c.height == 1
    assert c.radius == 5
    c = Cylinder()
    assert c.height == 1
    assert c.radius == 1
    c = Cylinder(radius=2, height=10)
    assert pytest.approx(c.volume, 0.000001) == 40 * math.pi
    assert pytest.approx(c.surface_area, 0.000001) == 48 * math.pi
    c.widen(3)
    assert c.radius == 6
    c.stretch(2)
    assert c.height == 20
    assert pytest.approx(c.surface_area, 0.000001) == 312 * math.pi
    assert pytest.approx(c.volume, 0.000001) == 720 * math.pi

def test_crypto():
    e, d = make_crypto_functions('zombie devops feynman123', '0000000000000000')
    assert e(b'Hello......world') == b'\x15\x8a\xa5a\xd8\x07\\d(e\xc9\xbes*\x13\x9f'
    assert d(b'\x15\x8a\xa5a\xd8\x07\\d(e\xc9\xbes*\x13\x9f') == b'Hello......world'
    for s in [b'', b'\xfe9iP\x05\x22\x490opXZ@1##']:
        assert d(e(s)) == s

def test_random_name():
    p = random_name(gender='female', region='canada')
    assert len(p) > 3
    assert ', ' in p
    with pytest.raises(ValueError) as excinfo:
        random_name(gender='fjweiuw', region='canada')
    assert '{"error":"Invalid gender"}' in str(excinfo.value)
