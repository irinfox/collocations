$file = shift @ARGV;

open (IN, $file) || die $!;

$base = 1;
$name = 0;

open(OUT, ">$base") || or die $!;

while(<IN>) {
	if ($_ =~ "base_:") #{$base = 1;}
	#if ($base==1 && $_ =~ "#") {
	#	$name = 1;
	#	next;   
	#}
	#if ($base==1 && $name==1) {
	#	@title = split;
	#	$out = $title[0];
		close OUT;
		$base++;	
		open (OUT, ">$out");
	#	$name = 0;
	#	$base = 0;
	#	next;
	} 
	print OUT $_; 
	
}

close OUT;
close IN;











