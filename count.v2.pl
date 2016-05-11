#!/usr/bin/perl
use strict;
use warnings;

my $start_run = time();

unless ($#ARGV == 2) { 
	die "Usage: Run as $0 <input file> <top n results> <k-mer legnth>\n";
}

# Set in.txt, number of hits to show and k-mer length
my $in_file = $ARGV[0];
my $top_freqs = $ARGV[1]; # - 1 for array later 
my $kmer_length = $ARGV[2];

open my $in, '<', $in_file or die $!;

use constant BLOCK_SIZE => 1024 * 1024; # 1MB at a time

my %data;
my $block;
my $length = 0;

# Read into $block 1MB chunks of data from $in
# read FILEHANDLE, SCALAR, LENGTH, OFFSET
while ( my $nucs = sysread $in, $block, BLOCK_SIZE, $length ) {
    
	$length += $nucs;
	
	for my $offset ( 0 .. $length - $kmer_length ) {
		my $kmer = substr $block, $offset, $kmer_length;
		$data{$kmer}++;
    }
	
    $block = substr $block, - ($kmer_length-1);
	$length = length $block;
}

my $count = 0;
foreach my $seq (sort { $data{$b} <=> $data{$a} } keys %data ){
	print "$seq,$data{$seq}\n";
	$count++;
	last if $count >= $top_freqs;
}

my $end_run = time();
my $run_time = $end_run - $start_run;
print "Job took $run_time seconds\n";