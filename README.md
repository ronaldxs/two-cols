# NAME

two-col - split "paragraphs" of text delimited by dash separators
into two columns.  By default each column is half the width of the
terminal in chars but `-t` option can set terminal width used.  Wraps
lines too long for column width.  

# SYNOPSIS

    $ two-cols <<EOT
    -------------
    line 1 p 1
    -------------

    --------------
    line 1 p 2
    line 2 p 2
    line 3 p 2
    --------------

    --------------
    line 1 p 3
    --------------

    EOT

OUTPUT:

    -------------                           --------------
    line 1 p 1                              line 1 p 2
    -------------                           line 2 p 2
                                            line 3 p 2
    --------------                          --------------
    line 1 p 3
    --------------

## SWITCHES

- **-t**

    Set effective terminal width.  Each column will be half the width
    of the terminal in characters.

## Further Development

This project is based on a
[question from stackoverflow](https://stackoverflow.com/questions/49620687/print-a-file-in-multiple-columns-based-on-delimiter).
If further development is desired please post an issue on
[GitHub](https://github.com/ronaldxs/two-cols.git) or contact me,
ronaldxs at software-path.com .
