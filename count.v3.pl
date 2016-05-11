#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my $start_run = time();

unless ($#ARGV == 2) { 
	die "Usage: Run as $0 <input file> <top n results> <k-mer legnth>\n";
}

# Set in.txt, number of hits to show and k-mer length
my $in_file = $ARGV[0];
my $top_freqs = $ARGV[1];
my $kmer_length = $ARGV[2];

open my $in, '<', $in_file or die $!;

use constant CHUNK_SIZE => 1024 * 1024; # 1MB at a time

my $block;
my $length = 0;

open my $out, '>', 'out.txt' or die $!;

# Read into $block 1MB chunks of data from $in
# read FILEHANDLE, SCALAR, LENGTH, OFFSET
while ( my $nucs = sysread $in, $block, CHUNK_SIZE, $length ) {
    
	$length += $nucs;
	
	for my $offset ( 0 .. $length - $kmer_length ) {
		my $kmer = substr $block, $offset, $kmer_length;
		print $out "$kmer\n"; # print to OUT file for sorting later. File will be large - number of unique seqs can be up to 5**$kmer_length
    }
    $block = substr $block, - ($kmer_length-1);
	$length = length $block;
}

my @dups = `sort out.txt | uniq -c | sort -rn`; # sort all seqs of length $kmer_length, count freq of k-mer and sort by number, largest first 

system("rm out.txt");

my $count = 0;
foreach (@dups){
	chomp;
	s/ //g;
	my ($freq, $seq) = /(\d+)(.+)/;
	$count++;
 	print "$seq,$freq\n";
	last if $count >= $top_freqs; # print out top $top_freqs seqs 
}

my $end_run = time();
my $run_time = $end_run - $start_run;
print "Job took $run_time seconds\n";





