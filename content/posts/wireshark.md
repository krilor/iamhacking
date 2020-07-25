---
title: "Wireshark for network traffic"
date: 2020-07-25T12:03:28+02:00
draft: true
---

I wanted to take [Wireshark](https://www.wireshark.org/) for a spin. Wireshark lets you see what’s happening on your network at a microscopic level and is the de facto standard for network protocol analysis.

Installation was pretty straight forward. Just unstalled the Ubuntu packages *wireshark* (GUI) and *tshark* (CLI), then followed [this thread](https://osqa-ask.wireshark.org/questions/7976/wireshark-setup-linux-for-nonroot-user) to set up non-root access for myself.

## Testing

Testing it was pretty straigh forward. Just fire it up and inspect the network packages as I browse the internet. But I wanted to do something "real", so I went googling for a simple CTF challenge that could help with that.

I landed on the [tryhackme.com Wireshark CTFs](https://tryhackme.com/room/wirectf). The first challenge is to find a flag within the a downloadable .pcap file on the format `****{********************************}`. First thing I did was do a simple egrep. Both of these found something of interest, but it is not easy to figure out where to go from there.

```bash
egrep -a flag net.pcap
egrep -a '.{4}\{.{32}\}' net.pcap
```

Flag *a* is binary as text.

So I started Wireshark and just felt lost. Where to start? Since what I want is to explore wireshark, I found a [ctf walkthrough](https://blog.qz.sg/wireshark-ctfs-writeup-tryhackme-part-1-of-2/) on googlez.

Useful wireshark functions used in the walkthrough are

* File -> Export Objects -> HTTP
* [Right click package] -> Follow -> TCP Steam

That gives everything we need to continue deciphering the data using our favorite scripting language. I'll save that for later.

What are other ways we could have identified this traffic/transfer using Wireshark or tshark?

## Tshark commands

```bash
# export objects
tshark -r net.pcap --export-objects http,tmpfolder

# tcp text search
tshark -r net.pcap -Y 'tcp contains flag'

# follow stream
tshark -r net.pcap -q -z follow,tcp,hex,4
```

These are some of the commands I used.

## Thoughts

While I didn't actually solve the CFT, I did spend some time using Wireshark and tshark. I guess one needs to spend quite a lot more time with it, but hey, it is a good start.
