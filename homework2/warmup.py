# pragma pylint: disable=E0001
# pragma pylint: disable=C0111
from random import shuffle

def change(amount):
    """Returns the smallest number of U.S. quarters, dimes, nickels, and
    pennies that equal the given amount."""
    if amount < 0:
        raise ValueError('amount cannot be negative')
    quarters = amount // 25
    dimes = (amount - quarters * 25) // 10
    nickels = (amount - quarters * 25 - dimes * 10) // 5
    pennies = (amount - quarters * 25 - dimes * 10 - nickels * 5)
    return (quarters, dimes, nickels, pennies)

# def strip_quotes(str):
#
def scramble(array):
    result = list(array)
    shuffle(result)
    return ''.join(result)
# def powers(base, limit):
#
def triples():
    return 0
# def say():
#
# def interleave():
#
# def Cylinder():
#
# def make_crypto_functions():
#
# def random_name():
