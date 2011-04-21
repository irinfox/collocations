#слияние файлов из директории в один файл с пересчётом частот
$directory = shift @ARGV;
$result_file =  shift @ARGV;
#Создание переменных для исходной директории и реузльтирующего файло

opendir(DIR, "$directory") || die $!;
#открываем директорию
print "open DIR \n";
#печать текующих состояний
while (defined($file = readdir(DIR))) {
#считывает файлы из исходной директории в переменную file
	print ++$t ."_file: " . $file . "\n";

	if ($file eq "." || $file eq "..") {next;}
	open (IN, "<$directory/$file") or die "$!";
	print "*** \n";
	while (<IN>) {
		 chomp;
		 @words = split;
		 $freq = pop(@words);
		#записывает в переменную freq последний элемент из массива words
		  foreach $word (@words) {
			   $colloc = $colloc . $word . "\t";
		  }
		 $p{$colloc} = $p{$colloc} + $freq;
		#пересчёт частот
		# print $colloc . "\t" . $p{$colloc} . "\n";
		 $colloc=""; 
		 $N = $N+$freq;
	}
	close IN;
}

open (OUT, ">$result_file") || die $!;
#открываем результирующий файл
print "open OUT \n";

foreach $colloc (sort {$p{$b} <=> $p{$a} || $a cmp $b} keys(%p)) {
	 print OUT $colloc . $p{$colloc} . "\n"; 
}
#сортировка коллокаций в файле по убыванию частот либо по алфавиту при совпадении частот и печать файла.
close OUT;

print "N: $N \n";
