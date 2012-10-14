#программа считает абс. частоты, MI и t-score для 1-5 грамм, выводит на печать только 1-2граммы. Работает с файлом через запись его в массив.

use utf8;
use Encode;
use File::Basename;

binmode(STDOUT, ":encoding(utf8)");

$file_name = shift @ARGV || die "you should input file$!"; 
$main_output = $file_name;
#объявление переменных для входного и выходного файлов



print "main_output $main_output \n";
  
print "In God We Trust \n";

sub log2 {
 my $n = shift;
 return log($n)/log(2);
}
#подпрограмма для log, переход от основания e к основанию 2

 print "read file $file_name \n";

open (IN, "<$file_name");

binmode(IN, ":encoding(utf8)");

@list = <IN>;
close IN;
#Запись входного файла в массив

$N = @list; # число словоупотреблений
$logN = log2($N);

# Заранее выделяем память под хэш (быстродействие)
#keys(%count) = $N;
#keys(%count_colloc) = $N;
#keys(%MI) = 2000;
#keys(%TS) = 2000;

###Построение частотных словарей
# print "create word freqs \n";

chomp @list;

for ($i=0; $i <= $N; $i++) {
 chomp $list[$i];
 $count{$list[$i]}++;
}

# foreach $word (%count) {
# $count{$word} = $count{$word} / $N;
# }

# Печать частотного словаря
  print "print word freqs";
 $output =  "1_" . $main_output;
 open (LIST, ">$output");

binmode(LIST, ":encoding(utf8)");

 foreach $word (sort { $count{$b} <=> $count{$a} || $a cmp $b} keys %count )
{
  print LIST $word . "\t" . $count{$word} . "\n";

}
 print "\n" . $N . "\n";
close LIST;


# Двухсловные
 print "create 2-word freqs \n";
for ($i=0; $i <= $N-1; $i++) {
 	$colloc = $list[$i] . "\t" . $list[$i+1];
 	$count_colloc{$colloc}++;
}

# Печать частотного словаря для коллокаций
 
$output = "2_" . $main_output;
open (LIST, ">$output");

binmode(LIST, ":encoding(utf8)");

foreach $colloc (sort { $count_colloc{$b} <=> $count_colloc{$a} || $a cmp $b} keys %count_colloc ) 
{ 
  print LIST $colloc . "\t" . $count_colloc{$colloc} . "\n";
}
print "\n" . $N . "\n";
close LIST;



# foreach $colloc (%count_colloc) {
# $count_colloc{$colloc} = $count_colloc{$colloc} / $N;
# }

%MI_colloc = MI( \%count_colloc, \%count, 0);
print_MI (\%count_colloc, \%MI_colloc, "2_MI_$main_output");

%TS_colloc = TScore( \%count_colloc, \%count, 0);
print_TS (\%count_colloc, \%TS_colloc, "2_TS_$main_output");
%TS_colloc = {};
%count_colloc = {};
%MI_colloc = {};

exit;

# Трехсловные
 print "create 3-word freqs \n";
for ($i=0; $i <= $N-2; $i++) {
 	$colloc = $list[$i] . "\t" . $list[$i+1] . "\t" . $list[$i+2];
 	$count_colloc{$colloc}++;
}

# foreach $colloc (%count_colloc) {
# $count_colloc{$colloc} = $count_colloc{$colloc} / $N;
# }

%MI_colloc = MI( \%count_colloc, \%count, 3);
print_MI (\%count_colloc, \%MI_colloc, "3_MI_$main_output");
%TS_colloc = TScore( \%count_colloc, \%count, 3);
print_TS (\%count_colloc, \%TS_colloc, "3_TS_$main_output");
%TS_colloc = {};
%count_colloc = {};
%MI_colloc = {};

# Четырехсловные
 print "create 4-word freqs \n";
for ($i=0; $i <= $N-3; $i++) {
 	$colloc = $list[$i] . "\t" . $list[$i+1] . "\t" . $list[$i+2] . "\t" . $list[$i+3];
 	$count_colloc{$colloc}++;
}

# foreach $colloc (%count_colloc) {
# $count_colloc{$colloc} = $count_colloc{$colloc} / $N;
# }

%MI_colloc = MI( \%count_colloc, \%count, 3);
print_MI (\%count_colloc, \%MI_colloc, "4_MI_$main_output");
%TS_colloc = TScore( \%count_colloc, \%count, 3);
print_TS (\%count_colloc, \%TS_colloc, "4_TS_$main_output");
%TS_colloc = {};
%count_colloc = {};
%MI_colloc = {};

# Пятихсловные
 print "create 5-word freqs \n";
for ($i=0; $i <= $N-4; $i++) {
 	$colloc = $list[$i] . "\t" . $list[$i+1] . "\t" . $list[$i+2] . "\t" . $list[$i+3] . "\t" . $list[$i+4];
 	$count_colloc{$colloc}++;
}

# foreach $colloc (%count_colloc) {
# $count_colloc{$colloc} = $count_colloc{$colloc} / $N;
#}

%MI_colloc = MI( \%count_colloc, \%count, 3);
print_MI (\%count_colloc, \%MI_colloc, "5_MI_$main_output");
%TS_colloc = TScore( \%count_colloc, \%count, 3);
print_TS (\%count_colloc, \%TS_colloc, "5_TS_$main_output");
%TS_colloc = {};
%count_colloc = {};
%MI_colloc = {};

print "DONE $file_name \n";

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

   $pr_N = $pr / $N;

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

   foreach $colloc (sort { $$TS{$b} <=> $$TS{$a} || $a cmp $b} keys %$TS )
   {
    print LIST $colloc . "\t" . $$colloc_freq{$colloc} . "\t" . $$TS{$colloc} . "\n";
   }
   close LIST;

}
