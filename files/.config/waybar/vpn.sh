#!/bin/bash

nordvpn status | sed -n 's/^Status: //p'
