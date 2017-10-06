# pragma pylint: disable=E0001
# pragma pylint: disable=C0111

from random import shuffle
from itertools import product
import math
import requests

def change(amount):
    if amount < 0:
        raise ValueError('amount cannot be negative')
    quarters = amount // 25
    dimes = (amount - quarters * 25) // 10
    nickels = (amount - quarters * 25 - dimes * 10) // 5
    pennies = (amount - quarters * 25 - dimes * 10 - nickels * 5)
    return (quarters, dimes, nickels, pennies)

def strip_quotes(string):
    return string.replace('\'', '').replace('"', '')

def scramble(string):
    result = list(string)
    shuffle(result)
    return ''.join(result)

def powers(base, limit):
    current = 1
    while current <= limit:
        yield current
        current *= base

def triples(largest_hypotenuse):
    result = []
    pairs = list(product(range(1, largest_hypotenuse), repeat=2))
    for i, j in pairs:
        if (j, i) in pairs:
            pairs.remove((j, i))
    for a, b in pairs:
        c = math.sqrt(a * a + b * b)
        if c % 1 == 0 and c <= largest_hypotenuse:
            result += [(a if a < b else b, b if b > a else a, int(c))]
    return result

def say(string1=None):
    if string1 is None:
        return ''
    def _inner_say(string2=None):
        """
        if val is None we return _inner_adder.v
        else we increment and return ourselves
        """
        if string2 is None:
            return _inner_say.string1
        _inner_say.string1 += ' ' + string2
        return _inner_say
    _inner_say.string1 = string1  # save value
    return _inner_say

def interleave(a, *b):
    return [a[0]] + interleave(list(b), *a[1:]) if a else list(b)

class Cylinder(object):
    def __init__(self, radius=1, height=1):
        self.radius = radius
        self.height = height

    @property
    def surface_area(self):
        return 2 * math.pi * (self.radius * self.radius + self.radius * self.height)

    @property
    def volume(self):
        return self.radius * self.radius * math.pi * self.height

    def widen(self, factor):
        self.radius *= factor

    def stretch(self, factor):
        self.height *= factor

def make_crypto_functions():
    return 1

def random_name(**kwargs):
    # options = {
    # uri: 'http://uinames.com/api/',
    # qs: {
    #     amount: 1,
    #     gender: kwargs.gender,
    #     region: kwargs.region,
    #     },
    #     json: true,
    # };
    # return rp(options).then(response => '({},{})'.format(response.surname, response.name))
    # .catch(err => err.status);
    request = requests.options('http://uinames.com/api/')
