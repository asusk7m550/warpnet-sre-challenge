# == Class: resource::service
#
class resource::service {
  $cfg = lookup('resource::service', Tuple, 'unique', [])
  if !empty($cfg){
    $cfg.each |$key, $value| {
      $value.each |$path, $content| {
        create_resources('service', { $path => $content }, {})
      }
    }
  }
}
