use utf8;
use Encode;

binmode(STDOUT, ":encoding(utf8)");

$file_name = shift @ARGV || die "$! \n usage: FILE_NAME";
$main_output = $file_name . "_nouns_adj_words";


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
$x = $variants[0]; # Словоформа


unless ($x =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/) {

$N_words++;

}

if ($variants[2] =~ /аа/ || $variants[2] =~ /аб/ || $variants[2] =~ /Эф/ || $variants[2] =~ /ав/ || $variants[2] =~ /аг/ ||
 $variants[2] =~ /ад/ || $variants[2] =~ /ае/ || $variants[2] =~ /Эх/ || $variants[2] =~ /ас/ || $variants[2] =~ /аж/ || 
 $variants[2] =~ /аз/ || $variants[2] =~ /аи/ || $variants[2] =~ /ай/ || $variants[2] =~ /ак/ || $variants[2] =~ /ал/ || $variants[2] =~ /ам/ ||
 $variants[2] =~ /ан/ || $variants[2] =~ /Юо/ || $variants[2] =~ /Юп/ || $variants[2] =~ /Юр/ || $variants[2] =~ /Юс/ || $variants[2] =~ /Ют/ ||
 $variants[2] =~ /Юф/ || $variants[2] =~ /Юх/ || $variants[2] =~ /Яб/ || $variants[2] =~ /Яа/ || $variants[2] =~ /Яв/ || $variants[2] =~ /Яг/ ||
 $variants[2] =~ /Яд/ || $variants[2] =~ /Яж/ || $variants[2] =~ /го/ || $variants[2] =~ /гп/ || $variants[2] =~ /гр/ || $variants[2] =~ /гс/ ||
 $variants[2] =~ /гт/ || $variants[2] =~ /гу/ || $variants[2] =~ /гф/ || $variants[2] =~ /гх/ || $variants[2] =~ /гц/ || $variants[2] =~ /гч/ ||
 $variants[2] =~ /гш/ || $variants[2] =~ /гщ/ || $variants[2] =~ /ва/ || $variants[2] =~ /вб/ || $variants[2] =~ /вв/ || $variants[2] =~ /вг/ || 
 $variants[2] =~ /вд/ || $variants[2] =~ /ве/ || $variants[2] =~ /вж/ || $variants[2] =~ /вз/ || $variants[2] =~ /ви/ || $variants[2] =~ /вй/ ||
 $variants[2] =~ /вк/ || $variants[2] =~ /вл/ || $variants[2] =~ /вм/ || $variants[2] =~ /вн/ || $variants[2] =~ /во/ || $variants[2] =~ /вп/ || 
 $variants[2] =~ /вр/ || $variants[2] =~ /вс/ || $variants[2] =~ /вт/ || $variants[2] =~ /ву/ || $variants[2] =~ /вф/ || $variants[2] =~ /вх/ ||
 $variants[2] =~ /вц/ || $variants[2] =~ /вч/ || $variants[2] =~ /вш/ || $variants[2] =~ /га/ || $variants[2] =~ /гб/ || $variants[2] =~ /гв/ ||
 $variants[2] =~ /гг/ || $variants[2] =~ /гд/ || $variants[2] =~ /ге/ || $variants[2] =~ /Эч/ || $variants[2] =~ /Йш/ || $variants[2] =~ /гж/ ||
 $variants[2] =~ /гз/ || $variants[2] =~ /ги/ || $variants[2] =~ /гй/ || $variants[2] =~ /гк/ || $variants[2] =~ /гл/ || $variants[2] =~ /гм/ ||
 $variants[2] =~ /гн/ || $variants[2] =~ /Йа/ || $variants[2] =~ /Йб/ || $variants[2] =~ /Йв/ || $variants[2] =~ /Йг/ || $variants[2] =~ /Йд/ ||
 $variants[2] =~ /Йе/ || $variants[2] =~ /Йж/ || $variants[2] =~ /Йз/ || $variants[2] =~ /Йи/ || $variants[2] =~ /Йй/ || $variants[2] =~ /Йк/ ||
 $variants[2] =~ /Йл/ || $variants[2] =~ /Йм/ || $variants[2] =~ /Йн/ || $variants[2] =~ /Йо/ || $variants[2] =~ /Йп/ || $variants[2] =~ /Йр/ ||
 $variants[2] =~ /Йс/ || $variants[2] =~ /Йт/ || $variants[2] =~ /Йу/ || $variants[2] =~ /Йф/ || $variants[2] =~ /Йх/ || $variants[2] =~ /Йц/ ||
 $variants[2] =~ /Йч/ || $variants[2] =~ /еа/ || $variants[2] =~ /еб/ || $variants[2] =~ /ев/ || $variants[2] =~ /ег/ || $variants[2] =~ /ед/ ||
 $variants[2] =~ /ее/ || $variants[2] =~ /еж/ || $variants[2] =~ /ез/ || $variants[2] =~ /еи/ || $variants[2] =~ /ей/ || $variants[2] =~ /ек/ ||
 $variants[2] =~ /ел/ || $variants[2] =~ /ем/ || $variants[2] =~ /ен/ || $variants[2] =~ /Эя/ || $variants[2] =~ /Яз/ || $variants[2] =~ /Яи/ ||
 $variants[2] =~ /Эя/ || $variants[2] =~ /Як/ || $variants[2] =~ /Ял/ || $variants[2] =~ /Ям/ || $variants[2] =~ /Ян/ || $variants[2] =~ /Яо/ ||
 $variants[2] =~ /Яп/ || $variants[2] =~ /Яр/ || $variants[2] =~ /Яс/ || $variants[2] =~ /Ят/ || $variants[2] =~ /Яу/ || $variants[2] =~ /иж/ ||
 $variants[2] =~ /из/ || $variants[2] =~ /ии/ || $variants[2] =~ /ий/ || $variants[2] =~ /ик/ || $variants[2] =~ /ил/ || $variants[2] =~ /им/ ||
 $variants[2] =~ /ао/ || $variants[2] =~ /ап/ || $variants[2] =~ /ат/ || $variants[2] =~ /ау/ || $variants[2] =~ /ац/ || $variants[2] =~ /ач/ ||
 $variants[2] =~ /аъ/ || $variants[2] =~ /бо/ || $variants[2] =~ /бп/ || $variants[2] =~ /бр/ || $variants[2] =~ /бс/ || $variants[2] =~ /бт/ ||
 $variants[2] =~ /бу/ || $variants[2] =~ /бь/ || $variants[2] =~ /бф/ || $variants[2] =~ /бх/ || $variants[2] =~ /бц/ || $variants[2] =~ /бч/ ||
 $variants[2] =~ /бш/ || $variants[2] =~ /бщ/ || $variants[2] =~ /бН/ || $variants[2] =~ /вН/ || $variants[2] =~ /вО/ || $variants[2] =~ /вП/ ||
 $variants[2] =~ /вР/ || $variants[2] =~ /вС/ || $variants[2] =~ /вТ/ || $variants[2] =~ /вУ/ || $variants[2] =~ /вЬ/ || $variants[2] =~ /вФ/ ||
 $variants[2] =~ /вХ/ || $variants[2] =~ /вЦ/ || $variants[2] =~ /вЧ/ || $variants[2] =~ /вШ/ || $variants[2] =~ /вЩ/ || $variants[2] =~ /до/ ||
 $variants[2] =~ /дп/ || $variants[2] =~ /др/ || $variants[2] =~ /дс/ || $variants[2] =~ /дт/ || $variants[2] =~ /дь/ || $variants[2] =~ /дф/ ||
 $variants[2] =~ /дх/ || $variants[2] =~ /дц/ || $variants[2] =~ /дч/ || $variants[2] =~ /дш/ || $variants[2] =~ /Дщ/ || $variants[2] =~ /дН/ ||
 $variants[2] =~ /Ра/ || $variants[2] =~ /Рб/ || $variants[2] =~ /Рв/ || $variants[2] =~ /Рг/ || $variants[2] =~ /Рд/ || $variants[2] =~ /Ре/ ||
 $variants[2] =~ /Рн/ || $variants[2] =~ /Ро/ || $variants[2] =~ /Рп/ || $variants[2] =~ /Рр/ || $variants[2] =~ /Рс/ || $variants[2] =~ /Рт/ ||
 $variants[2] =~ /Рж/ || $variants[2] =~ /Рз/ || $variants[2] =~ /Ри/ || $variants[2] =~ /Рк/ || $variants[2] =~ /Рл/ || $variants[2] =~ /Рм/ ||
 $variants[2] =~ /Ру/ || $variants[2] =~ /Ру/ || $variants[2] =~ /Рф/ || $variants[2] =~ /Рх/ || $variants[2] =~ /Рц/ || $variants[2] =~ /Рч/ ||
 $variants[2] =~ /Рш/ || $variants[2] =~ /Та/ || $variants[2] =~ /Тб/ || $variants[2] =~ /Тв/ || $variants[2] =~ /Тг/ || $variants[2] =~ /Тд/ ||
 $variants[2] =~ /Те/ || $variants[2] =~ /Тн/ || $variants[2] =~ /То/ || $variants[2] =~ /Тп/ || $variants[2] =~ /Тр/ || $variants[2] =~ /Тс/ ||
 $variants[2] =~ /Тт/ || $variants[2] =~ /Тж/ || $variants[2] =~ /Тз/ || $variants[2] =~ /Ти/ || $variants[2] =~ /Тк/ || $variants[2] =~ /Тл/ ||
 $variants[2] =~ /Тм/ || $variants[2] =~ /Ту/ || $variants[2] =~ /Тф/ || $variants[2] =~ /Тх/ || $variants[2] =~ /Тц/ || $variants[2] =~ /Тч/ ||
 $variants[2] =~ /Тш/ )
 {
      #print "$variants[1]  $variants[2] \n";
      $x = $x . "_NOUN"
  };

 if (

$variants[2] =~ /йа/ || $variants[2] =~ /йб/ || $variants[2] =~ /йв/ || $variants[2] =~ /йг/ || $variants[2] =~ /Рщ/ || $variants[2] =~ /йд/ ||
$variants[2] =~ /йе/ || $variants[2] =~ /йж/ || $variants[2] =~ /йз/ || $variants[2] =~ /йи/ || $variants[2] =~ /йй/ || $variants[2] =~ /йк/ ||
$variants[2] =~ /йл/ || $variants[2] =~ /йм/ || $variants[2] =~ /йн/ || $variants[2] =~ /йо/ || $variants[2] =~ /йп/ || $variants[2] =~ /йр/ ||
$variants[2] =~ /йс/ || $variants[2] =~ /йт/ || $variants[2] =~ /йу/ || $variants[2] =~ /йф/ || $variants[2] =~ /йх/ || $variants[2] =~ /Рь/ )
{
  $x = $x . "_ADJ"
}

