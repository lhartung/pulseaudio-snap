---
title: "Report a Bug"
table_of_contents: False
---

# Report a Bug

Bugs can be reported [here](https://bugs.launchpad.net/snappy-hwe-snaps/+filebug).

When submitting a bug report, please attach system log coming from the journal:

 * $ journalctl --no-pager > system-log

And the output of the following commands:

```
$ sudo pactl list
$ cat /proc/asound/cards
```
