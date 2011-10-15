package Jacquard::Web::View::TT;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

Jacquard::Web::View::TT - TT View for Jacquard::Web

=head1 DESCRIPTION

TT View for Jacquard::Web.

=head1 SEE ALSO

L<Jacquard::Web>

=head1 AUTHOR

genehack

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
