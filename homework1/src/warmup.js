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

function powers(base, lim, callback) {
  for (let currentPow = 1; currentPow <= lim; currentPow *= base) {
    callback(currentPow);
  }
}

function* powersGenerator(base, lim) {
  let currentPow = 1;
  while (currentPow <= lim) {
    yield currentPow;
    currentPow *= base;
  }
}

function interleave(arr, ...args) {
  const requiredLength = arr.length + args.length;
  const result = [];
  for (let i = 0; i < requiredLength; i += 1) {
    if (arr[0] !== undefined) result.push(arr.shift());
    if (args[0] !== undefined) result.push(args.shift());
  }
  return result;
}

function cylinder(obj) {
  let r = obj.radius === undefined ? 1 : obj.radius;
  let h = obj.height === undefined ? 1 : obj.height;
  const pi = Math.PI;
  const volume = function volume() {
    return (pi * r * r * h);
  };
  const surfaceArea = function surfaceArea() {
    return (2 * pi * r * h) + (2 * pi * r * r);
  };
  const widen = function widen(factor) {
    r *= factor;
  };
  const stretch = function stretch(factor) {
    h *= factor;
  };
  return Object.freeze({
    volume,
    surfaceArea,
    widen,
    stretch,
    radius: r,
    height: h,
  });
}

module.exports = {
  change,
  stripQuotes,
  scramble,
  powers,
  powersGenerator,
  interleave,
  cylinder,
};
