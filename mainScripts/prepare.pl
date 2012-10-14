use utf8;
use Encode;

binmode(STDOUT, ":encoding(utf8)");

$dir = "corpus";

opendir(DIR, "$dir") || die $!;

while (defined($file = readdir(DIR))) {
 print "file: $file \n";
 if ($file eq "." || $file eq "..") {next;}

 open (FILE, "$dir/$file") || die "$! $file";
 binmode(FILE, ":encoding(utf8)");

 $out = $dir . "/" . $file . ".plain";
 open (OUT, ">$out") || die $!;
 binmode(OUT, ":encoding(utf8)");

 while (<FILE>) {  
    tr/А-Я/а-я/;
   $_ =~ s/(\.|\;|\:|\"|\'|\"|\!|\?|\(|\))/ $1 /g; 
   $_ =~ s/(\D)(\,)(\D)/$1 $2 $3/g;   
   $_ =~ s/ +/ /g;
   $_ =~ s/^ //g;
   $_ =~ s/ $//g; 

   print OUT "$_";
 }
 
 close FILE;
 close OUT;
}
