package Jacquard::Web::Controller::Root;
# ABSTRACT: Jacquard root controller
use Moose;
use namespace::autoclean;
BEGIN { extends 'Catalyst::Controller::ActionRole' }

# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
__PACKAGE__->config(namespace => '');

sub index :Path :Args(0) {
  my ( $self, $c ) = @_;

  # Hello World
  $c->response->body( $c->welcome_message );
}

sub default :Path {
  my ( $self, $c ) = @_;
  $c->response->body( 'Page not found' );
  $c->response->status(404);
}

sub hello_user :Local :Does('NeedsLogin') {
  my( $self , $c ) = @_;

  my $name = $c->user->id;

  $c->response->body( "<h2>Hello, $name!</h2>" );
}

sub end :ActionClass('RenderView') {}

__PACKAGE__->meta->make_immutable;
1;
