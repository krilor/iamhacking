---

title: "Encoding and Ciphers in Bash"
date: 2020-07-26T22:14:00+02:00
draft: false

---

Today I want to explore encoding and ciphers in bash, and how to convert between different kinds. I've choosen bash because I like being able to just test stuff directly in my terminal.

To start off, I did a bit of google-foo and found a couple of resources to figure out what my scope would be.

I found these, which are ok posts/resources about the topic.

* https://medium.com/disruptive-labs/a-quick-primer-on-encoding-decoding-for-security-folks-a021afd98fbe
* https://www.dcode.fr/en

## Scope

### Encodings

From the resources listes, I have picked out these encodings that I will work with.

* utf-8
* base64
* base32
* hex
* URL encoding

### Ciphers

* Caesar and ROT(13) - substitution
* Atbash

### Other techniques

* Folding/unfolding

## Encoding

### My standard encoding is utf-8

I can check my terminals default encoding using env variables or the `locale` command.


```python
# jupyter bash is a bit finnicky, so I need to set the lang explicitly. In my regular terminal, it is allready set.
export LANG=en_US.UTF-8

echo $LANG
locale charmap
```

    en_US.UTF-8
    UTF-8


### Base64

Base64 represents binary data in a ASCII string format, with only 64 selected characters. Each character represents 6 bits of the binary data.

On Ubuntu (and most linux distros) we can use the `base64` tool to do encoding and decoding.



```python
base64 --help
```

    Usage: base64 [OPTION]... [FILE]
    Base64 encode or decode FILE, or standard input, to standard output.
    
    With no FILE, or when FILE is -, read standard input.
    
    Mandatory arguments to long options are mandatory for short options too.
      -d, --decode          decode data
      -i, --ignore-garbage  when decoding, ignore non-alphabet characters
      -w, --wrap=COLS       wrap encoded lines after COLS character (default 76).
                              Use 0 to disable line wrapping
    
          --help     display this help and exit
          --version  output version information and exit
    
    The data are encoded as described for the base64 alphabet in RFC 4648.
    When decoding, the input may contain newlines in addition to the bytes of
    the formal base64 alphabet.  Use --ignore-garbage to attempt to recover
    from any other non-alphabet bytes in the encoded stream.
    
    GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
    Report base64 translation bugs to <http://translationproject.org/team/>
    Full documentation at: <http://www.gnu.org/software/coreutils/base64>
    or available locally via: info '(coreutils) base64 invocation'



```python
echo "Testing base64"

raw="Hello"
echo "RAW: $raw"

encoded=$( echo $raw | base64 )
echo "ENCODED: $encoded"

decoded=$( echo $encoded | base64 -d )
echo "DECODED: $decoded"

```

    Testing base64
    RAW: Hello
    ENCODED: SGVsbG8K
    DECODED: Hello


### Base32

Base32 is the same as base64, but only has a 32 character alphabet. Each character represents 5 bits.

Ubuntu has a `base32` tool built in.


```python
base32 --help
```

    Usage: base32 [OPTION]... [FILE]
    Base32 encode or decode FILE, or standard input, to standard output.
    
    With no FILE, or when FILE is -, read standard input.
    
    Mandatory arguments to long options are mandatory for short options too.
      -d, --decode          decode data
      -i, --ignore-garbage  when decoding, ignore non-alphabet characters
      -w, --wrap=COLS       wrap encoded lines after COLS character (default 76).
                              Use 0 to disable line wrapping
    
          --help     display this help and exit
          --version  output version information and exit
    
    The data are encoded as described for the base32 alphabet in RFC 4648.
    When decoding, the input may contain newlines in addition to the bytes of
    the formal base32 alphabet.  Use --ignore-garbage to attempt to recover
    from any other non-alphabet bytes in the encoded stream.
    
    GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
    Report base32 translation bugs to <http://translationproject.org/team/>
    Full documentation at: <http://www.gnu.org/software/coreutils/base32>
    or available locally via: info '(coreutils) base32 invocation'



```python
echo "Testing base32"

raw="Hello"
echo "RAW: $raw"

encoded=$( echo $raw | base32 )
echo "ENCODED: $encoded"

decoded=$( echo $encoded | base32 -d )
echo "DECODED: $decoded"
```

    Testing base32
    RAW: Hello
    ENCODED: JBSWY3DPBI======
    DECODED: Hello


### HEX

Hex is similar to both base64 and 32, but uses only the 16 characters *0123456789abcdef*. Each character represents 4 bits, so that 2 characters make up a byte.

