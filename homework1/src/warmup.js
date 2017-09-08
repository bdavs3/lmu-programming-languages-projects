function change(amt) {
  if (amt < 0) { throw new RangeError(); }
  const result = [];
  let remaining = amt;
  [25, 10, 5, 1].forEach((coin) => {
    result.push(Math.floor(remaining / coin));
    remaining %= coin;
  });
  return result;
}

function stripQuotes(str) {
  let result = '';
  for (let i = 0; i < str.length; i += 1) {
    if (str.charAt(i) !== '"' && str.charAt(i) !== '\'') {
      result += str.charAt(i);
    }
  }
  return result;
}

function scramble(str) {
  let result = '';
  const charArr = str.split('');
  for (let i = charArr.length; i > 0; i -= 1) {
    const random = Math.floor(Math.random() * i);
    [charArr[i - 1], charArr[random]] = [charArr[random], charArr[i - 1]];
  }
  for (let j = 0; j < charArr.length; j += 1) {
    result += charArr[j];
  }
  return result;
}

module.exports = {
  change, stripQuotes, scramble,
};
