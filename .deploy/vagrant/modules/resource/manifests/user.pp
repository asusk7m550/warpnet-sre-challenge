# == Class: resource::user
#
class resource::user {
  $cfg = lookup('resource::user', Hash, 'unique', {})
  if !empty($cfg){
    create_resources('user', { $cfg => {} }, {})
  }
}
