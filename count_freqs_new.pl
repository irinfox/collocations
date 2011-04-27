use utf8;
use Encode;

binmode(STDOUT, ":encoding(utf8)");

 $file_name = @ARGV[0] || die "$! \n usage: FILE_NAME w|l";

 $param = @ARGV[1] || die "$! \n usage: FILE_NAME w(ord)|l(emma)";
#переменные для первого (лемматизированный файл) и второго (словоформы, лексемы) параметров

#($file_name, $param) = @ARGV || die "$! \n usage: FILE_NAME 0|1";

$main_output = $file_name . "_" . $param;


print "read file $file_name \n";

open (IN, "<$file_name") || die $!;
#создание частотных словарей для 1-5грамм
binmode (IN, ":encoding(utf8)");

$mln = 0;

while (<IN>) {

$N++;

#print $mln . "\t" . $N . "\n";

@variants = split;



chomp;

$x_4 = $x_3;
$x_3 = $x_2;
$x_2 = $x_1;
$x_1 = $x; 
if ($param eq "w") {
$x = $variants[0]; 
} else {
$x = $variants[1];
 }

#if ($x =~ /\W/ || $x_1 =~ /\W/ || $x_2 =~ /\W/ || $x_3 =~ /\W/ || $x_4 =~ /\W/) {next;}
#if ($x =~ /[a-zA-Z]/ || $x_1 =~ /[a-zA-Z]/ || $x_2 =~ /[a-zA-Z]/) {next;}

my $punct = '(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*|\+)';

unless ($x =~ /$punct/){

#print "x: $x \n";
#если переменная не содержит знаки препинания, осуществляется дальнейшая обработка
$N_words++;

$p1{$x}++;

unless ($x_1 =~ /$punct/){

$bi = $x_1 . "\t" . $x;
$p2{$bi}++;



unless ($x_2 =~ /$punct/){

$tri = $x_2 . "\t" . $x_1 . "\t" . $x;
$p3{$tri}++;


unless ($x_3 =~ /$punct/){
$four = $x_3 . "\t" . $x_2 . "\t" . $x_1 . "\t" . $x;
$p4{$four}++;


unless ($x_4 =~ /$punct/){
$five = $x_4 . "\t" . $x_3 . "\t" . $x_2 . "\t" . $x_1 . "\t" . $x;
$p5{$five}++;

}
}
}
}
}

#print "*";
}

close IN;

$logN = log2($N_words);
#логарифм от всех словоупотреблений
print "\n N: $N\n";
print "N_words: $N_words\n";
print "print freqs \n";


###########################################
print "print words freq \n";
$out = "_1_" . $main_output;
open (OUT, ">$out");

print OUT "word \t\t freq \t freq_rel \t ipm \n\n"; 

binmode (OUT, ":encoding(utf8)");
foreach $x ( sort {$p1{$b} <=> $p1{$a} || $a cmp $b} keys(%p1)) {
 $freq_rel = ( $p1{$x} )/$N_words;
 $freq_rel = sprintf("%.6f", $freq_rel);
 $ipm = $freq_rel * 1000000;
 print OUT $x . "\t\t" . $p1{$x} . "\t" . $freq_rel . "\t" . $ipm . "\n";
}
close OUT;
#%p1 = ();
#частотный словарь с абс., относител. частотами и ipm для однословных конструкций с сортировкой по значениям


###########################################
print "print 2_words freq \n";
$out =  "_2_" . $main_output;
open (OUT, ">$out");

print OUT "colloc \t\t\t freq \t freq_rel \t ipm \n\n"; 

binmode (OUT, ":encoding(utf8)");
foreach $bi (sort {$p2{$b} <=> $p2{$a} || $a cmp $b} keys(%p2)) {
 $freq_rel = ( $p2{$bi} )/$N_words;
 $freq_rel = sprintf("%.6f", $freq_rel);
 $ipm = $freq_rel * 1000000;
 print OUT $bi . "\t\t" . $p2{$bi} . "\t" . $freq_rel . "\t" . $ipm . "\n"; 
}
close OUT;
#такой же, как и выше, частотный словарь для биграмм
print "2_MI  2_TS \n";

