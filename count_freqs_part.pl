use utf8;
use Encode;

binmode(STDOUT, ":encoding(utf8)");

$file_name = shift @ARGV || die "$! \n usage: FILE_NAME";
$main_output = $file_name;


print "read file $file_name \n";

open (IN, "<$file_name") || die $!;
binmode (IN, ":encoding(utf8)");

$mln = 0;

while (<IN>) {
$mln++;
$N++;

#print $mln . "\t" . $N . "\n";

chomp;

$x_4 = $x_3;
$x_3 = $x_2;
$x_2 = $x_1;
$x_1 = $x; 
$x = $_;

#if ($x =~ /\W/ || $x_1 =~ /\W/ || $x_2 =~ /\W/ || $x_3 =~ /\W/ || $x_4 =~ /\W/) {next;}
#if ($x =~ /[a-zA-Z]/ || $x_1 =~ /[a-zA-Z]/ || $x_2 =~ /[a-zA-Z]/) {next;}

$p1{$x}++;
$bi = $x_1 . "\t" . $x;
$p2{$bi}++;
$tri = $x_2 . "\t" . $x_1 . "\t" . $x;
$p3{$tri}++;
$four = $x_3 . "\t" . $x_2 . "\t" . $x_1 . "\t" . $x;
$p4{$four}++;
$five = $x_4 . "\t" . $x_3 . "\t" . $x_2 . "\t" . $x_1 . "\t" . $x;
$p5{$five}++;

if ($mln >= 1000000) {

$mln = 0;
$name = $name + 1000000;

print "N: $N\n";
print "print freqs \n";

print "print words freq \n";
$out = $name . "_1_" . $main_output;
open (OUT, ">$out");
binmode (OUT, ":encoding(utf8)");
foreach $x ( sort {$p1{$b} <=> $p1{$a} || $a cmp $b} keys(%p1)) {
 print OUT $x . "\t" . $p1{$x} . "\n";
}
close OUT;
%p1 = ();

print "print 2_words freq \n";
$out = $name . "_2_" . $main_output;
open (OUT, ">$out");
binmode (OUT, ":encoding(utf8)");
foreach $bi (sort {$p2{$b} <=> $p2{$a} || $a cmp $b} keys(%p2)) {
 print OUT $bi . "\t" . $p2{$bi} . "\n"; 
}
close OUT;
%p2 = ();

print "print 3_words freq \n";
$out = $name . "_3_" . $main_output;
open (OUT, ">$out");
binmode (OUT, ":encoding(utf8)");
foreach $tri (sort {$p3{$b} <=> $p3{$a} || $a cmp $b} keys(%p3)) {
 print OUT $tri . "\t" . $p3{$tri} . "\n";
}
close OUT;
%p3 = ();

print "print 4_words freq \n";
$out = $name . "_4_" . $main_output;
open (OUT, ">$out");
binmode (OUT, ":encoding(utf8)");
foreach $four (sort {$p4{$b} <=> $p4{$a} || $a cmp $b} keys(%p4)) {
 print OUT $four . "\t" . $p4{$four} . "\n";
}
close OUT;
%p4 = ();

print "print 5_words freq \n";
$out = $name . "_5_" . $main_output;
open (OUT, ">$out");
binmode (OUT, ":encoding(utf8)");
foreach $five (sort {$p5{$b} <=> $p5{$a} || $a cmp $b} keys(%p5)) {
 print OUT $five . "\t" . $p5{$five} . "\n";
}
close OUT;
%p5 = ();



}
}
close IN;