#if ($x =~ /\W/ || $x_1 =~ /\W/ || $x_2 =~ /\W/ || $x_3 =~ /\W/ || $x_4 =~ /\W/) {next;}
#if ($x =~ /[a-zA-Z]/ || $x_1 =~ /[a-zA-Z]/ || $x_2 =~ /[a-zA-Z]/) {next;}





if ($x =~ /_NOUN/) {

$N_noun++;
$p1{$x}++;

}

if ($x =~ /_ADJ/) {
$N_adj++;
$p1{$x}++;

}

if (($x =~ /_NOUN/ || $x =~ /_ADJ/) && ($x_1 =~ /_NOUN/ || $x_1 =~ /_ADJ/)) { 

unless ($x =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ ||


  $x_1 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/)  {

$bi = $x_1 . "\t" . $x;
$p2{$bi}++;
}
}

if (($x =~ /_NOUN/ || $x =~ /_ADJ/) && ($x_1 =~ /_NOUN/ || $x_1 =~ /_ADJ/) && ($x_2 =~ /_NOUN/ || $x_2 =~ /_ADJ/)) { 

unless ($x =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ ||
$x_1 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ ||
$x_2 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/)  {

$tri = $x_2 . "\t" . $x_1 . "\t" . $x;
$p3{$tri}++;
}
}

