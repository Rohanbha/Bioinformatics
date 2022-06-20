#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;

#Find features of target from GFF for Arabidopsis#
my $target_file = 'Arab_eValue_filtered_with_chr_minus.txt';
my $gff_file = 'Athaliana_447_Araport11.gene_exons_MinusStrand.gff3';
my $output_file = 'Finalminusoutput.txt';
open(our $tf, '<', $target_file) or die "Can't read file '$target_file' [$!]\n";       #Open match_lenJoined_domains.csv
open(our $gf, '<', $gff_file) or die "Can't read file '$gff_file' [$!]\n";
open(our $of, '>>', 'Finalminusoutput.txt') or die "Can't read file output.txt [$!]\n";
while (our $line1 = <$tf>) {                                              #Read each row
    chomp $line1;
    our @fields1 = split(/\t/, $line1);                                    #Make an array of each row with column vales as elements
    our $ptnc = $fields1[0];                                             #Read Mediator type(Med6)
    our $ncbi = $fields1[1];
    our $tstart = $fields1[6];
    our $tend = $fields1[7];
    our $chrstart = $fields1[14];
    #print "$ptnc\t$ncbi\t$tstart\t$tend\t$chrstart\t$chrend\n";
    our $t_chr_start = $chrstart - $tstart;
    our $t_chr_end = $chrstart - $tend;
    our $midpoint = ($t_chr_start + $t_chr_end)/2;
    #print "Midpoint is $midpoint\n";
    open(our $gf, '<', $gff_file) or die "Can't read file '$gff_file' [$!]\n";
    while (our $line2 = <$gf>) {
	    chomp $line2;
	    my @fields2 = split(/\t/, $line2);
	    my $ncbi2 = $fields2[9];
	    #print "ID is $ncbi and $ncbi2\n";
	    if ($ncbi2 eq $ncbi) {		    #Select Med6
		    our $feat_start = $fields2[10];
		    our $feat_end = $fields2[11];
		    if ($midpoint > $feat_start && $midpoint < $feat_end) {
		    open(our $of, '>>', 'Finalminusoutput.txt') or die "Can't read file Finalminusoutput.txt [$!]\n";
		    print $of "$ptnc\t$ncbi\t$midpoint\t$fields2[0]\t$fields2[2]\t$fields2[10]\t$fields2[11]\t$fields2[6]\t$ncbi2\n";
		    #print "Desc is $ncbi2 and target ID is $ncbi\n";
		    #print "Yo!";
	    	    }
    	    }
    }
}
close $tf;
close $gf;
close $of;

