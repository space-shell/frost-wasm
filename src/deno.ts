import { greet } from '../pkg/wasm_frost.js';

const greeting = greet('Grafbase');

console.log({ greeting });
