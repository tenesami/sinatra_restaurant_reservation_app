require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

#send PATCH and DELETE requests
use Rack::MethodOverride
use ReservationEntriesController 
use UsersController
run ApplicationController
