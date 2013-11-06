# Include hook code here
require 'acts_as_noteable'
ActiveRecord::Base.send(:include, Flvorful::Acts::Noteable)

require 'noteable_helper'
ActionView::Base.send :include, Flvorful::Noteable::Helper