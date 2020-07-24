---

title: "Taking John The Ripper for a spin"
date: 2020-07-24T21:40:00+02:00
tags: ["johntheripper", "password", "cracking"]
draft: false

---

It is time time to give [John The Ripper](https://www.openwall.com/john/) as spin (further referred to as simpy "John"). It is a open-source password cracker similar to hashcat from the previous post.

First, we need to install it. There are three versions to choose from.

* *PRO* - distributed primarily in the form of "native" packages for the target operating systems and in general is meant to be easier to install. Not free.
* *Jumbo* - community-enhanced version of core. Free
* *Core* - core John. Free

I will be installing the "Jumbo" version. The source repo is [magnumripper/JohnTheRipper](https://github.com/magnumripper/JohnTheRipper). It can easily be done through the [snap package](https://github.com/magnumripper/JohnTheRipper/issues/2118). I have set up "john" as an alias for "john-the-ripper".



```python
john
```

    John the Ripper 1.9.0-jumbo-1 OMP [linux-gnu 64-bit x86_64 AVX2 AC]
    Copyright (c) 1996-2019 by Solar Designer and others
    Homepage: http://www.openwall.com/john/
    
    Usage: john [OPTIONS] [PASSWORD-FILES]
    --single[=SECTION[,..]]    "single crack" mode, using default or named rules
    --single=:rule[,..]        same, using "immediate" rule(s)
    --wordlist[=FILE] --stdin  wordlist mode, read words from FILE or stdin
                      --pipe   like --stdin, but bulk reads, and allows rules
    --loopback[=FILE]          like --wordlist, but extract words from a .pot file
    --dupe-suppression         suppress all dupes in wordlist (and force preload)
    --prince[=FILE]            PRINCE mode, read words from FILE
    --encoding=NAME            input encoding (eg. UTF-8, ISO-8859-1). See also
                               doc/ENCODINGS and --list=hidden-options.
    --rules[=SECTION[,..]]     enable word mangling rules (for wordlist or PRINCE
                               modes), using default or named rules
    --rules=:rule[;..]]        same, using "immediate" rule(s)
    --rules-stack=SECTION[,..] stacked rules, applied after regular rules or to
                               modes that otherwise don't support rules
    --rules-stack=:rule[;..]   same, using "immediate" rule(s)
    --incremental[=MODE]       "incremental" mode [using section MODE]
    --mask[=MASK]              mask mode using MASK (or default from john.conf)
    --markov[=OPTIONS]         "Markov" mode (see doc/MARKOV)
    --external=MODE            external mode or word filter
    --regex=REGEXPR            regular expression mode (see doc/README.librexgen)
    --subsets[=CHARSET]        "subsets" mode (see doc/SUBSETS)
    --stdout[=LENGTH]          just output candidate passwords [cut at LENGTH]
    --restore[=NAME]           restore an interrupted session [called NAME]
    --session=NAME             give a new session the NAME
    --status[=NAME]            print status of a session [called NAME]
    --make-charset=FILE        make a charset file. It will be overwritten
    --show[=left]              show cracked passwords [if =left, then uncracked]
    --test[=TIME]              run tests and benchmarks for TIME seconds each
    --users=[-]LOGIN|UID[,..]  [do not] load this (these) user(s) only
    --groups=[-]GID[,..]       load users [not] of this (these) group(s) only
    --shells=[-]SHELL[,..]     load users with[out] this (these) shell(s) only
    --salts=[-]COUNT[:MAX]     load salts with[out] COUNT [to MAX] hashes
    --costs=[-]C[:M][,...]     load salts with[out] cost value Cn [to Mn]. For
                               tunable cost parameters, see doc/OPTIONS
    --save-memory=LEVEL        enable memory saving, at LEVEL 1..3
    --node=MIN[-MAX]/TOTAL     this node's number range out of TOTAL count
    --fork=N                   fork N processes
    --pot=NAME                 pot file to use
    --list=WHAT                list capabilities, see --list=help or doc/OPTIONS
    --format=NAME              force hash of type NAME. The supported formats can
                               be seen with --list=formats and --list=subformats
    


## Testing

As allways, I will be testing with the MD5 hash from previous posts.



```python
# move to hom edir
cd ~
# create dir and move into it
mkdir -p john_test
cd john_test
# create and display file with hash
echo -n "1234" | md5sum | awk '{ print $1 }'> 1234.hash
cat 1234.hash
```

    81dc9bdb52d04dc20036dbd8313ed055



```python
cd ~
john --format=raw-md5 john_test/1234.hash
```

    Using default input encoding: UTF-8
    Loaded 1 password hash (Raw-MD5 [MD5 256/256 AVX2 8x3])
    Warning: no OpenMP support for this hash type, consider --fork=8
    Proceeding with single, rules:Single
    Press 'q' or Ctrl-C to abort, almost any other key for status
    Almost done: Processing the remaining buffered candidate passwords, if any.
    Proceeding with wordlist:/snap/john-the-ripper/current/run/password.lst, rules:Wordlist
    1234             (?[0m)
    1g 0:00:00:00 DONE 2/3 (2020-07-24 21:31) 100.0g/s 38400p/s 38400c/s 38400C/s 123456..larry
    Use the "--show --format=Raw-MD5" options to display all of the cracked passwords reliably
    Session completed


The result is the same. John cracket it using its pre-made wordlist.
I could also create a new wordlist for it to use and pipe it into stdin.


```python
seq -f "%04g" 0 9999 | john --stdin --pot=john_test/john.pot --format=raw-md5 john_test/1234.hash
```

    Using default input encoding: UTF-8
    Loaded 1 password hash (Raw-MD5 [MD5 256/256 AVX2 8x3])
    Warning: no OpenMP support for this hash type
    Press Ctrl-C to abort, or send SIGUSR1 to john process for status
    1234             (?[0m)
    1g 0:00:00:00  100.0g/s 153600p/s 153600c/s 153600C/s 1152..1535
    Use the "--show --format=Raw-MD5" options to display all of the cracked passwords reliably
    Session completed


## I like it

John worked great, but as with hashcat, there are a lot of options that I need to look into. Will definately use John again.
