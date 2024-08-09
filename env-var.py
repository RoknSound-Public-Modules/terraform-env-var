#!/usr/bin/env python
import json
import os
from sys import stdin

def main(env_var, nonce):
    ret_val = os.environ.get(env_var, nonce)
    if ret_val == nonce:
        varset = "unset"
    elif not len(ret_val):
        varset = "unset"
    else:
        varset = "set"
    return json.dumps(
        dict(
            value=ret_val,
            varset=varset
        )
    )
        
    
args = json.loads(stdin.read())
print(
    main(args.get('var'), args.get('nonce'))
)