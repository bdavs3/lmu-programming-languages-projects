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
  charArr.forEach((char) => {
    const random = Math.floor(Math.random() * str.length);
    [charArr[str.indexOf(char)], charArr[random]] =
    [charArr[random], charArr[str.indexOf(char)]];
  });
  for (let i = charArr.length; i > 0; i -= 1) {
    const random = Math.floor(Math.random() * i);
    [charArr[i - 1], charArr[random]] = [charArr[random], charArr[i - 1]];
  }
  charArr.forEach((char) => { result += char; });
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

function say(str) {
  if (str === undefined) { return ''; }
  let result = `${str} `;
  const nextWord = (next) => {
    if (next !== undefined) {
      result += `${next} `;
      return nextWord;
    }
    return result.trim();
  };
  return nextWord;
}

function interleave(arr, ...args) {
  const a = arr.slice();
  const b = args.slice();
  const result = [];
  while (a.length > 0 || b.length > 0) {
    if (a[0] !== undefined) { result.push(a.shift()); }
    if (b[0] !== undefined) { result.push(b.shift()); }
  }
  return result;
}

function cylinder(spec) {
  let { radius = 1, height = 1 } = spec;
  const volume = () => Math.PI * radius * radius * height;
  const surfaceArea = () =>
    (2 * Math.PI * radius * height) + (2 * Math.PI * radius * radius);
  const widen = (factor) => { radius *= factor; };
  const stretch = (factor) => { height *= factor; };

  const result = {
    volume, surfaceArea, widen, stretch,
  };

  Object.defineProperty(result, 'radius', { get: () => radius });
  Object.defineProperty(result, 'height', { get: () => height });

  return Object.freeze(result);
}

const crypto = require('crypto');

function makeCryptoFunctions(key, alg) {
  const encrypt = (str) => {
    const cipher = crypto.createCipher(alg, key);
    let crypted = cipher.update(str, 'utf8', 'hex');
    crypted += cipher.final('hex');
    return crypted;
  };
  const decrypt = (str) => {
    const decipher = crypto.createDecipher(alg, key);
    let decrypted = decipher.update(str, 'hex', 'utf8');
    decrypted += decipher.final('utf8');
    return decrypted;
  };
  return [encrypt, decrypt];
}

const rp = require('request-promise');

function randomName(spec) {
  const options = {
    uri: 'http://uinames.com/api/',
    qs: {
      amount: 1,
      gender: spec.gender,
      region: spec.region,
    },
    json: true,
  };
  return rp(options).then(response => `${response.surname}, ${response.name}`)
    .catch(err => err.status);
}

module.exports = {
  change,
  stripQuotes,
  scramble,
  powers,
  powersGenerator,
  say,
  interleave,
  cylinder,
  makeCryptoFunctions,
  randomName,
};
