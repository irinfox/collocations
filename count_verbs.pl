use utf8;
use Encode;

binmode(STDOUT, ":encoding(utf8)");

$file_name = shift @ARGV || die "$! \n usage: FILE_NAME";
$main_output = $file_name . "_verbs";


print "read file $file_name \n";

open (IN, "<$file_name") || die $!;
binmode (IN, ":encoding(utf8)");

$mln = 0;

while (<IN>) {

$N++;

#p)rint $mln . "\t" . $N . "\n";
@variants = split;



chomp;

$x_4 = $x_3;
$x_3 = $x_2;
$x_2 = $x_1;
$x_1 = $x; 
$x = $variants[1]; # Лемма 

unless ($x =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/) {
 $N_words++;
}

if ($variants[2] =~ /нр/ || $variants[2] =~ /нс/ || $variants[2] =~ /нт/ || $variants[2] =~ /ну/ || $variants[2] =~ /ка/ ||
 $variants[2] =~ /кб/ || $variants[2] =~ /кв/ || $variants[2] =~ /кг/ || $variants[2] =~ /кд/ || $variants[2] =~ /ке/ || 
 $variants[2] =~ /кж/ || $variants[2] =~ /кз/ || $variants[2] =~ /ки/ || $variants[2] =~ /кй/ || $variants[2] =~ /кк/ || $variants[2] =~ /кп/ ||
 $variants[2] =~ /кр/ || $variants[2] =~ /кс/ || $variants[2] =~ /кт/ || $variants[2] =~ /ку/ || $variants[2] =~ /кф/ || $variants[2] =~ /Ръ/ ||
 $variants[2] =~ /Ры/ || $variants[2] =~ /Рэ/ || $variants[2] =~ /Рю/ || $variants[2] =~ /Ря/ || $variants[2] =~ /кю/ || $variants[2] =~ /кя/ ||
 $variants[2] =~ /кэ/ || $variants[2] =~ /Эа/ || $variants[2] =~ /Эб/ || $variants[2] =~ /Эв/ || $variants[2] =~ /Эг/ || $variants[2] =~ /Эд/ ||
 $variants[2] =~ /Эе/ || $variants[2] =~ /Эж/ || $variants[2] =~ /Эз/ || $variants[2] =~ /Эи/ || $variants[2] =~ /Эй/ || $variants[2] =~ /Эк/ ||
 $variants[2] =~ /Эл/ || $variants[2] =~ /Эм/ || $variants[2] =~ /Эн/ || $variants[2] =~ /Эо/ || $variants[2] =~ /Эп/ || $variants[2] =~ /Эр/ || 
 $variants[2] =~ /Эс/)

 {
      #print "$variants[1]  $variants[2] \n";
      $x = $x . "_VERB"
  };
 

#if ($x =~ /\W/ || $x_1 =~ /\W/ || $x_2 =~ /\W/ || $x_3 =~ /\W/ || $x_4 =~ /\W/) {next;}
#if ($x =~ /[a-zA-Z]/ || $x_1 =~ /[a-zA-Z]/ || $x_2 =~ /[a-zA-Z]/) {next;}





if ($x =~ /_VERB/) {

$N_verb++;
$p1{$x}++;

}

if ($x =~ /_VERB/ || $x_1 =~ /_VERB/) { 

unless ($x =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ ||
  $x_1 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/)  {

$bi = $x_1 . "\t" . $x;
$p2{$bi}++;
}
}

if ($x =~ /_VERB/ || $x_1 =~ /_VERB/ || $x_2 =~ /_VERB/) { 


unless ($x =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ ||
$x_1 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ ||
$x_2 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/)  {

$tri = $x_2 . "\t" . $x_1 . "\t" . $x;
$p3{$tri}++;
}
}

if ($x =~ /_VERB/ || $x_1 =~ /_VERB/ || $x_2 =~ /_VERB/ || $x_3 =~ /_VERB/) { 


unless ($x =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ || 
$x_1 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ ||
$x_2 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ ||
$x_3 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/)  {

$four = $x_3 . "\t" . $x_2 . "\t" . $x_1 . "\t" . $x;
$p4{$four}++;
}
}

if ($x =~ /_VERB/ || $x_1 =~ /_VERB/ || $x_2 =~ /_VERB/ || $x_3 =~ /_VERB/ || $x_4 =~ /_VERB/) { 


unless ($x =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ ||
$x_1 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ ||
$x_2 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ ||
$x_3 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ ||
$x_4 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/)  {


$five = $x_4 . "\t" . $x_3 . "\t" . $x_2 . "\t" . $x_1 . "\t" . $x;
$p5{$five}++;

}
}
#print "*";
}

