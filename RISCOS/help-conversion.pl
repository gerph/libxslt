#!/usr/bin/perl
##
# Convert a help output into the form for the Help files.
#

my $input_file = shift;
my $output_file = shift || die "Syntax: $0 <input> <output> [<version file>]\n";
my $version_file = shift;

my $content = '';
my $version_content = '';
open(my $ifh, '<', $input_file) || die "Cannot read $input_file: $!\n";
while (<$ifh>)
{
    $content .= $_;
}
close($ifh);

if ($version_file)
{
    $version_content = '';
    open(my $ifh, '<', $version_file) || die "Cannot read $version_file: $!\n";
    while (<$ifh>)
    {
        $version_content .= $_;
    }
    close($ifh);
}
else
{
    $version_content = $content;
}

$version_content =~ /^.*port ([0-9]*.[0-9]*) \((...) (..) (....)\)/s;

my $tool = 'XSLTProc';
my ($version, $month, $day, $year) = ($1, $2, $3, $4);
if (!$tool)
{
    die "Cannot find version string in ". ($version_file or $input_file) . "\n";
}

$day += 0;
if ($day<10)
{
  $day="0$day";
}

$content =~ s/[^ ]*?\.$tool/$tool/g;

my $header = "$tool\t$version ($day $month $year)";

open(my $ofh, '>', $output_file) || die "Cannot write $output_file: $!\n";
print $ofh "$header\n";
print $ofh $content;
close($ofh);
