# == Class: resource::file
#
class resource::file {
  $cfg = lookup('resource::file', Tuple, 'unique', [])
  if !empty($cfg){
    $cfg.each |$key, $value| {
      $value.each |$path, $content| {
        create_resources('file', { $path => $content }, {})
      }
    }
  }
}
