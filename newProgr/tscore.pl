#!/usr/bin/perl
use strict;
use utf8;
use Getopt::Std;

my %TS;
my %opts;
getopts('f:h:n:b:', \%opts);

#help
if (!$opts{'f'} && !$opts{'h'} && !$opts{'n'}){
	print "Usage:\n $0 -f FILE \t file with bigrams\n $0 -h FILE \t file with oneword grams \n -b numb \t frequence bound (don't print below this bound)\n";
	exit;
}

#my $N_words = $opts{'n'};

my %bi = readFile($opts{'f'});
my %one = readFile($opts{'h'});
#my $N_words = count_words(\%one);

my $sum = 0;
   foreach my $value (values(%one)){
   #print $value;
   $sum += $value; 
}
my $N_words = $sum;

my $bu;
if (!$opts{'b'}){$bu = 2;}
else {$bu = $opts{'b'}}

my %TS_colloc = TScore(\%bi, \%one,$bu);
print_Metric (\%bi, \%TS_colloc);

#запуск подрограмм подсчёта и печати t-score. Для успешной работы программ, им нужно передать ссылку на hash с частотами словосочетаний и ссылку на hash с частотами лексем, а также границу отсечения по частоте (MI считается для наиболее частотных)
#%TS_colloc = {};
#%p2 = {};
#Обнуление hash'a для освобождения памяти

sub TScore {
  # Подпрограма для подсчета t-score
  # Ей надо передать ссылку на хэш с частотами словосочетаний и ссылку на хэш с частотами лексем,
  # а также границу отсечения по частоте (MI считается для наиболее частотных)

  my ($colloc_freq, $word_freq, $bound) = @_;
  my @word;
  my ($pr, $pr_N, $sq);	
 # $bound = $bound / $N;

  foreach my $colloc (keys %$colloc_freq) {
   if ($$colloc_freq{$colloc} > $bound) { # Отсечение по частоте
 	@word = split (/\t/, $colloc);
   
   $pr = 1;
   
   foreach my $word (@word) {  
    $pr = $pr * $$word_freq{$word};  
   }
   $pr_N = $pr / $N_words;
   $sq = sqrt($$colloc_freq{$colloc});

   $TS{$colloc} = $sq - ($pr_N / $sq);

 } 
 } 
 return %TS;
}

##############################################
sub print_Metric {
 # Подпрограмма для печати метрик MI и t-score
 # Ей передается сылка на хэш с частотами и ссылка на хэш с метриками,
 # а также имя выходного файла

 my ($colloc_freq, $Metric) = @_;

	#print "print TS $colloc_freq, $Metric \n";

   #	open (LIST, ">$output");

   	binmode(STDOUT, ":encoding(utf8)");
 	print  "colloc \t\t\t freq \t t-score \n\n";
  	
	 foreach my $colloc (sort { $$Metric{$b} <=> $$Metric{$a} || $a cmp $b} keys %$Metric ) {
    		print  $colloc . "\t" . $$colloc_freq{$colloc} . "\t" . $$Metric{$colloc} . "\n";
   	}
   	#close LIST;

}

#####################################
sub readFile{
	open my $file, $_[0] or die "Failed to open file: $!";
    	binmode ($file, ":encoding(utf8)");
	my %freqDict;
        while (<$file>) {
               if ($_ =~ m/colloc\t\t\t\t\t\tfreq/){next;}
	       else {
		chomp;
		my ($first, $last) = split (/\t{2}/, $_); #нужно разбить строку по табам так, чтоб слова (nграммы) до таба стали ключами словаря, а слова после таба - значениями. 
		$freqDict{$first} = $last;		
        	}
	}
	return %freqDict;
	close $file;
}

###############################################################

