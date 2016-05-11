#!/usr/bin/perl
use warnings;
use strict;
# use diagnostics;
use Data::Dumper;
$Data::Dumper::Sortkeys = 1;
use feature qw(say);

### Generate dummy in file ###

my @chars = qw(A C G T N);
my $string;
$string .= $chars[rand @chars] for 1..1000000;

open my $dummy, '>', 'test_in.txt' or die $!;

print $dummy "$string";

