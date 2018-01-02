NGC=./node_modules/.bin/ngc
ROLLUP=./node_modules/.bin/rollup
UGLIFY=./node_modules/.bin/uglifyjs

# -----------------------
# Clean build environment
# -----------------------

rm -rf ./build
rm -rf ./dist

# ----------------------
# Build ESM5 and ESM2015
# ----------------------

$NGC -p ./tsconfig.esm5.json
$NGC -p ./tsconfig.esm2015.json

# -----------------------------
# Build FESM5, FESM2015 and UMD
# -----------------------------

FORMAT=esm5 $ROLLUP --config ./rollup.config.js
FORMAT=esm2015 $ROLLUP --config ./rollup.config.js
FORMAT=umd $ROLLUP --config ./rollup.config.js

# ----------------
# Copy other files
# ----------------

rsync -a --exclude=*.js ./build/esm5/ dist
cp ./package/package.template.json ./dist/package.json

# --------------------
# Compress UMD bundles
# --------------------

$UGLIFY ./dist/bundles/test_lib.umd.js --output ./dist/bundles/test_lib.umd.min.js --comments --source-map "filename='test_lib.umd.min.js.map',content='./dist/bundles/test_lib.umd.js.map'"
