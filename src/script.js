const OPCODES = {
  NADA: 0x00,
  CAR_IMD: 0x01,
  COPIA: 0x02,
  LE_MEM: 0x03,
  ES_MEM: 0x04,
  SOMA: 0x05,
  SUBTRAI: 0x06,
  MULTIPLICA: 0x07,
  DIVIDE: 0x08,
  E_BIT: 0x09,
  OU_BIT: 0x0a,
  NAO_BIT: 0x0b,
  SALTA: 0x0c,
  SALTA_Z: 0x0d,
  SALTA_NZ: 0x0e,
  ENTRADA: 0x0f,
  SAIDA: 0x10,
  INC: 0x11,
  DEC: 0x12,
  MAIOR: 0x13,
  ZERA: 0x14,
  LE_INDIRETO: 0x15,
  ES_INDIRETO: 0x16,
  SALTA_C: 0x1b,
};

let memory = new Uint8Array(256); // RAM
let rom = new Uint8Array(256); // ROM
let regs = { r0: 0, r1: 0, r2: 0, r3: 0, pc: 0, sp: 255 };
let flags = { Z: 0, C: 0 };
let currentInput = null;
let running = false;

let programLines = [];
let addrToLine = new Array(256).fill(null);

const regsMap = ["r0", "r1", "r2", "r3"];

function initMemoryView() {
  const tbl = document.getElementById("romTable");
  const tbl2 = document.getElementById("memoryTable");
  tbl.innerHTML = "";
  tbl2.innerHTML = "";
  for (let row = 0; row < 16; row++) {
    const tr = document.createElement("tr");
    const tr2 = document.createElement("tr");
    for (let col = 0; col < 16; col++) {
      const addr = row * 16 + col;
      const td = document.createElement("td");
      const td2 = document.createElement("td");
      td.id = "rom" + addr;
      td2.id = "mem" + addr;
      td.textContent = "00";
      td2.textContent = "00";
      tr.appendChild(td);
      tr2.appendChild(td2);
    }
    tbl.appendChild(tr);
    tbl2.appendChild(tr2);
  }
}

function updateUI() {
  ["r0", "r1", "r2", "r3", "pc", "sp"].forEach(
    (id) => (document.getElementById(id).textContent = regs[id]),
  );
  document.getElementById("flagZ").textContent = flags.Z;
  document.getElementById("flagC").textContent = flags.C;
  for (let i = 0; i < 256; i++) {
    document.getElementById("rom" + i).textContent = rom[i]
      .toString(16)
      .padStart(2, "0");
    document.getElementById("mem" + i).textContent = memory[i]
      .toString(16)
      .padStart(2, "0");
  }
}

function renderProgram() {
  const pv = document.getElementById("programView");
  pv.innerHTML = "";
  programLines.forEach((line, idx) => {
    const li = document.createElement("li");
    li.textContent = line;
    li.id = "progLine" + idx;
    pv.appendChild(li);
  });
}

function highlightCurrentLine(addr) {
  document
    .querySelectorAll("#programView .current")
    .forEach((el) => el.classList.remove("current"));
  const idx = addrToLine[addr];
  if (idx !== null && idx !== undefined) {
    const el = document.getElementById("progLine" + idx);
    if (el) {
      el.classList.add("current");
      el.scrollIntoView({ block: "center" });
    }
  }
}

function parseProgram(text) {
  rom.fill(0);
  programLines = [];
  addrToLine.fill(null);

  const lines = text.split(/\r?\n/);
  const labels = {};
  let addr = 0;

  // first pass: labels
  lines.forEach((line) => {
    const code = line.split(";")[0].trim();
    if (!code) return;
    const parts = code.replace(/,/g, " ").split(/\s+/);
    if (parts[0].endsWith(":")) {
      labels[parts[0].slice(0, -1)] = addr;
    } else {
      addr += 1 + (parts.length - 1);
    }
  });

  // second pass: assemble and store lines
  addr = 0;
  lines.forEach((line) => {
    const code = line.split(";")[0].trim();
    if (!code) return;
    const parts = code.replace(/,/g, " ").split(/\s+/);
    if (parts[0].endsWith(":")) return;
    const op = parts[0].toUpperCase();
    const opc = OPCODES[op];
    programLines.push(code);
    addrToLine[addr] = programLines.length - 1;
    rom[addr++] = opc;
    parts.slice(1).forEach((tok) => {
      let val;
      if (tok.match(/^R[0-3]$/i)) val = parseInt(tok[1]);
      else if (tok.match(/^[0-9]+$/)) val = parseInt(tok);
      else if (labels[tok] !== undefined) val = labels[tok];
      else val = 0;
      rom[addr++] = val;
    });
  });

  regs.pc = 0;
  flags.Z = 0;
  flags.C = 0;
  renderProgram();
}

