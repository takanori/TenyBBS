package TenyBBS::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'TenyBBS::DB::Row';

table {
    name 'threads';
    pk 'id';
    columns qw(id title content created_at updated_at);

    inflate '^.+_at$' => sub {
        DateTime::Format::MySQL->parse_datetime(shift);
    };
    deflate '^.+_at$' => sub {
        DateTime::Format::MySQL->format_datetime(shift);
    };
};

table {
    name 'entries';
    pk 'id';
    columns qw(id thread_id author_name content created_at updated_at);

    inflate '^.+_at$' => sub {
        DateTime::Format::MySQL->parse_datetime(shift);
    };
    deflate '^.+_at$' => sub {
        DateTime::Format::MySQL->format_datetime(shift);
    };
};

1;
