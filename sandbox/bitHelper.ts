function findHex(str: string): number {
  let int = 0;
  while (true) {
    if (int.toString(16) === str) {
      return int;
    }
    int++;
  }
}

function findBinary(str: string): number {
  let int = 0;
  while (true) {
    if (int.toString(2) === str) {
      return int;
    }
    int++;
  }
}

const num = findHex("cc");
console.log(204 << 56);

console.log(num.toString(2));
console.log(num.toString(16));