const terminal = document.getElementById("terminal");
const inputField = document.getElementById("inputField");
const inputBtn = document.getElementById("inputBtn");
let waitingForInput = false;

function appendToTerminal(text, className) {
  const line = document.createElement("div");
  line.textContent = text;
  if (className) line.className = className;
  terminal.appendChild(line);
  terminal.scrollTop = terminal.scrollHeight;
}

function getInstructionText(op, params) {
  const opNames =
    Object.entries(OPCODES).find(([_, v]) => v === op)?.[0] || "UNKNOWN";
  return `${opNames} ${params.map((p) => (typeof p === "number" ? p : `R${p}`)).join(" ")}`;
}

function step() {
  if (waitingForInput) return;

  const op = rom[regs.pc];
  const originalPc = regs.pc;
  highlightCurrentLine(originalPc);

  // Execute instruction
  regs.pc++;
  switch (op) {
    case 0x00: // NADA
      running = false;
      break;
    case 0x01: // CAR_IMD
      d = rom[regs.pc++];
      regs[regsMap[d]] = rom[regs.pc++];
      appendToTerminal(
        `Carregando imediato: ${getInstructionText(op, [d, rom[regs.pc - 1]])}`,
        "instruction",
      );
      break;
    case 0x02: // COPIA
      d = rom[regs.pc++];
      o1 = rom[regs.pc++];
      regs[regsMap[d]] = regs[regsMap[o1]];
      appendToTerminal(
        `Copiando: ${getInstructionText(op, [d, o1])}`,
        "instruction",
      );
      break;
    case 0x03: // LE_MEM
      d = rom[regs.pc++];
      o1 = rom[regs.pc++];
      regs[regsMap[d]] = memory[o1]; // Read from RAM
      appendToTerminal(
        `Lendo da memória: ${getInstructionText(op, [d, o1])}`,
        "instruction",
      );
      break;
    case 0x04: // ES_MEM
      o1 = rom[regs.pc++];
      o2 = rom[regs.pc++];
      memory[o2] = regs[regsMap[o1]]; // Write to RAM
      appendToTerminal(
        `Escrevendo na memória: ${getInstructionText(op, [o1, o2])}`,
        "instruction",
      );
      break;
    case 0x05: // SOMA
      d = rom[regs.pc++]; // Fix: fetch from ROM
      o1 = rom[regs.pc++]; // Fix: fetch from ROM
      {
        const res = regs[regsMap[d]] + regs[regsMap[o1]];
        flags.C = res > 255 ? 1 : 0;
        regs[regsMap[d]] = res & 0xff;
        flags.Z = regs[regsMap[d]] === 0 ? 1 : 0;
        appendToTerminal(
          `Soma: ${getInstructionText(op, [d, o1])}`,
          "instruction",
        );
      }
      break;
    case 0x06: // SUBTRAI
      d = rom[regs.pc++]; // Fix: fetch from ROM
      o1 = rom[regs.pc++]; // Fix: fetch from ROM
      {
        const res = regs[regsMap[d]] - regs[regsMap[o1]];
        flags.C = res < 0 ? 1 : 0;
        regs[regsMap[d]] = res & 0xff;
        flags.Z = regs[regsMap[d]] === 0 ? 1 : 0;
        appendToTerminal(
          `Subtração: ${getInstructionText(op, [d, o1])}`,
          "instruction",
        );
      }
      break;
    case 0x07: // MULTIPLICA
      d = rom[regs.pc++]; // Fix: fetch from ROM
      o1 = rom[regs.pc++]; // Fix: fetch from ROM
      {
        const res = regs[regsMap[d]] * regs[regsMap[o1]];
        flags.C = res > 255 ? 1 : 0;
        regs[regsMap[d]] = res & 0xff;
        flags.Z = regs[regsMap[d]] === 0 ? 1 : 0;
        appendToTerminal(
          `Multiplicação: ${getInstructionText(op, [d, o1])}`,
          "instruction",
        );
      }
      break;
    case 0x08: // DIVIDE
      d = rom[regs.pc++]; // Fix: fetch from ROM
      o1 = rom[regs.pc++]; // Fix: fetch from ROM
      {
        const a = regs[regsMap[d]];
        const b = regs[regsMap[o1]] || 1;
        regs[regsMap[d]] = Math.floor(a / b);
        flags.Z = regs[regsMap[d]] === 0 ? 1 : 0;
        appendToTerminal(
          `Divisão: ${getInstructionText(op, [d, o1])}`,
          "instruction",
        );
      }
      break;
    case 0x09: // E_BIT
    case 0x0a: // OU_BIT
      d = rom[regs.pc++]; // Fix: fetch from ROM
      o1 = rom[regs.pc++]; // Fix: fetch from ROM
      {
        const a = regs[regsMap[d]];
        const b = regs[regsMap[o1]];
        rsp = op === 0x09 ? a & b : a | b;
        regs[regsMap[d]] = rsp;
        flags.Z = rsp === 0 ? 1 : 0;
        appendToTerminal(
          op === 0x09
            ? `E Bit: ${getInstructionText(op, [d, o1])}`
            : `OU Bit: ${getInstructionText(op, [d, o1])}`,
          "instruction",
        );
      }
      break;
    case 0x0b: // NAO_BIT
      d = rom[regs.pc++]; // Fix: fetch from ROM
      regs[regsMap[d]] = ~regs[regsMap[d]] & 0xff;
      flags.Z = regs[regsMap[d]] === 0 ? 1 : 0;
      appendToTerminal(
        `NÃO Bit: ${getInstructionText(op, [d])}`,
        "instruction",
      );
      break;
    case 0x0c: // SALTA
      o1 = rom[regs.pc++]; // Fix: fetch from ROM
      regs.pc = o1;
      appendToTerminal(`Salto: ${getInstructionText(op, [o1])}`, "instruction");
      break;
    case 0x0d: // SALTA_Z
      o1 = rom[regs.pc++]; // Fix: fetch from ROM
      if (flags.Z) regs.pc = o1;
      appendToTerminal(
        `Salto Condicional Z: ${getInstructionText(op, [o1])}`,
        "instruction",
      );
      break;
    case 0x0e: // SALTA_NZ
      o1 = rom[regs.pc++]; // Fix: fetch from ROM
      if (!flags.Z) regs.pc = o1;
      appendToTerminal(
        `Salto Condicional NZ: ${getInstructionText(op, [o1])}`,
        "instruction",
      );
      break;
    case 0x1b: // SALTA_C
      o1 = rom[regs.pc++];
      if (flags.C) regs.pc = o1;
      appendToTerminal(
        `Salto Condicional C: ${getInstructionText(op, [o1])}`,
        "instruction",
      );
      break;
    case 0x0f: // ENTRADA
      d = rom[regs.pc++]; // Fix: fetch from ROM
      if (currentInput === null) {
        waitingForInput = true;
        inputField.disabled = false;
        inputBtn.disabled = false;
        inputField.focus();
        regs.pc = originalPc;
        appendToTerminal("Aguardando entrada...", "input");
        return;
      }
      const input = currentInput;
      currentInput = null;
      regs[regsMap[d]] = input.charCodeAt(0);
      appendToTerminal(`Entrada: ${input}`, "input");
      break;
    case 0x10: // SAIDA
      o1 = rom[regs.pc++]; // Fix: fetch from ROM
      const char = String.fromCharCode(regs[regsMap[o1]]);
      appendToTerminal(`Saída: ${char}`, "output");
      break;
    case 0x11: // INC
      d = rom[regs.pc++]; // Fix: fetch from ROM
      regs[regsMap[d]] = (regs[regsMap[d]] + 1) & 0xff; // and com 255, se overflow, fica 0
      flags.Z = regs[regsMap[d]] === 0 ? 1 : 0;
      flags.C = regs[regsMap[d]] === 0 ? 1 : 0;
      appendToTerminal(
        `Incremento: ${getInstructionText(op, [d])}`,
        "instruction",
      );
      break;
    case 0x12: // DEC
      d = rom[regs.pc++]; // Fix: fetch from ROM
      regs[regsMap[d]] = (regs[regsMap[d]] - 1) & 0xff;
      flags.Z = regs[regsMap[d]] === 0 ? 1 : 0;
      flags.C = regs[regsMap[d]] === 255 ? 1 : 0;
      appendToTerminal(
        `Decremento: ${getInstructionText(op, [d])}`,
        "instruction",
      );
      break;
    case 0x13: // MAIOR
      d = rom[regs.pc++]; // Fix: fetch from ROM
      let r1 = regs[regsMap[rom[regs.pc++]]]; // Fix: fetch from ROM
      let r2 = regs[regsMap[rom[regs.pc++]]]; // Fix: fetch from ROM
      const m = r1 > r2 ? r1 : r2;
      regs[regsMap[d]] = m;
      flags.Z = m === 0 ? 1 : 0;
      appendToTerminal(
        `Maior: ${getInstructionText(op, [d, r1, r2])}`,
        "instruction",
      );
      break;
    case 0x14: // ZERA
      d = rom[regs.pc++]; // Fix: fetch from ROM
      regs[regsMap[d]] = 0;
      flags.Z = 1;
      appendToTerminal(
        `Zerando: ${getInstructionText(op, [d])}`,
        "instruction",
      );
      break;
    case 0x15: // LE_INDIRETO
      d = rom[regs.pc++];
      o1 = rom[regs.pc++];
      regs[regsMap[d]] = memory[regs[regsMap[o1]]]; // Read from RAM
      appendToTerminal(
        `Leitura indireta: ${getInstructionText(op, [d, o1])}`,
        "instruction",
      );
      break;
    case 0x16: // ES_INDIRETO
      o1 = rom[regs.pc++];
      o2 = rom[regs.pc++];
      memory[regs[regsMap[o2]]] = regs[regsMap[o1]]; // Write to RAM
      appendToTerminal(
        `Escrita indireta: ${getInstructionText(op, [o1, o2])}`,
        "instruction",
      );
      break;
    default:
      running = false;
  }

  updateUI();
}

