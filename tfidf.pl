
$directory = shift @ARGV;

opendir(DIR, "$directory") || die $!;
print "open DIR \n";

while (defined($file = readdir(DIR))) {
   $F++;
   print "file $file \n";
   if ($file eq "." || $file eq "..") {next;}
   open (IN, "<$directory/$file") or die "$!";
   print "*** \n";
   while (<IN>) {
         chomp;
         @variants = split;
         $word = $variants[0];
         $add{$word} = 1; 
   }
   close IN;
   foreach $word (keys(%add)) {

         $file{$word} = $file{$word} + $add{$word};

   }
   %add = {};
}
close DIR;

print "count idf \n";

foreach $word (keys(%file)) {

   
   if ($file{$word} == 0) {next;}

   $idf{$word} = log($F/($file{$word}));  
}
%file = {};


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
      $word = $variants[0] ;
      $count{$word}++;
      $N++;
   }
   close IN;
   
   $res = $file . "_tfidf";
   open (OUT, ">$res") || die $!;
   print "open OUT" . $res . "\n";
   
   print "count tf idf \n";
   foreach $word (keys(%count)) {
        $tf{$word} = $count{$word} / $N;
   }
   $N = 0;
   %count = {};
    
   foreach $word ( keys(%tf)) {
        $tfidf{$word} = $tf{$word} * $idf{$word}; 
   }
   %tf = {}; 

   print "print tf idf \n";

   foreach $word (sort { $tfidf{$b} <=> $tfidf{$a} || $a cmp $b} keys %tfidf ) {
       print OUT $word . "\t" . $tfidf{$word} . "\n";   
   }
   %tfidf = {};
   close OUT;
  
}
close DIREC;
