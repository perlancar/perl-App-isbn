package App::isbn;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;
use Log::ger;

our %SPEC:

$SPEC{drivers} = {
    v => 1.1,
    summary => 'List available drivers',
};
sub drivers {
    require App::lcpan::Call;

    my %args = @_;

    my $lres = call_lcpan_script(argv => ["mods", "-l", "--namespace", "WWW::Scraper::ISBN"]);
    return [412, "Can't call lcpan: $res->[0] - $res->[1]"] if $lres->[0] != 200;

    my $res = [200, "OK", []];
    for my $e (@{$lres->[2]}) {
        next unless $e->{module} =~ /::(\w+)_Driver$/;
        push @{$res->[2]}, $1;
    }

    $res;
}

1;
# ABSTRACT: Query book information by ISBN

=head1 SYNOPSIS

See L<isbn> script.

=cut
