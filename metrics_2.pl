use utf8;
use Encode;
use File::Basename;

binmode(STDOUT, ":encoding(utf8)");

$file_1 = shift @ARGV || die "you should input file_1, file_2 and result_file$!";
$file_2 = shift @ARGV || die "you should input file_1, file_2 and result_file$!";
$result_file = shift @ARGV || die "you should input file_1, file_2 and result_file$!";

print "read words $file_1\n";

open (ONE, "$file_1");
binmode(ONE, ":encoding(utf8)");

while (<ONE>) {
chomp;
($word, $freq) = split;
$p1{$word} = $freq;
$N = $N+$freq;
}

sub log2 {
 my $n = shift;
 return log($n)/log(2);
}
close ONE;
$logN = log2($N);

print "N: $N log2N: $logN \n";

print "read colloc $file_2\n";

open (BI, "$file_2");
binmode(BI, ":encoding(utf8)");

while (<BI>) {
chomp;
($word1, $word2, $freq) = split;
  if ($freq < 40) {last;} 
 $colloc = $word1 . "\t" . $word2;
 # print "colloc: $colloc freq: $freq \n";
 $p2{$colloc} = $freq;
}

close BI;


%MI_colloc = MI( \%p2, \%p1, 0);
print_MI (\%p2, \%MI_colloc, "2_MI_$result_file");
%MI_colloc = ();

%TS_colloc = TScore( \%p2, \%p1, 0);
print_TS (\%p2, \%TS_colloc, "2_TS_$result_file");
%TS_colloc = ();
%p2 = ();
%p1 = ();

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

   	# Считаем произведение частот для числителя
   	$numirator = 1;
 	foreach $word (@word) {


	  chomp $word;
      if ($word =~ /[A-Я]|[а-я]|Ё|ё/) {
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