close IN;

print "\n N: $N\n";
print "N_words: $N_words\n";
print "N_verb: $N_verb\n";
print "print freqs \n";

print "print words freq \n";
$out = "_1_" . $main_output;
open (OUT, ">$out");

print OUT "word \t\t freq \t freq_rel \t ipm \n"; 

binmode (OUT, ":encoding(utf8)");
foreach $x ( sort {$p1{$b} <=> $p1{$a} || $a cmp $b} keys(%p1)) {
 $freq_rel = ( $p1{$x} )/$N_words;
 $freq_rel = sprintf("%.6f", $freq_rel);
 $ipm = $freq_rel * 1000000;
 $w = $x;
 $w =~ s/_VERB//g;
 print OUT $w . "\t\t" . $p1{$x} . "\t" . $freq_rel . "\t" . $ipm . "\n";
}
close OUT;
%p1 = ();

print "print 2_words freq \n";
$out = $name . "_2_" . $main_output;
open (OUT, ">$out");

print OUT "colloc \t\t\t freq \t freq_rel \t ipm \n"; 

binmode (OUT, ":encoding(utf8)");
foreach $bi (sort {$p2{$b} <=> $p2{$a} || $a cmp $b} keys(%p2)) {
 $freq_rel = ( $p2{$bi} )/$N_words;
 $freq_rel = sprintf("%.6f", $freq_rel);
 $ipm = $freq_rel * 1000000;
 $w = $bi;
 $w =~ s/_VERB//g;
 print OUT $w . "\t\t" . $p2{$bi} . "\t" . $freq_rel . "\t" . $ipm . "\n"; 
}
close OUT;
%p2 = ();

print "print 3_words freq \n";
$out = $name . "_3_" . $main_output;
open (OUT, ">$out");


print OUT "colloc \t\t\t\t freq \t freq_rel \t ipm \n"; 


binmode (OUT, ":encoding(utf8)");
foreach $tri (sort {$p3{$b} <=> $p3{$a} || $a cmp $b} keys(%p3)) {

 $freq_rel = ( $p3{$tri} )/$N_words;
 $freq_rel = sprintf("%.6f", $freq_rel);
 $ipm = $freq_rel * 1000000;


 $w = $tri;
 $w =~ s/_VERB//g;

 print OUT $w . "\t\t" . $p3{$tri} . "\t" . $freq_rel . "\t" . $ipm . "\n"; 
}
close OUT;
%p3 = ();

print "print 4_words freq \n";
$out = $name . "_4_" . $main_output;
open (OUT, ">$out");


print OUT "colloc \t\t\t\t\t freq \t freq_rel \t ipm \n"; 


binmode (OUT, ":encoding(utf8)");
foreach $four (sort {$p4{$b} <=> $p4{$a} || $a cmp $b} keys(%p4)) {
 $freq_rel = ( $p4{$four} )/$N_words;
 $freq_rel = sprintf("%.6f", $freq_rel);
 $ipm = $freq_rel * 1000000;

 $w = $four;
 $w =~ s/_VERB//g;

 print OUT $w . "\t\t" . $p4{$four} . "\t" . $freq_rel . "\t" . $ipm . "\n"; 

}
close OUT;
%p4 = ();

print "print 5_words freq \n";
$out = $name . "_5_" . $main_output;
open (OUT, ">$out");

print OUT "colloc \t\t\t\t\t\t freq \t freq_rel \t ipm \n"; 

binmode (OUT, ":encoding(utf8)");
foreach $five (sort {$p5{$b} <=> $p5{$a} || $a cmp $b} keys(%p5)) {

 $freq_rel = ( $p5{$five} )/$N_words;
 $freq_rel = sprintf("%.6f", $freq_rel);
 $ipm = $freq_rel * 1000000;
 

 $w = $five;
 $w =~ s/_VERB//g;

print OUT $w . "\t\t" . $p5{$five} . "\t" . $freq_rel . "\t" . $ipm . "\n"; 
}
close OUT;
%p5 = ();