%MI_colloc = MI( \%p2, \%p1, 3);
print_MI (\%p2, \%MI_colloc, "_MI_2_$main_output");
%TS_colloc = TScore( \%p2, \%p1, 3);
print_TS (\%p2, \%TS_colloc, "_TS_2_$main_output");
#запуск программ MI и t-score. Для успешной работы программ, им нужно передать ссылку на hash с частотами словосочетаний и ссылку на hash с частотами лексем, а также границу отсечения по частоте (MI считается для наиболее частотных)
%TS_colloc = {};
%MI_colloc = {};
%p2 = {};
#Обнуление hash'a для освобождения памяти

############################################
print "print 3_words freq \n";
$out = $name . "_3_" . $main_output;
open (OUT, ">$out");


print OUT "colloc \t\t\t\t freq \t freq_rel \t ipm \n\n"; 


binmode (OUT, ":encoding(utf8)");
foreach $tri (sort {$p3{$b} <=> $p3{$a} || $a cmp $b} keys(%p3)) {

 $freq_rel = ( $p3{$tri} )/$N_words;
 $freq_rel = sprintf("%.6f", $freq_rel);
 $ipm = $freq_rel * 1000000;
 print OUT $tri . "\t\t" . $p3{$tri} . "\t" . $freq_rel . "\t" . $ipm . "\n"; 
}
close OUT;
#всё то же самое для 3грамм
#%p3 = ();

print "3_MI \n";

%MI_colloc = MI( \%p3, \%p1, 3);
print_MI (\%p3, \%MI_colloc, "_MI_3_$main_output");

%MI_colloc = {};
%p3= ();



###############################################
print "print 4_words freq \n";
$out = $name . "_4_" . $main_output;
open (OUT, ">$out");


print OUT "colloc \t\t\t\t\t freq \t freq_rel \t ipm \n\n"; 


binmode (OUT, ":encoding(utf8)");
foreach $four (sort {$p4{$b} <=> $p4{$a} || $a cmp $b} keys(%p4)) {
 $freq_rel = ( $p4{$four} )/$N_words;
 $freq_rel = sprintf("%.6f", $freq_rel);
 $ipm = $freq_rel * 1000000;
 print OUT $four . "\t\t" . $p4{$four} . "\t" . $freq_rel . "\t" . $ipm . "\n"; 

}
close OUT;
#частотный словарь для 4грамм
print "4_MI \n";

%MI_colloc = MI( \%p4, \%p1, 3);
print_MI (\%p4, \%MI_colloc, "_MI_4_$main_output");

%MI_colloc = {};
%p4= ();


#############################################

print "print 5_words freq \n";
$out = $name . "_5_" . $main_output;
open (OUT, ">$out");

print OUT "colloc \t\t\t\t\t\t freq \t freq_rel \t ipm \n\n"; 

binmode (OUT, ":encoding(utf8)");
foreach $five (sort {$p5{$b} <=> $p5{$a} || $a cmp $b} keys(%p5)) {

 $freq_rel = ( $p5{$five} )/$N_words;
 $freq_rel = sprintf("%.6f", $freq_rel);
 $ipm = $freq_rel * 1000000;
 print OUT $five . "\t\t" . $p5{$five} . "\t" . $freq_rel . "\t" . $ipm . "\n"; 
}
close OUT;
#частотный словарь для 5грамм
print "5_MI \n";

%MI_colloc = MI( \%p5, \%p1, 3);
print_MI (\%p5, \%MI_colloc, "_MI_5_$main_output");

%MI_colloc = {};
%p5 = {};

###################################################

sub log2 {
 my $n = shift;
 return log($n)/log(2);
}
#подпрограмма для логарифма. Переход к основанию 2 от е


