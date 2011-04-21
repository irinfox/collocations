#разбивает исходный файл на файлы по миллиону строк и считает для каждого из них абсолютные частоты. NB! файл должен быть лемматизирован и вытянут в строку
use utf8;
use Encode;

binmode(STDOUT, ":encoding(utf8)");

$file_name = shift @ARGV || die "$! \n usage: FILE_NAME";
$main_output = $file_name;
#Создание переменных для файла-исходника и результирующего файла

print "read file $file_name \n";
#Печать текущих состояний
open (IN, "<$file_name") || die $!;
binmode (IN, ":encoding(utf8)");

$mln = 0;#Переменная-счётчик
while (<IN>) {
	$mln++;
	$N++;
	#Наращивание переменной-счётчика и переменной количества строк

#print $mln . "\t" . $N . "\n";

	chomp;
	#Переменные, запоминаниющие предыдущие слова. Нужны для составления частотных словарей.
	$x_4 = $x_3;
	$x_3 = $x_2;
	$x_2 = $x_1;
	$x_1 = $x; 
	$x = $_;
#if ($x =~ /[a-zA-Z]/ || $x_1 =~ /[a-zA-Z]/ || $x_2 =~ /[a-zA-Z]/) {next;}
# /(\.|\;|\:|\"|\'|\!|\?|\(|\)|\,|\-|\\|\/|\„|\Ѓ|\»|\«|\—|\~|\[|\]|\{|\}|\||\*|\+)/)  {

	#Склеивание переменных для образования 1-5 грамм и создание частотных словарей
	$p1{$x}++;
	$bi = $x_1 . "\t" . $x;
	$p2{$bi}++;
	$tri = $x_2 . "\t" . $x_1 . "\t" . $x;
	$p3{$tri}++;
	$four = $x_3 . "\t" . $x_2 . "\t" . $x_1 . "\t" . $x;
	$p4{$four}++;
	$five = $x_4 . "\t" . $x_3 . "\t" . $x_2 . "\t" . $x_1 . "\t" . $x;
	$p5{$five}++;

	if ($mln >= 10) {
		$name = $name + 1000000;
		#Обновление имени выходного файла (обработанный миллион строк)
		#print_freqs;
		#Здесь нужно вызвать подпрограмму для печати частотных словарей
	#}
	#if ($mln < 1000000 && IN eq '') {
	#	$name = "tail";
		#Обновление имени выходного файла (остаток файла)
	#	print_freqs;	
		#вызов подпрограммы
	#}
	#sub print_freqs {
		$mln = 0;
		#Обнуление счётчика, обновление имени выходного файла (обработанный миллион строк)
		print "N: $N\n";
		print "print freqs \n";

		#Печать частотного словаря для однословных конструкций 
		print "print words freq \n";
		$out = $name . "_1_" . $main_output;
		open (OUT, ">$out");
		binmode (OUT, ":encoding(utf8)");
		foreach $x ( sort {$p1{$b} <=> $p1{$a} || $a cmp $b} keys(%p1)) {
			 print OUT $x . "\t" . $p1{$x} . "\n";
		}
		#сортировка по убыванию частот либо по алфавиту
		close OUT;
		%p1 = ();
		#очистка переменной для частотного словаря 1грамм  
	
		#всё то же самое для биграмм
		print "print 2_words freq \n";
		$out = $name . "_2_" . $main_output;
		open (OUT, ">$out");
		binmode (OUT, ":encoding(utf8)");
		foreach $bi (sort {$p2{$b} <=> $p2{$a} || $a cmp $b} keys(%p2)) {
			 print OUT $bi . "\t" . $p2{$bi} . "\n"; 
		}
		close OUT;
		%p2 = ();

		#всё то же для 3грамм
		print "print 3_words freq \n";
		$out = $name . "_3_" . $main_output;
		open (OUT, ">$out");
		binmode (OUT, ":encoding(utf8)");
		foreach $tri (sort {$p3{$b} <=> $p3{$a} || $a cmp $b} keys(%p3)) {
		 	print OUT $tri . "\t" . $p3{$tri} . "\n";
		}
		close OUT;
		%p3 = ();

		#для 4грамм
		print "print 4_words freq \n";
		$out = $name . "_4_" . $main_output;
		open (OUT, ">$out");
		binmode (OUT, ":encoding(utf8)");
		foreach $four (sort {$p4{$b} <=> $p4{$a} || $a cmp $b} keys(%p4)) {
			 print OUT $four . "\t" . $p4{$four} . "\n";
		}
		close OUT;
		%p4 = ();

		#для 5грамм
		print "print 5_words freq \n";
		$out = $name . "_5_" . $main_output;
		open (OUT, ">$out");
		binmode (OUT, ":encoding(utf8)");
		foreach $five (sort {$p5{$b} <=> $p5{$a} || $a cmp $b} keys(%p5)) {
		 print OUT $five . "\t" . $p5{$five} . "\n";
		}
		close OUT;
		%p5 = ();
	}

}
close IN;
