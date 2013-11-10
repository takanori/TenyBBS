use strict;
use warnings;
use utf8;
use t::Util;
use Plack::Test;
use Plack::Util;
use Test::More;
use Time::Piece;

my $teny = TenyBBS->new;
my $db = $teny->db;


{
    # DB setup

    my @titles = qw/foo bar baz/;
    for my $title (@titles) {
        $db->insert(thread => {
            title => $title,
            created_at => Time::Piece->new,
        });
    }
}

# test
my @res = $db->search('thread');
cmp_ok @res, '==', 3;

done_testing;
