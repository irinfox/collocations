
$directory = shift @ARGV;
$result_file =  shift @ARGV;

opendir(DIR, "$directory") || die $!;
print "open DIR \n";

while (defined($file = readdir(DIR))) {
print ++$t ."_file: " . $file . "\n";
if ($file eq "." || $file eq "..") {next;}
open (IN, "<$directory/$file") or die "$!";
print "*** \n";
while (<IN>) {
 chomp;
 @words = split;
 $freq = pop(@words);
  foreach $word (@words) {
   $colloc = $colloc . $word . "\t";
  }
 $p{$colloc} = $p{$colloc} + $freq;
# print $colloc . "\t" . $p{$colloc} . "\n";
 $colloc=""; 
 $N = $N+$freq;
}
close IN;
}

open (OUT, ">$result_file") || die $!;
print "open OUT \n";

foreach $colloc (sort {$p{$b} <=> $p{$a} || $a cmp $b} keys(%p)) {
 print OUT $colloc . $p{$colloc} . "\n"; 
}

close OUT;

print "N: $N \n";