[hexdump](http://manpages.ubuntu.com/manpages/trusty/man1/hexdump.1.html) can be used to convert to hex, but as far as I know, not the other way around. hexdump is pretty nice if you want to specify the output format (spaces and such).

[xxd](http://manpages.ubuntu.com/manpages/trusty/man1/xxd.1.html) can be used to convert both ways.


```python
echo hexdump
echo hello | hexdump -v -e '/1 "%02x "'; echo

echo; echo xxd
# note, the extra sed is just o place spaces between the values
echo hello | xxd -p | sed 's/../& /g'

echo; echo "xxd decode/reverse"
echo hello | xxd -p | sed 's/../& /g' | xxd -p -r

```

    hexdump
    68 65 6c 6c 6f 0a 
    
    xxd
    68 65 6c 6c 6f 0a 
    
    xxd decode/reverse
    hello



```python
### Fold and unfold

Folding is used to create text files of an arbritraty line length.

Unfold is done with using translate (tr) to remove characters.


```


```python
fold --help
```

    Usage: fold [OPTION]... [FILE]...
    Wrap input lines in each FILE, writing to standard output.
    
    With no FILE, or when FILE is -, read standard input.
    
    Mandatory arguments to long options are mandatory for short options too.
      -b, --bytes         count bytes rather than columns
      -s, --spaces        break at spaces
      -w, --width=WIDTH   use WIDTH columns instead of 80
          --help     display this help and exit
          --version  output version information and exit
    
    GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
    Report fold translation bugs to <http://translationproject.org/team/>
    Full documentation at: <http://www.gnu.org/software/coreutils/fold>
    or available locally via: info '(coreutils) fold invocation'



```python
echo -folded
echo "somelongtext" | fold -w 4

echo; echo -unfolded
echo "somelongtext" | fold -w 4 | tr -d '\n'
```

    -folded
    some
    long
    text
    
    -unfolded
    somelongtext

### URL encoding

Ubuntu has a nice tool for doing url encoding - [urlencode](http://manpages.ubuntu.com/manpages/bionic/man1/urlencode.1.html).

It does not read from stdin, so we need to use xargs to do piping.


```python
urlencode

echo; echo "encoded"
echo "hello world" | xargs urlencode

echo; echo "decoded"
echo "hello world" | xargs urlencode | xargs urlencode -d
```

    urlencode [-m|-d] string-to-encode-or-decode
    
    encoded
    hello%20world
    
    decoded
    hello world



```python
## Ciphers

I will have a look at a few common (CTF-wise) ciphers.

### Caesar

[Caesar Ciper](https://en.wikipedia.org/wiki/Caesar_cipher) aka [ROT](https://en.wikipedia.org/wiki/ROT13).

To do rotation ciphers, use any of these resources.

* https://www.chmag.in/articles/momsguide/decoding-rot-using-the-echo-and-tr-commands-in-your-linux-terminal/
* https://askubuntu.com/questions/1097761/changing-individual-letter-position-with-bash
* https://www.reddit.com/r/commandline/comments/1orqht/bash_script_that_performs_a_modified_caesar_cipher/

This little tidbit does ROT13 with can be decoded with the same method.
I've opted for the tr approach here.

```


```python
echo "hell0"
echo "hellO" | tr ‘n-za-mN-ZA-M’ ‘a-zA-Z’
echo "hellO" | tr ‘n-za-mN-ZA-M’ ‘a-zA-Z’ | tr ‘n-za-mN-ZA-M’ ‘a-zA-Z’
```

    hell0
    uryyB
    hellO



```python
### Atbash

[Atbash](https://en.wikipedia.org/wiki/Atbash) simply reverses the alphabeth and uses that as a cipher.
This can be done in bash quite nicely with tr.

```


```python
# setting up some variables
a=$( echo {a..z} | tr -d ' ' )
echo "a $a"
A=${a^^}
echo "A $A"
r=$( echo $a | rev )
echo "r $r"
R=${r^^}
echo "R $R"

echo hElLo | tr $a $r | tr $A $R
echo sVoOl | tr $a $r | tr $A $R
```

    a abcdefghijklmnopqrstuvwxyz
    A ABCDEFGHIJKLMNOPQRSTUVWXYZ
    r zyxwvutsrqponmlkjihgfedcba
    R ZYXWVUTSRQPONMLKJIHGFEDCBA
    sVoOl
    hElLo



```python
### Vigenére cipher

[Vigenére cipher](https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher)
```

## Closing remarks

Understanding and working with encodings and (simple) ciphers in bash: check.

Even tho this was just prodding at the surface, I feel that I've learned a bit about encoding/ciphers and also about some tools that that can be used to work with such matters directly in my terminal.
