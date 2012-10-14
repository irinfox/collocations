#!/usr/bin/perl
use strict;
use utf8;
use Getopt::Std;

my %MI;
my %opts;
getopts('f:h:n:b:', \%opts);

#help
if (!$opts{'f'} && !$opts{'h'} && !$opts{'n'}){
	print "Usage:\n $0 -f FILE \t file with bigrams\n $0 -h FILE \t file with oneword grams \n -n numb \tamount of words in collection \n Additional parametr: \n -b numb \t frequence bound (don't print below this bound)\n";
	exit;
}

# f - теоретически из конвейера, h, n - из БД с нач. файлом и его частотниками; b - введено пользователем.

my $N_words = $opts{'n'};

#запуск программ MI и t-score. Для успешной работы программ, им нужно передать ссылку на hash с частотами словосочетаний и ссылку на hash с частотами лексем, а также границу отсечения по частоте (MI считается для наиболее частотных)

my %bi = readFile($opts{'f'});
my %one = readFile($opts{'h'});
my %MI_colloc = MI(\%bi, \%one, \$opts{'b'});
print_Metric (\%bi, \%MI_colloc);

#%MI_colloc = {};
#%p5 = {};

###################################################################
sub log2 {
 my $n = shift;
 return log($n)/log(2);
}
#подпрограмма для логарифма. Переход к основанию 2 от е

########################################
sub MI {
  # Подпрограма для подсчета mutual information
  # Ей надо передать ссылку на хэш с частотами словосочетаний и ссылку на хэш с частотами лексем,
  # а также границу отсечения по частоте (MI считается для наиболее частотных)

  my ($colloc_freq, $word_freq, $bound) = @_;
  my %MI;
  my $denominator;
  my @word;
  my $logN = log2($N_words);
 # $bound = $bound / $N;
  print "count MI $colloc_freq, $word_freq, $bound \n";

  foreach my $colloc (keys %$colloc_freq) {

   if ($$colloc_freq{$colloc} > $bound) { # Отсечение по частоте
 	@word = split (/\t/, $colloc);

   	# Считаем произведение частот для знаменателя
   	$denominator = 1;
 	foreach my $word (@word) {
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

#################################
 sub print_Metric{
	my ($colloc_freq, $Metric) = @_;

 	binmode(STDOUT, ":encoding(utf8)");
	print "colloc \t\t\t freq \t MI \n\n";
  	 
	foreach my $colloc (sort { $$Metric{$b} <=> $$Metric{$a} || $a cmp $b} keys %$Metric ) {
    		print $colloc . "\t" . $$colloc_freq{$colloc} . "\t" . $$Metric{$colloc} . "\n";
   	}
}

############################################################

sub readFile{
	open my $file, $_[0] or die "Failed to open file: $!";
    	binmode ($file, ":encoding(utf8)");
	my %freqDict;
        while (<$file>) {
	       my ($first, $last) = split (/\t/, $file); #нужно разбить строку по табам так, чтоб слова (nграммы) до таба стали ключами словаря, а слова после таба - значениями. 
		$freqDict{$first} = $last;	
       		 
        }
	return %freqDict;
	close $file;
}

###############################################################

