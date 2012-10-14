#!/usr/bin/perl
#программа считает абс. частоту и ipm для 1-3грамм, отсекает по частоте равной четырём. Особенность: считает биграммы через одно слово (в выводе это слово заменяет звёздочкой).

use utf8;
use Encode;

binmode(STDOUT, ":encoding(utf8)");

$file_name = shift @ARGV || die "$! \n usage: metrics_trigram.pl FILE_NAME";
$main_output = $file_name;

$bound = 3;

sub log2 {
  my $n = shift;
  return log($n)/log(2);
}
#подпрограмма для log, переход от основания e к 2

print "read file $file_name \n";

open (IN, "<$file_name");
binmode (IN, ":encoding(utf8)");

while (<IN>) {

$N++;
#print "N: $N \n";
chomp;
$x_2 = $x_1;
#print "x_2: $x_2 \t";
$x_1 = $x; 
#print "x_1: $x_1 \t";
$x = $_;
#переменные для слова, предыдущего и предпредыдущего слов

if ($x =~ /\W/ || $x_1 =~ /\W/ || $x_2 =~ /\W/) {next;}
if ($x =~ /[a-zA-Z]/ || $x_1 =~ /[a-zA-Z]/ || $x_2 =~ /[a-zA-Z]/) {next;}
#слова попадают в дальнейшую обработку, если написаны не латиницей

#print "x: $x \t";
$p{$x}++;
#print "p{$x}: $p{$x} \n";
$bi = $x_1 . "\t" . $x;
$p2{$bi}++;
#print "bi: $bi \t p2{$bi}: $p2{$bi} \n";
$bi1_3 = $x_2 . "\t*\t" . $x;
$p1_3{$bi1_3}++;
#print "bi1_3: $bi1_3 \t p1_3{$bi1_3}: $p1_3{$bi1_3} \n";
$tri = $x_2 . "\t" . $x_1 . "\t" . $x;
$p3{$tri}++;
#print "tri: $tri \t p3{$tri}: $p3{$tri} \n";
}
#составление частотных словарей для однословных конструкций, биграмм и  триграмм

print "N: $N\n";
close IN;
print "print freqs \n";

print "print words freq \n";
$out = "1_" . $main_output;
#присваивание имени выходному файлу
open (OUT, ">$out");
binmode (OUT, ":encoding(utf8)");
foreach $x ( sort {$p{$b} <=> $p{$a} || $a cmp $b} keys(%p)) {
 if ($p{$x} < 4) {last;}
 $ipm = ( $p{$x} * 1000000 ) / $N;
 print OUT $x . "\t" . $p{$x} . "\t" . $ipm . "\n";
}
close OUT;
#печать частотного словаря с отсечение по частоте=4 и сортировкой по убыванию частот (в случае совпадения частот сортировка осуществляется по алфавиту)

print "print 2_words freq \n";
$out = "1-2_" . $main_output;
open (OUT, ">$out");
binmode (OUT, ":encoding(utf8)");
foreach $bi (sort {$p2{$b} <=> $p2{$a} || $a cmp $b} keys(%p2)) {
 if ($p2{$bi} < 4) {last;}
 $ipm = ( $p2{$bi} * 1000000 ) / $N;
 print OUT $bi . "\t" . $p2{$bi} . "\t" . $ipm . "\n"; 
}
close OUT;
#аналогично предыдущему, для биграмм (слова идут подряд)
$out = "1-3_" . $main_output;
open (OUT, ">$out");
binmode (OUT, ":encoding(utf8)");
foreach $bi1_3 (sort {$p1_3{$b} <=> $p1_3{$a} || $a cmp $b} keys(%p1_3)) {
 if ($p1_3{$bi1_3} < 4) {last};
 $ipm = ( $p1_3{$bi1_3} * 1000000 ) / $N;
 print OUT $bi1_3 . "\t" . $p1_3{$bi1_3} . "\t" . $ipm . "\n"; 
}
close OUT;
#аналогично предыдущим, для биграмм (через одно слово)
print "print 3_words freq \n";
$out = "1-2-3" . $main_output;
open (OUT, ">$out");
binmode (OUT, ":encoding(utf8)");
foreach $tri (sort {$p3{$b} <=> $p3{$a} || $a cmp $b} keys(%p3)) {
 if ($p3{$tri} < 4) {last;}
 $ipm = ( $p3{$tri} * 1000000 ) / $N;
 print OUT $tri . "\t" . $p3{$tri} . "\t" . $ipm . "\n";
} 
close OUT;
#аналогично предыдущим, для триграмм
