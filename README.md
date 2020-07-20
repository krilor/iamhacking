# iamhacking
My notes while exploring "hacking" - a low quality blog/journal

Read at https://krilor.github.io/iamhacking/

# For me

## New post?

`hugo new posts/my-post-name.md`

## Run local?

`hugo server -D`

## Write using Jupyter

Fire up jupyter: `jupyter notebook`

Add a markdown cell with front matter at the beginning

```markdown
---

title: "Sample title"
date: 2020-07-20T10:04:24+02:00
tags: ["sample", "title"]
draft: false

---
```

Store in `/notebooks`

Once done, run `make convert`