sub MI {
  # Подпрограма для подсчета mutual information
  # Ей надо передать ссылку на хэш с частотами словосочетаний и ссылку на хэш с частотами лексем,
  # а также границу отсечения по частоте (MI считается для наиболее частотных)

  my ($colloc_freq, $word_freq, $bound) = @_;
  my %MI;

 # $bound = $bound / $N;
  print "count MI $colloc_freq, $word_freq, $bound \n";



  foreach $colloc (keys %$colloc_freq) {


   if ($$colloc_freq{$colloc} > $bound) { # Отсечение по частоте
 	@word = split (/\t/, $colloc);

   	# Считаем произведение частот для знаменателя
   	$denominator = 1;
 	foreach $word (@word) {
	  chomp $word;


	  #if ($word =~ /[A-Z]|[a-z]/) {
	   #$denominator = 0;
	   #}else{
	  $denominator = $denominator * $$word_freq{$word};
         #}  
    }


 	# Собственно MI
 	   if ($denominator == 0) {next;}
           if ($$colloc_freq{$colloc} == 0 || $$colloc_freq{$colloc} <= 0) {next;}
 		$MI{$colloc} = log2($$colloc_freq{$colloc}/$denominator) + $logN;

  }
 }
 return %MI;
}


sub print_MI {
 # Подпрограмма для печати MI
 # Ей передается сылка на хэш с частотами и ссылка на хэш с MI,
 # а также имя выходного файла

 my ($colloc_freq, $MI, $output) = @_;

  print "print MI $colloc_freq, $MI, $output \n";

   open (LIST, ">$output");

   binmode(LIST, ":encoding(utf8)");

   print LIST "colloc \t\t\t freq \t MI \n\n";
   
   foreach $colloc (sort { $$MI{$b} <=> $$MI{$a} || $a cmp $b} keys %$MI )
   {
    print LIST $colloc . "\t" . $$colloc_freq{$colloc} . "\t" . $$MI{$colloc} . "\n";
   }
   close LIST;

}



sub TScore {
  # Подпрограма для подсчета t-score
  # Ей надо передать ссылку на хэш с частотами словосочетаний и ссылку на хэш с частотами лексем,
  # а также границу отсечения по частоте (MI считается для наиболее частотных)

  my ($colloc_freq, $word_freq, $bound) = @_;
  my %TS;

 # $bound = $bound / $N;

 print "count TS $colloc_freq, $word_freq, $bound \n";



  foreach $colloc (keys %$colloc_freq) {


   if ($$colloc_freq{$colloc} > $bound) { # Отсечение по частоте
 	@word = split (/\t/, $colloc);
    
    
   
   $pr = 1;
   
   foreach $word (@word) {  
    $pr = $pr * $$word_freq{$word};  
   }
   #print "COLLOC: $colloc pr: $pr \n";

   $pr_N = $pr / $N_words;

   #print "COLLOC: $colloc pr: $pr N: $N pr_N: $pr_N \n";

   $sq = sqrt($$colloc_freq{$colloc});

   # print "COLLC: $colloc FREQ: $$colloc_freq{$colloc} SQ: $sq \n";

   $TS{$colloc} = $sq - ($pr_N / $sq);

 } 
 } 
 return %TS;
}



sub print_TS {
 # Подпрограмма для печати t-score
 # Ей передается сылка на хэш с частотами и ссылка на хэш с MI,
 # а также имя выходного файла

 my ($colloc_freq, $TS, $output) = @_;

 print "print TS $colloc_freq, $TS, $output \n";

   open (LIST, ">$output");

   binmode(LIST, ":encoding(utf8)");

   print LIST "colloc \t\t\t freq \t t-score \n\n";

   foreach $colloc (sort { $$TS{$b} <=> $$TS{$a} || $a cmp $b} keys %$TS )
   {
    print LIST $colloc . "\t" . $$colloc_freq{$colloc} . "\t" . $$TS{$colloc} . "\n";
   }
   close LIST;

}
