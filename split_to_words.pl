#!/usr/bin/perl
use strict;
use utf8;
use Getopt::Std;

my $re_spacer = '\s\t';
my $re_alpha = 'A-Za-zА-Яа-яЁё0-9';
my @tokens;
my $fh;

my %opts;
getopts('ilf:p', \%opts);

# display help
if (!$opts{'f'} && !$opts{'i'}) {
    print "Usage:\n$0 -f FILE (read from FILE)\n$0 -i (read from standard input)\nAdditional parameters:
    -l\tmake lowercase
    -p\tdiscard punctuation\n";
    exit;
}

binmode(STDOUT, ':encoding(utf8)');

# we may read either STDIN or given file
if ($opts{'f'}) {
    open $fh, $opts{'f'} or die "Failed to open file: $!";
} else {
    $fh = \*STDIN;
}
binmode($fh, ':encoding(utf8)');

while(<$fh>) {
    next unless /\S/;
    @tokens = split /[$re_spacer]+/;
    for my $t(@tokens) {
        next if $t eq '';
        
        if ($t =~ /^([^$re_alpha]+)?([$re_alpha\-\']+)?([^$re_alpha]+)?$/) {
            if ($1 && !$opts{'p'}) {
                print "$1\n";
            }
            if ($2) {
                if ($opts{'l'}) {
                    print lc($2)."\n";
                } else {
                    print "$2\n";
                }
            }
            if ($3 && !$opts{'p'}) {
                print "$3\n";
            }
        }
    }
}
