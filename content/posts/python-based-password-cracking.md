---

title: "Using python to crack a (known) password hash"
date: 2020-07-20T10:56:24+02:00
tags: ["python", "cracking", "passwords"]
draft: false

---

It probably makes sense to crack passwords using tools such as hashcat, john the ripper or findmyhash, but today I'm gonna have a stab at brute-forcing a hash using python.

To start out, I made a md5 hash on the command line

```bash

echo -n "1234" | md5sum

```

The password is *1234* The resulting hash is: *81dc9bdb52d04dc20036dbd8313ed055*.

**NOTE: md5 is not a hasing algorithm that should be used to hash passwords - use bcrypt or Argon2 or at the very least a shaN with salt and a lot of iteration. I've selected it today because it is fast and easy to work with when exploring this idea.**

## Cracking the hash



```python
import hashlib

hash = "81dc9bdb52d04dc20036dbd8313ed055"

for i in range(9999):
    if i % 100 == 0:
        print("At %d" % i)
    
    generated = hashlib.md5(b'%d' % i).hexdigest()
    
    if generated == hash:
        print( "Found it - password is '%d'" % i)
        break
    
```

    At 0
    At 100
    At 200
    At 300
    At 400
    At 500
    At 600
    At 700
    At 800
    At 900
    At 1000
    At 1100
    At 1200
    Found it - password is '1234'


The above example shows a simple way to bruteforce the hash. It is as simple as it can be, just iterating over a integers from 0 and upwards.

Ofcourse, if this was a "proper" hash where we did not know the hashed value, then we would have to include all kinds of other characters.

## Next up

Next up, I will look into hashcat, john the ripper, findmyhash etc.
