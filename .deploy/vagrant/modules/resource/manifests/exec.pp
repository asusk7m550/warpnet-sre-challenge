# == Class: resource::exec
#
class resource::exec {
  $cfg = lookup('resource::exec', Tuple, 'unique', [])
  if !empty($cfg){
    $cfg.each |$key, $value| {
      $value.each |$path, $content| {
        create_resources('exec', { $path => $content }, {})
      }
    }
  }
}
