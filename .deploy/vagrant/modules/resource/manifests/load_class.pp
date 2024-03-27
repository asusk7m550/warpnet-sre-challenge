# == Class: resource::load_class
#
define resource::load_class {
  create_resources('class', { "::resource::${name}" => {} }, {})
  notice("Created::resource::${name}")
}