if (($x =~ /_NOUN/ || $x =~ /_ADJ/) && ($x_1 =~ /_NOUN/ || $x_1 =~ /_ADJ/) && ($x_2 =~ /_NOUN/ || $x_2 =~ /_ADJ/) && ($x_3 =~ /_NOUN/ || $x_3 =~ /_ADJ/)) { 
unless ($x =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ || 
$x_1 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ ||
$x_2 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/ ||
$x_3 =~ /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*)/)  {

$four = $x_3 . "\t" . $x_2 . "\t" . $x_1 . "\t" . $x;
$p4{$four}++;
}
}

if (($x =~ /_NOUN/ || $x =~ /_ADJ/) && ($x_1 =~ /_NOUN/ || $x_1 =~ /_ADJ/) && ($x_2 =~ /_NOUN/ || $x_2 =~ /_ADJ/) && ($x_3 =~ /_NOUN/ || $x_3 =~ /_ADJ/) &&  ($x_4 =~ /_NOUN/ || $x_4 =~ /_ADJ/)) { 

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
print "N_noun: $N_noun\n";
print "N_adj: $N_adj\n";

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
 $w =~ s/_NOUN//g;
 $w =~ s/_ADJ//g;
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
 $w =~ s/_NOUN//g;
 $w =~ s/_ADJ//g;
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
 $w =~ s/_NOUN//g;
 $w =~ s/_ADJ//g;  

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
 $w =~ s/_NOUN//g;
 $w =~ s/_ADJ//g;
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
 $w =~ s/_NOUN//g;
 $w =~ s/_ADJ//g;
print OUT $w . "\t\t" . $p5{$five} . "\t" . $freq_rel . "\t" . $ipm . "\n"; 
}
close OUT;
%p5 = ();






