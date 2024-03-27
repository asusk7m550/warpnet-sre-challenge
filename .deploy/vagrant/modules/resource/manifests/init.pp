# == Class: resource
#
class resource {
  $classes = lookup('resource::classes', Array[String], 'unique', [])
  if !empty($classes) {
    resource::load_class { $classes: }
  }
}
