package TenyBBS::DB::Schema;
use strict;
use warnings;
use utf8;

use Teng::Schema::Declare;

base_row_class 'TenyBBS::DB::Row';

table {
    name 'threads';
    pk 'id';
    columns qw(id author_name title content created_at updated_at);
};

table {
    name 'entries';
    pk 'id';
    columns qw(id thread_id author_name content created_at updated_at);
};

1;
