---

title: "Using findmyhash to crack a password"
date: 2020-07-20T21:06:00+02:00
tags: ["findmyhash", "password", "cracking"]
draft: false

---

This time around I will test [findmyhash](https://tools.kali.org/password-attacks/findmyhash) to crack a known password hash. Findmyhash is as tool that uses online services to search for the value of a hash. The online services has pre-computed hash values that are searched through, so-called "raindow tables"

*Note: I've installed findmyhash.py as findmyhash and added a hashbang so I can call it directly.*


```bash
findmyhash
```

    /usr/bin/findmyhash 1.1.2 ( http://code.google.com/p/findmyhash/ )
    
    Usage: 
    ------
    
      python /usr/bin/findmyhash <algorithm> OPTIONS
    
    
    Accepted algorithms are:
    ------------------------
    
      MD4       - RFC 1320
      MD5       - RFC 1321
      SHA1      - RFC 3174 (FIPS 180-3)
      SHA224    - RFC 3874 (FIPS 180-3)
      SHA256    - FIPS 180-3
      SHA384    - FIPS 180-3
      SHA512    - FIPS 180-3
      RMD160    - RFC 2857
      GOST      - RFC 5831
      WHIRLPOOL - ISO/IEC 10118-3:2004
      LM        - Microsoft Windows hash
      NTLM      - Microsoft Windows hash
      MYSQL     - MySQL 3, 4, 5 hash
      CISCO7    - Cisco IOS type 7 encrypted passwords
      JUNIPER   - Juniper Networks $9$ encrypted passwords
      LDAP_MD5  - MD5 Base64 encoded
      LDAP_SHA1 - SHA1 Base64 encoded
     
      NOTE: for LM / NTLM it is recommended to introduce both values with this format:
             python /usr/bin/findmyhash LM   -h 9a5760252b7455deaad3b435b51404ee:0d7f1f2bdeac6e574d6e18ca85fb58a7
             python /usr/bin/findmyhash NTLM -h 9a5760252b7455deaad3b435b51404ee:0d7f1f2bdeac6e574d6e18ca85fb58a7
    
    
    Valid OPTIONS are:
    ------------------
    
      -h <hash_value>  If you only want to crack one hash, specify its value with this option.
    
      -f <file>        If you have several hashes, you can specify a file with one hash per line.
                       NOTE: All of them have to be the same type.
                       
      -g               If your hash cannot be cracked, search it in Google and show all the results.
                       NOTE: This option ONLY works with -h (one hash input) option.
    
    
    Examples:
    ---------
    
      -> Try to crack only one hash.
         python /usr/bin/findmyhash MD5 -h 098f6bcd4621d373cade4e832627b4f6
         
      -> Try to crack a JUNIPER encrypted password escaping special characters.
         python /usr/bin/findmyhash JUNIPER -h "\$9\$LbHX-wg4Z"
      
      -> If the hash cannot be cracked, it will be searched in Google.
         python /usr/bin/findmyhash LDAP_SHA1 -h "{SHA}cRDtpNCeBiql5KOQsKVyrA0sAiA=" -g
       
      -> Try to crack multiple hashes using a file (one hash per line).
         python /usr/bin/findmyhash MYSQL -f mysqlhashesfile.txt
         
         
    Contact:
    --------
    
    [Web]           http://laxmarcaellugar.blogspot.com/
    [Mail/Google+]  bloglaxmarcaellugar@gmail.com
    [twitter]       @laXmarcaellugar
    




## Let's try it out


```bash
findmyhash MD5 -h 81dc9bdb52d04dc20036dbd8313ed055
```

    
    Cracking hash: 81dc9bdb52d04dc20036dbd8313ed055
    
    Analyzing with schwett (http://schwett.com)...
    ... hash not found in schwett
    
    Analyzing with netmd5crack (http://www.netmd5crack.com)...
    ... hash not found in netmd5crack
    
    Analyzing with md5-cracker (http://www.md5-cracker.tk)...
    ... hash not found in md5-cracker
    
    Analyzing with benramsey (http://tools.benramsey.com)...
    ... hash not found in benramsey
    
    Analyzing with gromweb (http://md5.gromweb.com)...
    ... hash not found in gromweb
    
    Analyzing with hashcracking (http://md5.hashcracking.com)...
    ... hash not found in hashcracking
    
    Analyzing with hashcracking (http://victorov.su)...
    ... hash not found in hashcracking
    
    Analyzing with thekaine (http://md5.thekaine.de)...
    ... hash not found in thekaine
    
    Analyzing with tmto (http://www.tmto.org)...
    ... hash not found in tmto
    
    Analyzing with rednoize (http://md5.rednoize.com)...
    ... hash not found in rednoize
    
    Analyzing with md5-db (http://md5-db.de)...
    ... hash not found in md5-db
    
    Analyzing with my-addr (http://md5.my-addr.com)...
    ... hash not found in my-addr
    
    Analyzing with md5pass (http://md5pass.info)...
    ... hash not found in md5pass
    
    Analyzing with md5decryption (http://md5decryption.com)...
    ... hash not found in md5decryption
    
    Analyzing with md5crack (http://md5crack.com)...
    ... hash not found in md5crack
    
    Analyzing with md5online (http://md5online.net)...
    ... hash not found in md5online
    
    Analyzing with md5-decrypter (http://md5-decrypter.com)...
    ... hash not found in md5-decrypter
    
    Analyzing with authsecu (http://www.authsecu.com)...
    ... hash not found in authsecu
    
    Analyzing with hashcrack (http://hashcrack.com)...
    ... hash not found in hashcrack
    
    Analyzing with c0llision (http://www.c0llision.net)...
    ... hash not found in c0llision
    
    Analyzing with cmd5 (http://www.cmd5.org)...
    ... hash not found in cmd5
    
    Analyzing with bigtrapeze (http://www.bigtrapeze.com)...
    ... hash not found in bigtrapeze
    
    Analyzing with hashchecker (http://www.hashchecker.com)...
    ... hash not found in hashchecker
    
    Analyzing with md5hashcracker (http://md5hashcracker.appspot.com)...
    ... hash not found in md5hashcracker
    
    Analyzing with passcracking (http://passcracking.com)...
    ... hash not found in passcracking
    
    Analyzing with askcheck (http://askcheck.com)...
    ... hash not found in askcheck
    
    Analyzing with fox21 (http://cracker.fox21.at)...
    ... hash not found in fox21
    
    Analyzing with nicenamecrew (http://crackfoo.nicenamecrew.com)...
    ... hash not found in nicenamecrew
    
    Analyzing with joomlaaa (http://joomlaaa.com)...
    
    Something was wrong. Please, contact with us to report the bug:
    
    bloglaxmarcaellugar@gmail.com
    


The tool is not able to find the hashed value.

For the kicks of it, lets try one of the suggested hashes.


```bash
findmyhash JUNIPER -h "\$9\$LbHX-wg4Z"
```

    
    Cracking hash: $9$LbHX-wg4Z
    
    Analyzing with password-decrypt (http://password-decrypt.com)...
    
    ***** HASH CRACKED!! *****
    The original string is: lc
    
    
    The following hashes were cracked:
    ----------------------------------
    
    $9$LbHX-wg4Z -> lc
    


It seems to be working... strage.

## Broken tool

A quick google search for the hashed value reveals that it should exist in a couple of the databases. It seems that the tool is broken, either on my system or in general. Being a tool that has not been touched since 2011, I think this one one to keep buried deep in the toolbox. Rather just use good'ol Google :)
