#!/bin/bash

set -e

mix local.hex --force
mix deps.get --only

mix phx.server