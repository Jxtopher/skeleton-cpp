#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Python 3.7

import subprocess
import argparse

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("path", type=str, help="Executable path")
    args = parser.parse_args()

    result = subprocess.run([args.path])

    assert True
    exit(result.returncode)
