#!/bin/bash

if [ ! -d "node_modules" ] && [ -f "package.json" ] ; then npm install  ; fi
if [ ! -f ".env" ] && [ -f ".env.example" ]  ; then cp .env.example .env ; fi

exec "$@"
