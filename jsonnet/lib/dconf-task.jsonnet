// Creating DConf task
//
function(username, title, key, value) {
  name: title,
  become_user: username,
  dconf: {
    key: key,
    value: value,
  },
}
