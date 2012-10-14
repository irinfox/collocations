#!/usr/bin/perl
use strict;
use utf8;
use Encode;

#this is a program for snow_collections, we have a file, in whcih we interested, and the whole directory of contrastive files (however, not enough for tf-idf. We count absolute term frequences for each word from interested file in the contrast files and in this file itself. The finite metric is tf-snow/tf-all.  

my $snow_file = @ARGV[0] || die "$! \n usage: perl programName snowFile ContrastFile w(ord)|l(emma)";

my $contrast_file = @ARGV[1] || die "$! \n usage: perl programName snowFile ContrastFile w(ord)|l(emma)";

my $param = @ARGV[2] || die "$! \n usage: perl programName snowFile ContrastFile w(ord)|l(emma)";

my $punct = '(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*|\+)';

my $bound = @ARGV[3]; #порог отсечения

my %tf_snow; #abs.freq in snow_collection, hash key=word, value=freq
my %tf_all; #abs. freq of snow_word in contrast_collection
my %metric; #slightly tfidf based metric. tf-snow/tf-all
my $res_file = $snow_file."_res_".$param;
my $word;
my $word2;
my %tmp;

open(IN, "<$snow_file") || die $!;
binmode (IN, ":encoding(utf-8)");

while (<IN>){ #count tf-snow
	my @variants = split;
	chomp;
	
	if ($param eq "w") {	
         	$word = $variants[0]; #работаем со словоформами
        }else {	
         	$word = $variants[1]; #работаем с леммами
	}
	unless ($word =~ $punct){#если не содержит знаки препинания, добавляется
		$tf_snow{$word}++;
		#$tmp{$word} = 1;	
	}

}
close IN;

open (IN2,"<$contrast_file") || die $!;
binmode (IN2, ":encoding(utf-8)");

while (<IN2>){ #count tf-all
	my @variants = split;
	chomp;
	if ($param eq "w") {	
         	$word2 = $variants[0]; #работаем со словоформами
        }else {	
         	$word2 = $variants[1]; #работаем с леммами
	}
	unless ($word2 =~ $punct){#если не содержит знаки препинания, то далее
		if (exists($tf_snow{$word2})){#считаем частоты только для тех слов, что есть в снежной коллекции
			$tf_all{$word2}++;
		}
	}
}
close IN2;

print "open OUT " . $res_file . "\n"; #печать текущего состояния в консоль
open (OUT, ">$res_file") || die $!; #запись в выходной файл
binmode (OUT, ":encoding(utf-8)");

print "count metric"; #текущее состояние   
foreach $word (keys(%tf_snow)) {
	if ($tf_snow{$word} > $bound && $word !~ /[A-Za-z]/){
       		$metric{$word} = $tf_snow{$word}/$tf_all{$word}; #подсчёт метрики
	}
}

print OUT "snow-слово" . "\t\t" . "tf-snow/tf-contrast" . "\t\t" . "tf-snow" . "\t" . "tf-contrast" . "\n"; #верхняя строка выходного файла
   foreach $word (sort { $metric{$b} <=> $metric{$a} || $a cmp $b} keys %metric ) {
	print OUT $word . "\t" . $metric{$word} . "\t" . $tf_snow{$word} . "\t" . $tf_all{$word} . "\n";   
 }#сортировка по значениям нашей метрики и печать в выходной файл
   %tf_snow = {}; #обнуление массива tf_snow
   %tf_all = {}; #обнуление массива tf_all
   %metric = {}; #обнуление массива metric

close OUT;