function runAll() {
  running = true;

  function runStep() {
    if (running && !waitingForInput) {
      step();
      if (running) {
        setTimeout(runStep, 100); // Add delay between steps for visibility
      }
    }
  }

  runStep();
}

document.getElementById("loadBtn").onclick = () => {
  memory.fill(0);
  initMemoryView();
  terminal.innerHTML = "";
  parseProgram(document.getElementById("program").value);
  updateUI();
  ["stepBtn", "runBtn", "resetBtn"].forEach(
    (id) => (document.getElementById(id).disabled = false),
  );
};
document.getElementById("stepBtn").onclick = () => {
  step();
};
document.getElementById("runBtn").onclick = () => {
  runAll();
};
document.getElementById("resetBtn").onclick = () => {
  regs = { r0: 0, r1: 0, r2: 0, r3: 0, pc: 0, sp: 255 };
  flags = { Z: 0, C: 0 };
  memory.fill(0);
  terminal.innerHTML = "";
  initMemoryView();
  updateUI();
};
document.getElementById("inputBtn").onclick = () => {
  const raw = document.getElementById("inputField").value;
  currentInput = raw.length > 0 ? raw[0] : String.fromCharCode(0);
  document.getElementById("inputField").value = "";
  inputField.disabled = true;
  inputBtn.disabled = true;
  waitingForInput = false;
  if (running) {
    setTimeout(() => runAll(), 0);
  }
};

// initialize on load
initMemoryView();
updateUI();

window.sim = {
  OPCODES,
  memory,
  rom,
  regs,
  flags,
  parseProgram,
  step,
  runAll,
  initMemoryView,
  updateUI,
  renderProgram,
  highlightCurrentLine,
};
