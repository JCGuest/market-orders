require './config/environment'

use SessionsController
# use UserController
# use OrderController
use Rack::MethodOverride
run ApplicationController