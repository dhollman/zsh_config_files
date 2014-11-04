#!/usr/bin/env python
from __future__ import print_function, division

import sys
import re

# Get the filename
filename = sys.argv[1]
# Get the possible names for the property.  They will be joined by "|" in the regex
propnames = sys.argv[2:]

with open(filename) as f:
    # For now, just return the first matching line no matter what
    m = re.search("(?:" + "|".join(propnames) + r')\s*=\s*(.+?)\s*$', f.read())
    if m:
        print(m.group(1), end='')
    else:
        sys.exit(1)

