const fs = require('fs');
const path = require('path');
const Simulator = require('./src/simulator');

const exercises = [
  { file: 'exercicios/ex01_print_number.asm', input: '5', expected: '5' },
  { file: 'exercicios/ex02_double_number.asm', input: '4', expected: '8' },
  { file: 'exercicios/ex03_max3.asm', input: '137', expected: '7' },
  { file: 'exercicios/ex04_max10.asm', input: '3948572610', expected: '9' },
  { file: 'exercicios/ex06_factorial.asm', input: '5', expected: '120' },
  { file: 'exercicios/ex07_reverse_name.asm', input: 'ABC\0', expected: 'CBA' }
];

let allPassed = true;
exercises.forEach(({file, input, expected}) => {
  const sim = new Simulator();
  const program = fs.readFileSync(path.join(__dirname, file), 'utf8');
  sim.reset();
  sim.parseProgram(program);
  sim.sendInput(input);
  sim.runAll();
  const out = sim.getOutput();
  const pass = out === expected;
  console.log(file + ': ' + (pass ? 'PASS' : 'FAIL') + ' | Expected:' + expected + ' Got:' + out);
  if (!pass) allPassed = false;
});

process.exit(allPassed ? 0 : 1);
