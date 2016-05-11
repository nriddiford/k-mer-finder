**A program to find a the n most frequently occuring k-mers in a DNA string**

Given a text file containing a sequence of letters from the alphabet {A, C, G, T, N}, write a program using a programming language of your choice that produces a list, sorted by frequency, of the n most frequent k-mers in that file, for a given k. A valid solution must include a build script that builds a working executable (if building is required) that we can test on either Mac OS X or Linux.

The program should be callable like this:

count input.txt 25 20
In this example, it would process the file input.txt and extract the top 25 k-mers of length 20. It should print the output to standard out in comma-separated format, something like this:

agctcgctagtacgatctct,612874
cgtacgannctancatatca,537465
...
