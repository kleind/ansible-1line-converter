I got tired of having to deal with ansible tasks where everything is put on one line.

# ansible-1line-converter

Converts 1line style ansible tasks like

```
- name: my ugly old task
  module_name: param1=value1 param2=value2 param3=value3 ugly=yes

- module_name: param1=value1 even_uglier=yes
```

to readable multiline formatting

```
- name: my ugly old task
  module_name:
    param1: "value1"
    param2: "value2"
    param3: "value3"
    bool: yes

- module_name:
    param1: "value1"
    even_uglier: yes
```

# Usage

```
./ansible-1line-converter $inputfile [debug]
```

will print the new syntax to STDOUT.

# What it does

* does not touch tasks using the shell and command modules
* preserves existing `"` and `'` quotes
* quotes previously not quoted non-boolean values

# How to add tests

1) Create old style input file `tests/$name.test`
2) Create expected output file `tests/$name.expected_out` (keep in mind the quoting explained in "What it does")
3) Create description file `tests/$name.desc`
4) Run `run_tests.sh`
