#!/bin/bash

gleam build

bun js
bun css

if ! [ -d '../backend/priv/static' ]; then
  mkdir -p ../backend/priv/static 
fi

mv script.js ../backend/priv/static
mv out.css ../backend/priv/static/style.css
