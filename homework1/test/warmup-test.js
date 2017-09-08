const {
  change, stripQuotes, scramble, say, powers, interleave,
  powersGenerator, cylinder, makeCryptoFunctions, randomName,
} = require('../src/warmup');

require('should'); // eslint-disable-line import/no-extraneous-dependencies


// Helper for the scramble tests
function anagramsOfEachOther(s, t) {
  return s.split('').sort().join('') === t.split('').sort().join('');
}

// Helper for testing the callbacky problems
function generatorToArray(generator, ...args) {
  const result = [];
  generator(...args, x => result.push(x));
  return result;
}

describe('change', () => {
  it('handles zero', () => {
    change(0).should.eql([0, 0, 0, 0]);
  });

  it('computes answers for small integer values fine', () => {
    change(97).should.eql([3, 2, 0, 2]);
    change(8).should.eql([0, 0, 1, 3]);
    change(250).should.eql([10, 0, 0, 0]);
    change(144).should.eql([5, 1, 1, 4]);
    change(97).should.eql([3, 2, 0, 2]);
  });

  it('handles large values', () => {
    // This test only passes if the solution is efficient
    change(100000000000).should.eql([4000000000, 0, 0, 0]);
  });

  it('throws the proper exception for negative arguments', () => {
    (() => change(-50)).should.throw(RangeError);
  });
});

describe('stripQuotes', () => {
  it('works on the empty string', () => {
    stripQuotes('').should.eql('');
  });

  it('strips quotes properly for non-empty strings', () => {
    stripQuotes('Hello, world').should.eql('Hello, world');
    stripQuotes('"\'').should.eql('');
    stripQuotes('a"""\'\'"z').should.eql('az');
  });
});

describe('scramble', () => {
  it('scrambles properly', () => {
    ['a', 'rat', 'JavaScript testing', '', 'zzz', '^*^*)^▱ÄÈËɡɳɷ'].forEach(s =>
      anagramsOfEachOther(s, scramble(s)).should.be.true);
  });

  it('is really random (produces all permutations)', () => {
    const possibilities = new Set('ABC ACB BAC BCA CAB CBA'.split(' '));
    for (let i = 0; i < 200; i += 1) {
      possibilities.delete(scramble('ABC'));
    }
    possibilities.size.should.eql(0);
  });
});

describe('say', () => {
  it('works when there are no words', () => {
    say().should.eql('');
  });

  it('works when there are words', () => {
    say('hi')().should.eql('hi');
    say('hi')('there')().should.eql('hi there');
    say('hello')('my')('name')('is')('Colette')().should.eql('hello my name is Colette');
  });
});

describe('powers', () => {
  it('generates sequences of powers properly', () => {
    generatorToArray(powers, 2, -5).should.eql([]);
    generatorToArray(powers, 7, 0).should.eql([]);
    generatorToArray(powers, 3, 1).should.eql([1]);
    generatorToArray(powers, 2, 63).should.eql([1, 2, 4, 8, 16, 32]);
    generatorToArray(powers, 2, 64).should.eql([1, 2, 4, 8, 16, 32, 64]);
  });
});

describe('The powers generator', () => {
  it('works as expected', () => {
    const g1 = powersGenerator(2, 1);
    g1.next().should.eql({ value: 1, done: false });
    g1.next().should.eql({ value: undefined, done: true });
    const g2 = powersGenerator(3, 100);
    g2.next().should.eql({ value: 1, done: false });
    g2.next().should.eql({ value: 3, done: false });
    g2.next().should.eql({ value: 9, done: false });
    g2.next().should.eql({ value: 27, done: false });
    g2.next().should.eql({ value: 81, done: false });
    g2.next().should.eql({ value: undefined, done: true });
  });
});

describe('interleave', () => {
  it('interleaves properly', () => {
    interleave([]).should.eql([]);
    interleave([1, 4, 6]).should.eql([1, 4, 6]);
    interleave([], 2, 3).should.eql([2, 3]);
    interleave([1], 9).should.eql([1, 9]);
    interleave([8, 8, 3, 9], 1).should.eql([8, 1, 8, 3, 9]);
    interleave([2], 7, '8', {}).should.eql([2, 7, '8', {}]);
  });
});

describe('The cylinder function', () => {
  it('makes a cylinder from both arguments', () => {
    const c = cylinder({ radius: 10, height: 5 });
    c.height.should.eql(5);
    c.radius.should.eql(10);
  });
  it('defaults the radius to 1', () => {
    const c = cylinder({ height: 5 });
    c.height.should.eql(5);
    c.radius.should.eql(1);
  });
  it('defaults the height to 1', () => {
    const c = cylinder({ radius: 5 });
    c.height.should.eql(1);
    c.radius.should.eql(5);
  });
  it('accepts an empty object', () => {
    const c = cylinder({});
    c.height.should.eql(1);
    c.radius.should.eql(1);
  });
  it('computes volumes and surface areas correctly', () => {
    const c = cylinder({ radius: 2, height: 10 });
    c.volume().should.be.approximately(40 * Math.PI, 0.000001);
    c.surfaceArea().should.be.approximately(48 * Math.PI, 0.000001);
  });
  it('mutates with stretch and widen', () => {
    const c = cylinder({ radius: 2, height: 10 });
    c.widen(3);
    c.radius.should.eql(6);
    c.stretch(2);
    c.height.should.eql(20);
  });
  it('changes volumes after stretch and widen', () => {
    const c = cylinder({ radius: 2, height: 10 });
    c.widen(3);
    c.volume().should.be.approximately(360 * Math.PI, 0.000001);
    c.stretch(2);
    c.volume().should.be.approximately(720 * Math.PI, 0.000001);
  });
  it('has an immutable radius field', () => {
    const c = cylinder({ radius: 2, height: 10 });
    c.radius = 100;
    c.radius.should.eql(2);
  });
  it('has an immutable height field', () => {
    const c = cylinder({ radius: 2, height: 10 });
    c.height = 100;
    c.height.should.eql(10);
  });
});

describe('crypto functions', () => {
  it('encrypt and decrypt okay', () => {
    const [e, d] = makeCryptoFunctions('super dog', 'aes-256-cbc');
    e('Hello world').should.eql('9714236cbedfd8d9799acea4ea79e6fe');
    d('9714236cbedfd8d9799acea4ea79e6fe').should.eql('Hello world');
    ['', 'abc', 'zπøj#•¶å≈’’'].forEach(s => d(e(s)).should.eql(s));
  });
  it('throws an error for an unknown algorithm', () => {
    (() => makeCryptoFunctions('super dog', 'asdf*')[0]('Hello')).should.throw(Error);
  });
});

describe('The random name function', () => {
  it('returns a promise, anyway', () => {
    const p = randomName({ gender: 'female', region: 'canada' });
    ('then' in p).should.be.ok();
  });
  it('produces a resolved promise with a name and surname', (done) => {
    randomName({ gender: 'female', region: 'canada' }).then((name) => {
      // You might try: console.log(name); // eslint-disable-line no-console
      name.length.should.be.above(3);
      name.should.containEql(' ');
    }).then(done, done);
  });
  it('produces a rejected promise for an unknown gender', (done) => {
    randomName({ gender: 'fefwefemale', region: 'canada' }).catch((error) => {
      error.message.should.containEql('400');
    }).then(done, done);
  });
});
