use utf8;
use Encode;
use Getopt::Std;

binmode(STDOUT, ":encoding(utf8)");

my $punct = '(\=|\>|\<|\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*|\+)';
my @variants; #arrays for work with input file(s)
my @vars;
#my $x=-1;
my %dict; #frequency dictionary

#options
my %opts;
getopts('cdilpwrf:D:n:b:', \%opts);

#usage
if(!$opts{'f'} && !$opts{'D'}){
	print "\n\nUsage:\n$0 -f FILE (read from FILE) \n
						$0 -D DIR (read from DIR)\n
	 Additional parameters:\n -n \t nGram (build freqDict for nGram) \n 
						      -w \t freqs for WORDS \n 
						      -r \t count RELATIVE freqs \n 
                              -b \t BOUND (print words with top-freqs over BOUND)\n 
						      -l\t make lowercase\n 
						      -p\t discard punctuation\n
						      -i \t count ipm \n 
						      -c \t cyrillic only (discard latin words)\n 
						      -d \t discard digits\n 
		DEFAULT CASE:\n 1-word absolute frequency dictionary for lemma with punctuation, latin words and both cases (upper and lower), without any bound etc.\n\n";  
	exit;
}

#read from directory or file
if ($opts{'D'}){
    opendir(DIR, $opts{'D'}) || "Failed to open directory: $!";
    while (defined($f = readdir(DIR))){
	#	print "current: $f";
		if ($f eq "." || $f eq ".."){next;}
		readFile("<$opts{'D'}/$f");
	} 
    closedir(DIR);	
}else{
	readFile($opts{'f'});
}

#количество слов (для относительных частот)
my	$N_words = $#vars + 1;

#создание частотных словарей для 1-5грамм
if ($opts{'n'}){
	count_freqs($opts{'n'});
}
if (!$opts{'n'}) {
	count_freqs(1);
}

print_freqs();

##############################################################

#reading file
sub readFile{
    open $file, $_[0] or die "cannot open file: $!";
    binmode ($file, ":encoding(utf8)");
	my $x;
        while (<$file>) {
            $N++;
	        chomp;
	        @variants = split;#разбитая по пробелам строка из аот-файла. 
	        if ($opts{'w'}) {
             #     $x++;
				$x = $variants[0];
	        } else {
				$x = $variants[1];
	        }
			
		if ($opts{'l'}){
	           $x = lc($x);         
            	}
		if ($opts{'c'}){
			if ($x =~ /[a-zA-Z]/){next;}
		}
            
                if ($opts{'p'}){
			if ($x =~ /$punct/){next;}
		}
			
                if ($opts{'d'}){
			if ($x =~ /[0-9]/){next;}
		}
        
	  	 push (@vars, $x); #нужно иначе обновлять значение
					
			#$N_words = 
        }
	close $file;
}

###############################################################

#общая подпрограмма для подсчёта частот
sub count_freqs{
	L:for my $i($_[0]-1..$#vars){ #$_[0] берёт переданное число
		my @t=""; 
		$t="";
	   	for $j($i-($_[0]-1)..$i){
	#		print "for j: $vars[$j]\n";
			if($vars[$j] eq ''){
				next L;			
			}
			else {
				push(@t,$vars[$j]);
			}
	       	}
		for $j(0..$#t){
			if ($j < 1){next;}
			if ($j == 1){$t=$t[$j];}
			if ($j > 1){$t=$t."\t".$t[$j];}		
		}
		#$t = join('    ', @t);
		$dict{$t}++;
	}
	#print "$t --> $dict{$t}";
	#for $s(sort{$dict{$b}<=>$dict{$a}}keys(%dict)){
	#	print  $s."\t".$dict{$s}."\n";
	#}
}

###########################################

#print $N_words."\n";
sub print_freqs{
	#подпрограмма для печати частот
	my $freq_rel, $ipm;
	my $print_str = '';
	if ($opts{'r'}){
		$print_str = $print_str."\t\t freq_rel"; 
	}
	if ($opts{'i'}){ 
		$print_str = $print_str."\t\t ipm"; 
	}
	print "colloc\t\t\t\t\t\tfreq".$print_str."\n\n"; 
	
	my $i = 0;
	for $k(sort{$dict{$b}<=>$dict{$a}}keys(%dict)){
		my $str = '';
		$i++;
	 	$freq_rel = ($dict{$k})/$N_words;#to count ipm without opts -r
	 	$freq_rel = sprintf("%.6f", $freq_rel);
		if ($opts{'r'}){
			$str = $str."\t".$freq_rel;
		}
		if ($opts{'i'}){ 
			$ipm = $freq_rel * 1000000;
			$str = $str."\t".$ipm;
		}
		if ($opts{'b'}){
			if ($i > $opts{'b'}){last;}
		}	
		print $k."\t\t".$dict{$k}.$str."\n";
	}	
}

###########################################
#print "print 2_words freq \n";

#$out =  "_2_" . $main_output;
#print_freq(\$bi,\%p2, "$out");

#такой же, как и выше, частотный словарь для биграмм

#%p2 = {};
###########################################

	
#подпрограмма для печати частот
	#my $freq_rel, $ipm;
	#my ($Ngram, $freqDict,$output) = @_;
	
	#open (OUT, ">$output");
	#print OUT "colloc \t\t\t\t\t\t freq \t freq_rel \t ipm \n\n"; 
	#binmode (OUT, ":encoding(utf8)");
	#foreach $Ngram (sort {$$freqDict{$b} <=> $$freqDict{$a} || $a cmp $b} keys(%$freqDict)) {

	 #my  $freq_rel = ( $$freqDict{$Ngram} )/$N_words;
	 #$freq_rel = sprintf("%.6f", $freq_rel);
	 #my $ipm = $freq_rel * 1000000;
 	#print OUT $Ngram . "\t\t" . $$freqDict{$Ngram} . "\t" . $freq_rel . "\t" . $ipm . "\n"; 
	#}
	#close OUT;


