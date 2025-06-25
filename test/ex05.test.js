const { JSDOM } = require('jsdom');
const fs = require('fs');

(async () => {
  const html = fs.readFileSync('index.html', 'utf8');
  const dom = new JSDOM(html, {
    runScripts: 'dangerously',
    resources: 'usable',
    url: 'file://' + process.cwd() + '/index.html'
  });
  await new Promise(r => dom.window.addEventListener('load', r));

  const sim = dom.window.sim;
  const program = fs.readFileSync('exercicios/ex05_bubble_sort.asm', 'utf8');
  sim.parseProgram(program);
  sim.updateUI();

  const inputField = dom.window.document.getElementById('inputField');
  const inputBtn = dom.window.document.getElementById('inputBtn');

  const inputs = ['3','1','2',''];
  let inputIndex = 0;
  let steps = 0;
  while (steps < 1000) {
    sim.step();
    // debug PC
    // console.log('PC', sim.regs.pc, 'waiting', dom.window.waitingForInput);
    steps++;
    if (dom.window.waitingForInput) {
      inputField.value = inputs[inputIndex++] || '';
      inputBtn.onclick();
    }
    if (sim.rom[sim.regs.pc] === sim.OPCODES['NADA']) break;
  }

  const outputs = [...dom.window.document.querySelectorAll('#terminal .output')]
    .map(el => el.textContent.replace('Saída: ','')).join('');
  console.log('OUTPUT:', outputs);
})();
