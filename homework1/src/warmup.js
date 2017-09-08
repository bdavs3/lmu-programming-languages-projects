function change(amt) {
  const result = [];
  let remaining = amt;
  [25, 10, 5, 1].forEach((coin) => {
    result.push(Math.floor(remaining(coin)));
    remaining %= coin;
  });
  return result;
}

module.exports = {
  change
};
