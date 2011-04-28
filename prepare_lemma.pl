$file = shift @ARGV;
$result_file = $file . ".plain";

open (OUT, ">$result_file");
open (IN, "<$file") or die "$!";
while (<IN>) {
 @variants = split;
 
 
print OUT $variants[1] . " ";

# if ($variants[1] =~ /BASE/ || $variants[1] =~ /HREF/ || $variants[1] =~ /LABEL/) {
 # print OUT "\n";
# }
}
