use utf8;
use Encode;
use File::Basename;

binmode(STDOUT, ":encoding(utf8)");

$file_name = shift @ARGV || die "you should input file$!";
$main_output = $file_name;




print "main_output $main_output \n";
  
print "In God We Trust \n";

sub log2 {
 my $n = shift;
 return log($n)/log(2);
}

 print "read file $file_name \n";

open (IN, "<$file_name");

binmode(IN, ":encoding(utf8)");

@list = <IN>;
close IN;

$N = @list; # число словоупотреблений
$logN = log2($N);


chomp @list;

for ($i=0; $i <= $N; $i++) {
 chomp $list[$i];
 $count{$list[$i]}++;
}



# Двухсловные
 print "create 2-word freqs \n";
for ($i=0; $i <= $N-1; $i++) {
 	$colloc = $list[$i] . "\t" . $list[$i+1];
 	$count_colloc{$colloc}++;
}

# foreach $colloc (%count_colloc) {
# $count_colloc{$colloc} = $count_colloc{$colloc} / $N;
# }


%MI_colloc = MI( \%count_colloc, \%count, 3);

%TS_colloc = TScore( \%count_colloc, \%count, 3);

$output = "2_TSMI_all_" . $main_output;

open (LIST, ">$output");
binmode(LIST, ":encoding(utf8)");
print LIST "коллокация" . "\t\t" . "частота" . "\t" . "MI" . "\t" . "t-score" . "\n"; 

$i = 0;

# foreach $colloc (sort { $MI_colloc{$b} <=> $MI_colloc{$a} || $a cmp $b} keys %MI_colloc) {
foreach $colloc (sort { $TS_colloc{$b} <=> $TS_colloc{$a} || $a cmp $b} keys %TS_colloc) {
#if ($i == 30) {
  if ($TS_colloc{$colloc}) { 
	# $i = 0;
 	 print LIST $colloc . "\t" . $count_colloc{$colloc} . "\t" . $MI_colloc{$colloc} . "\t" . $TS_colloc{$colloc} . "\n";
 # }else{
  # $i = 29;
  #}
}
#$i++;
}
close LIST;

print "DONE \n";



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

	  if ($word =~ /[A-Z]|[a-z]/) {
	   $denominator = 0;
	   }else{
	  $denominator = $denominator * $$word_freq{$word};
         }  
    }


 	# Собственно MI
 	   if ($denominator == 0) {next;}
           if ($$colloc_freq{$colloc} == 0 || $$colloc_freq{$colloc} <= 0) {next;}
 		$MI{$colloc} = log2($$colloc_freq{$colloc}/$denominator) + $logN;

  }
 }
 return %MI;
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

   	# Считаем произведение частот для числителя
   	$numirator = 1;
 	foreach $word (@word) {


	  chomp $word;
      if ($word =~ /[А-Я]|[а-я]|Ё|ё/) {
	  $numirator = $numirator * $$word_freq{$word};
	 }else {
	  $numirator = 0;
	}
    }

   if ($numirator == 0) {next;}
 	# Собственно TS
 		$TS{$colloc} = ($$colloc_freq{$colloc} - $numinator/$N)/sqrt($$colloc_freq{$colloc});
  }
 }
 return %TS;
}


