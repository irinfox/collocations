use utf8;

my $directory = @ARGV[0] || die "$! \n usage: perl programName dirName w(ord)|l(emma)";
my $param = @ARGV[1] || die "$! \n usage: perl programName dirName w(ord)|l(emma)";

my $punct = '(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*|\+)';

opendir(DIR, "$directory") || die $!;
print "open DIR \n"; #печать текущих состояний в консоль

while (defined($file = readdir(DIR))) { #открываем директорию
   $F++; #считаем количество файлов
   print "file $file \n";
   if ($file eq "." || $file eq "..") {next;} #пропускаем скрытые файлы
   open (IN, "<$directory/$file") or die "$!";#Открываем файлы по одному
   print "*** \n";
   while (<IN>) { #работаем с текущим файлом
         chomp; #убираем \n в конце строки
         @variants = split; 
	if ($param eq "w") {	
         	$word = $variants[0]; #работаем со словоформами
        }else {	
         	$word = $variants[1]; #работаем с леммами
	}
	unless ($word =~ $punct){#если не содержит знаки препинания, добавляется
		 $add{$word} = 1; #записываем в массив add слова, которые содержатся в файле, со значением в hash массиве равным 1 
  	}
   }
   close IN;
   foreach $word (keys(%add)) { #цикл по ключам массива add

         $file{$word} = $file{$word} + $add{$word}; #записываем в массив file слово и значение массива add (слово есть в документе => значение = 1),т.е. получим количество файлов, содержащих текущее слово. 

   }
   %add = {}; #обнуляем массив add
}
close DIR; #закрываем директорию

print "count idf \n";

foreach $word (keys(%file)) { #цикл по ключам массива file

   
   if ($file{$word} == 0) {next;} #пропускаем слова, которые не встретились в данном файле

   $idf{$word} = log($F/($file{$word}));  #считаем idf
}
%file = {}; # обнуляем массив file

#второй проход

opendir(DIR, "$directory") || die $!;
print "open $directory again \n";

while (defined($file = readdir(DIR))) {
   print "file $file \n";
   if ($file eq "." || $file eq "..") {next;}
   open (IN, "<$directory/$file") or die "$!";   
   print "*** \n";
   while (<IN>) {
      chomp;    
      @variants = split;
	if ($param eq "w") {	
         	$word = $variants[0]; #работаем со словоформами
        }else {	
         	$word = $variants[1]; #работаем с леммами
      }
	unless ($word =~ $punct){#если не содержит знаки препинания, добавляется
		$count{$word}++; #подсчитываем абс. частоту слов в документе
      		$N++; #считаем общее число строк в документе
   	}
     }
   close IN;
   
   $res = $file . "_tfidf"."_".$param; #присваиваем имя выходному файлу
   open (OUT, ">$res") || die $!; #запись в выходной файл
   print "open OUT " . $res . "\n"; #печать текущего состояния в консоль
   
   print "count tf idf \n";
   foreach $word (keys(%count)) {
        $tf{$word} = $count{$word} / $N; #считаем tf
   }
	#обнуление переменных для количества строк и частот слов
   $N = 0; 
   %count = {};
    
   foreach $word ( keys(%tf)) {
        $tfidf{$word} = $tf{$word} * $idf{$word}; #подсчёт tfidf
   }

   print "print tf idf \n";

   print OUT "слово (косегмент)" . "\t\t" . "tfidf" . "\t\t" . "tf" . "\t" . "idf" . "\n"; #верхняя строка выходного файла
   foreach $word (sort { $tfidf{$b} <=> $tfidf{$a} || $a cmp $b} keys %tfidf ) {
	print OUT $word . "\t" . $tfidf{$word} . "\t" . $tf{$word} . "\t" . $idf{$word} . "\n";   
   }#сортировка по значением метрики tfidf и печать в выходной файл
   %tf = {}; #обнуление массива tf
   %tfidf = {}; #обнуление массива tfidf
   close OUT;
  
}
close DIREC;
