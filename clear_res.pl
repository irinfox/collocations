use utf8;
use Encode;

binmode(STDOUT, ":encoding(utf8)");

$file = "collocations_freq.txt";

open (FILE, "$file") || die $!;

$out = $file . "_clear";

open (OUT, ">$out") || die $!;

while(<FILE>) {
  if ($_ =~ /(\-|\,|\.|\;|\:|\"|\'|\!|\?|\(|\))/) {next;}
  print OUT $_;
 # print $_ . "\n";
}
close FILE;
close OUT;
