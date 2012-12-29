#!/usr/bin/perl
use strict;
use utf8;
use Getopt::Std;

my %MI;
my %opts;
getopts('f:h:n:b:', \%opts);

#help
if (!$opts{'f'} && !$opts{'h'}){
	print "Usage:\n $0 -f FILE \t file with Ngrams\n $0 -h FILE \t file with oneword grams \n Additional parametr: \n -b numb \t frequence bound (don't print below this bound)\n";
	exit;
}

# f - теоретически из конвейера, h, n - из БД с нач. файлом и его частотниками; b - введено пользователем.

#my $N_words = $opts{'n'};

#запуск программ MI и t-score. Для успешной работы программ, им нужно передать ссылку на hash с частотами словосочетаний и ссылку на hash с частотами лексем, а также границу отсечения по частоте (MI считается для наиболее частотных)

my %bi = readFile($opts{'f'});
my %one = readFile($opts{'h'});

my $sum = 0;
   foreach my $value (values(%one)){
   #print $value;
   $sum += $value; 
}
my $N_words = $sum;
print $N_words;

my $bu;
if (!$opts{'b'}){$bu = 2;}
else {$bu = $opts{'b'}}

my %MI_colloc = MI(\%bi, \%one, $bu);

binmode(STDOUT, ":encoding(utf-8)");
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
  #print "count MI $colloc_freq, $word_freq, $bound \n";

  foreach my $colloc (keys %$colloc_freq) {

   if ($$colloc_freq{$colloc} > $bound) { # Отсечение по частоте
 	@word = split (/\t/, $colloc);
	#print "colloc: ".$colloc." colloc_freq: ".$$colloc_freq{$colloc}."\n";
   	# Считаем произведение частот для знаменателя
   	$denominator = 1;
 	foreach my $word (@word) {
	  chomp $word;
	#print "here: ".$word."\n";

	  $denominator = $denominator * $$word_freq{$word};
	#print "denom: ".$denominator."\n";
	#print "word_freq: ".$$word_freq{$word}."\n";
    }


 	# Собственно MI
 	   if ($denominator == 0) {next;}
           if ($$colloc_freq{$colloc} == 0 || $$colloc_freq{$colloc} <= 0) {next;}
 #	print $$colloc_freq($colloc)."\n";
	$MI{$colloc} = log2($$colloc_freq{$colloc}/$denominator) + $logN;
#	print "colloc: ".$colloc." MI: ".$MI{$colloc}."\n";
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
#	open (FILE, $_[0]);
    open my $file, $_[0] or die "cannot open file: $!";
    binmode ($file, ":encoding(utf8)");
	my $x;
 #   	binmode (FILE, ":encoding(utf8)");
 	binmode(STDOUT, ":encoding(utf8)");
	my %freqDict;
        while (<$file>) {
	#	print $_."\n";
               if ($_ =~ m/colloc\t\t\t\t\t\tfreq/){next;}
	       else {
		chomp;
		my ($first, $last) = split (/\t{2}/, $_); #нужно разбить строку по табам так, чтоб слова (nграммы) до таба стали ключами словаря, а слова после таба - значениями. 
		$freqDict{$first} = $last;	
       	#	print $first."\t".$last;	 
        	}
	}
	return %freqDict;
	close $file;
}

###############################################################

