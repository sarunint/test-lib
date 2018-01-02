import sourcemaps from 'rollup-plugin-sourcemaps';

const globals = {
  '@angular/core': 'ng.core'
};

const mappings = {
  'esm5': {
    input: './build/esm5/test_lib.js',
    outputFile: './dist/esm5/test_lib.js',
    outputFormat: 'es'
  },
  'esm2015': {
    input: './build/esm2015/test_lib.js',
    outputFile: './dist/esm2015/test_lib.js',
    outputFormat: 'es'
  },
  'umd': {
    input: './build/esm5/test_lib.js',
    outputFile: './dist/bundles/test_lib.umd.js',
    outputFormat: 'umd'
  }
}

const usedMapping = mappings[process.env['FORMAT']];

export default {
  input: usedMapping.input,
  output: {
    file: usedMapping.outputFile,
    format: usedMapping.outputFormat,
    name: 'sarunint.testLib',
    exports: 'named',
    globals,
    sourcemap: true
  },
  external: Object.keys(globals),
  amd: {
    id: '@sarunint/test-lib'
  },
  plugins: [sourcemaps()]
};
