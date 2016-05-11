#!/usr/bin/perl
use warnings;
use strict;

my $start_run = time();


unless ($#ARGV == 2) { 
	die "Usage: Run as $0 <top n results> <k-mer legnth>\n";
}

# Set in.txt, number of hits to show and k-mer length
my $sequence = $ARGV[0];
my $top_freqs = ($ARGV[1] - 1); # - 1 for array later 
my $k_length = $ARGV[2];

my $in = sysread $sequence or die $!;

# Read file as string
my $nucs = <$in>; 

my $len = length($nucs);

my %data; 

for (my $i = 0; $i <= $len - $k_length; $i++) {
     my $kmer = substr($nucs, $i, $k_length);
     $data{$kmer}++; # populate hash with frequency of k-mer 
}

# print out sorted hash, showing top n
my $count = 0;
foreach my $seq (sort { $data{$b} <=> $data{$a} } keys %data ){
	print "$seq,$data{$seq}\n";
	$count++;
	last if $count > $top_freqs;
}

my $end_run = time();
my $run_time = $end_run - $start_run;
print "Job took $run_time seconds\n";

