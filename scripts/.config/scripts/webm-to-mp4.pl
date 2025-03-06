use strict;
use warnings;
use File::Basename;

if (@ARGV != 1) {
    die "No directory provided.\n";
}

my $directory = $ARGV[0];

opendir(my $dir, $directory) or die "Could not open directory: '$directory': $!\n";

sub peg_me {
    my ($file_path) = @_;
    my $file = basename($file_path);

    my @parts = split(/\./, $file);
    my $name = shift @parts;
    my $ext = join(".", @parts);

    if ($ext eq "webm") {
        my $output_file = "$directory/$name.mp4";

        open(my $fh, "-|", "ffmpeg -i \"$file_path\" \"$output_file\"")
            or die "Failed to run ffmpeg: $!";

        while (<$fh>) {
            print $_;
        }
        close($fh);
    }
}

while (my $file = readdir($dir)) {
    next if ($file eq '.' || $file eq '..');

    my $file_path = "$directory/$file";
    if (-f $file_path) {
        peg_me($file_path)
    }
}

closedir($dir);
