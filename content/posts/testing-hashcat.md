---

title: "Testing hashcat"
date: 2020-07-22T22:30:00+02:00
tags: ["hashcat", "cracking"]
draft: false

---

So, this time around I will give hashcat a spin.

Had a bit of trouble getting started. The install was easy enough, just download, unarchive and put a symlink in path, but installing required OpenCL took me a while. Or, actually, just figuring out what the heck I had to install was the hard part.

I'm on a ThinkPad X1 with integrated Intel grahics, so I had to install [OpenCL Runtimes for Intel Processors](https://software.intel.com/content/www/us/en/develop/articles/opencl-drivers.html). I first installed the CPU runtime, then the graphics one. Used [this askubuntu answer](https://askubuntu.com/a/1134762) as guidance.

## Device trouble

After installing the runtimes, the I get an error message about unstable driver. Must investigate that if I am to use hashcat more. This forces me to use `-D 1` flag (CPU devices).



```python
hashcat -I
```

    hashcat (v6.0.0) starting...
    
    [31m* Device #1: Unstable OpenCL driver detected![0m
    
    OpenCL Info:
    ============
    
    OpenCL Platform ID #1
      Vendor..: Intel(R) Corporation
      Name....: Intel(R) OpenCL HD Graphics
      Version.: OpenCL 2.1 
    
      Backend Device ID #1
        Type...........: GPU
        Vendor.ID......: 8
        Vendor.........: Intel(R) Corporation
        Name...........: Intel(R) Gen9 HD Graphics NEO
        Version........: OpenCL 2.1 NEO 
        Processor(s)...: 24
        Clock..........: 1100
        Memory.Total...: 12608 MB (limited to 4095 MB allocatable in one block)
        Memory.Free....: 12544 MB
        OpenCL.Version.: OpenCL C 2.0 
        Driver.Version.: 20.28.17293
    
    OpenCL Platform ID #2
      Vendor..: Intel(R) Corporation
      Name....: Intel(R) CPU Runtime for OpenCL(TM) Applications
      Version.: OpenCL 2.1 LINUX
    
      Backend Device ID #2
        Type...........: CPU
        Vendor.ID......: 8
        Vendor.........: Intel(R) Corporation
        Name...........: Intel(R) Core(TM) i5-8350U CPU @ 1.70GHz
        Version........: OpenCL 2.1 (Build 0)
        Processor(s)...: 8
        Clock..........: 1700
        Memory.Total...: 15760 MB (limited to 3940 MB allocatable in one block)
        Memory.Free....: 15696 MB
        OpenCL.Version.: OpenCL C 2.0 
        Driver.Version.: 18.1.0.0920
    


## Testing

Still testing on the same hash as previous posts. It does the trick.

* -a 3 = brute force
* -m 0 = MD5
* -D 1 = CPU
* ?d?d?d?d = brute force mask (4 digits)


```python
hashcat -a 3 -m 0 -D 1 81dc9bdb52d04dc20036dbd8313ed055 ?d?d?d?d
```

    hashcat (v6.0.0) starting...
    
    [31m* Device #1: Unstable OpenCL driver detected![0m
    
    [33mThis OpenCL driver has been marked as likely to fail kernel compilation or to produce false negatives.[0m
    [33mYou can use --force to override this, but do not report related errors.[0m
    [33m[0m
    OpenCL API (OpenCL 2.1 ) - Platform #1 [Intel(R) Corporation]
    =============================================================
    * Device #1: Intel(R) Gen9 HD Graphics NEO, skipped
    
    OpenCL API (OpenCL 2.1 LINUX) - Platform #2 [Intel(R) Corporation]
    ==================================================================
    * Device #2: Intel(R) Core(TM) i5-8350U CPU @ 1.70GHz, 15696/15760 MB (3940 MB allocatable), 8MCU
    
    Minimum password length supported by kernel: 0
    Maximum password length supported by kernel: 256
    
    Hashes: 1 digests; 1 unique digests, 1 unique salts
    Bitmaps: 16 bits, 65536 entries, 0x0000ffff mask, 262144 bytes, 5/13 rotates
    
    Applicable optimizers:
    * Zero-Byte
    * Early-Skip
    * Not-Salted
    * Not-Iterated
    * Single-Hash
    * Single-Salt
    * Brute-Force
    * Raw-Hash
    
    [33mATTENTION! Pure (unoptimized) backend kernels selected.[0m
    [33mUsing pure kernels enables cracking longer passwords but for the price of drastically reduced performance.[0m
    [33mIf you want to switch to optimized backend kernels, append -O to your commandline.[0m
    [33mSee the above message to find out about the exact limits.[0m
    [33m[0m
    Watchdog: Hardware monitoring interface not found on your system.
    Watchdog: Temperature abort trigger disabled.
    
    Host memory required for this attack: 66 MB
    
    [33mThe wordlist or mask that you are using is too small.[0m
    [33mThis means that hashcat cannot use the full parallel power of your device(s).[0m
    [33mUnless you supply more work, your cracking speed will drop.[0m
    [33mFor tips on supplying more work, see: https://hashcat.net/faq/morework[0m
    [33m[0m
    [33mApproaching final keyspace - workload adjusted.[0m
    [33m[0m
    81dc9bdb52d04dc20036dbd8313ed055:1234
                                                     
    Session..........: hashcat
    Status...........: Cracked
    Hash.Name........: MD5
    Hash.Target......: 81dc9bdb52d04dc20036dbd8313ed055
    Time.Started.....: Wed Jul 22 22:00:27 2020 (0 secs)
    Time.Estimated...: Wed Jul 22 22:00:27 2020 (0 secs)
    Guess.Mask.......: ?d?d?d?d [4]
    Guess.Queue......: 1/1 (100.00%)
    Speed.#2.........:  9489.4 kH/s (0.14ms) @ Accel:1024 Loops:10 Thr:1 Vec:8
    Recovered........: 1/1 (100.00%) Digests
    Progress.........: 10000/10000 (100.00%)
    Rejected.........: 0/10000 (0.00%)
    Restore.Point....: 0/1000 (0.00%)
    Restore.Sub.#2...: Salt:0 Amplifier:0-10 Iteration:0-10
    Candidates.#2....: 1234 -> 6764
    
    Started: Wed Jul 22 22:00:24 2020
    Stopped: Wed Jul 22 22:00:28 2020


## Benchmarks

Trying a benchmark to see the speed. Should probably have a better rig :/


```python
hashcat -b -D 1 -O
```

    hashcat (v6.0.0) starting in benchmark mode...
    
    [33mBenchmarking uses hand-optimized kernel code by default.[0m
    [33mYou can use it in your cracking session by setting the -O option.[0m
    [33mNote: Using optimized kernel code limits the maximum supported password length.[0m
    [33mTo disable the optimized kernel code in benchmark mode, use the -w option.[0m
    [33m[0m
    [31m* Device #1: Unstable OpenCL driver detected![0m
    
    [33mThis OpenCL driver has been marked as likely to fail kernel compilation or to produce false negatives.[0m
    [33mYou can use --force to override this, but do not report related errors.[0m
    [33m[0m
    OpenCL API (OpenCL 2.1 ) - Platform #1 [Intel(R) Corporation]
    =============================================================
    * Device #1: Intel(R) Gen9 HD Graphics NEO, skipped
    
    OpenCL API (OpenCL 2.1 LINUX) - Platform #2 [Intel(R) Corporation]
    ==================================================================
    * Device #2: Intel(R) Core(TM) i5-8350U CPU @ 1.70GHz, 15696/15760 MB (3940 MB allocatable), 8MCU
    
    Benchmark relevant options:
    ===========================
    * --opencl-device-types=1
    * --optimized-kernel-enable
    
    Hashmode: 0 - MD5
    
    Speed.#2.........:   540.3 MH/s (7.81ms) @ Accel:1024 Loops:512 Thr:1 Vec:8
    
    Hashmode: 100 - SHA1
    
    Speed.#2.........:   252.3 MH/s (33.00ms) @ Accel:1024 Loops:1024 Thr:1 Vec:8
    
    Hashmode: 1400 - SHA2-256
    
    Speed.#2.........: 99913.0 kH/s (83.70ms) @ Accel:1024 Loops:1024 Thr:1 Vec:8
    
    Hashmode: 1700 - SHA2-512
    
    Speed.#2.........: 26767.6 kH/s (78.10ms) @ Accel:1024 Loops:256 Thr:1 Vec:4
    
    Hashmode: 22000 - WPA-PBKDF2-PMKID+EAPOL (Iterations: 4095)
    
    Speed.#2.........:    11607 H/s (87.84ms) @ Accel:1024 Loops:512 Thr:1 Vec:8
    
    Hashmode: 1000 - NTLM
    
    Speed.#2.........:   890.4 MH/s (9.21ms) @ Accel:1024 Loops:1024 Thr:1 Vec:8
    
    Hashmode: 3000 - LM
    
    Speed.#2.........: 96088.8 kH/s (86.71ms) @ Accel:1024 Loops:1024 Thr:1 Vec:8
    
    Hashmode: 5500 - NetNTLMv1 / NetNTLMv1+ESS
    
    Speed.#2.........:   581.5 MH/s (14.19ms) @ Accel:1024 Loops:1024 Thr:1 Vec:8
    
    Hashmode: 5600 - NetNTLMv2
    
    Speed.#2.........: 32761.5 kH/s (127.67ms) @ Accel:512 Loops:1024 Thr:1 Vec:8
    
    Hashmode: 1500 - descrypt, DES (Unix), Traditional DES
    
    Speed.#2.........:  3715.6 kH/s (69.83ms) @ Accel:32 Loops:1024 Thr:1 Vec:8
    
    Hashmode: 500 - md5crypt, MD5 (Unix), Cisco-IOS $1$ (MD5) (Iterations: 1000)
    
    Speed.#2.........:    46139 H/s (85.74ms) @ Accel:512 Loops:1000 Thr:1 Vec:8
    
    Hashmode: 3200 - bcrypt $2*$, Blowfish (Unix) (Iterations: 32)
    
    Speed.#2.........:     4024 H/s (61.59ms) @ Accel:32 Loops:32 Thr:1 Vec:8
    
    Hashmode: 1800 - sha512crypt $6$, SHA512 (Unix) (Iterations: 5000)
    
    Speed.#2.........:     2188 H/s (92.98ms) @ Accel:128 Loops:1024 Thr:1 Vec:4
    
    Hashmode: 7500 - Kerberos 5, etype 23, AS-REQ Pre-Auth
    
    Speed.#2.........:  3875.7 kH/s (67.45ms) @ Accel:8 Loops:64 Thr:64 Vec:8
    
    Hashmode: 13100 - Kerberos 5, etype 23, TGS-REP
    
    Speed.#2.........:  3698.8 kH/s (70.64ms) @ Accel:2 Loops:256 Thr:64 Vec:8
    
    Hashmode: 15300 - DPAPI masterkey file v1 (Iterations: 23999)
    
    Speed.#2.........:     1708 H/s (99.42ms) @ Accel:512 Loops:1024 Thr:1 Vec:8
    
    Hashmode: 15900 - DPAPI masterkey file v2 (Iterations: 12899)
    
    Speed.#2.........:     1238 H/s (63.27ms) @ Accel:128 Loops:1024 Thr:1 Vec:4
    
    Hashmode: 7100 - macOS v10.8+ (PBKDF2-SHA512) (Iterations: 1023)
    
    Speed.#2.........:    15450 H/s (52.29ms) @ Accel:512 Loops:255 Thr:1 Vec:4
    
    Hashmode: 11600 - 7-Zip (Iterations: 16384)
    
    Speed.#2.........:     2524 H/s (101.02ms) @ Accel:128 Loops:4096 Thr:1 Vec:8
    
    Hashmode: 12500 - RAR3-hp (Iterations: 262144)
    
    Speed.#2.........:      339 H/s (47.06ms) @ Accel:32 Loops:16384 Thr:1 Vec:8
    
    Hashmode: 13000 - RAR5 (Iterations: 32799)
    
    Speed.#2.........:     1161 H/s (53.25ms) @ Accel:256 Loops:1024 Thr:1 Vec:8
    
    Hashmode: 6211 - TrueCrypt RIPEMD160 + XTS 512 bit (Iterations: 1999)
    
    Speed.#2.........:     8478 H/s (59.51ms) @ Accel:512 Loops:256 Thr:1 Vec:8
    
    Hashmode: 13400 - KeePass 1 (AES/Twofish) and KeePass 2 (AES) (Iterations: 24569)
    
    Speed.#2.........:      942 H/s (90.41ms) @ Accel:256 Loops:1024 Thr:1 Vec:8
    
    Hashmode: 6800 - LastPass + LastPass sniffed (Iterations: 499)
    
    Speed.#2.........:    77373 H/s (50.56ms) @ Accel:512 Loops:499 Thr:1 Vec:8
    
    Hashmode: 11300 - Bitcoin/Litecoin wallet.dat (Iterations: 200459)
    
    Speed.#2.........:      154 H/s (67.83ms) @ Accel:512 Loops:512 Thr:1 Vec:4
    
    Started: Wed Jul 22 22:02:03 2020
    Stopped: Wed Jul 22 22:06:18 2020


## Some thoughs

Hashcat seems to be a solid tool, and after getting it installed (with dependecies) it's pretty easy to get going with cracking. There are however A LOT of modes and options, so mastering this tool will take time. One should also have a dedicated rig for such things. Wondering if cloud could be used for something like this or if it will be to expensive.
