{
  user: {
    name: std.extVar('USER'),
    email: 'kaineer@gmail.com',
  },
  home: '/home/' + std.extVar('USER'),
  playbookDir: std.extVar('PLAYBOOK_DIR'),
  files: std.extVar('PLAYBOOK_DIR') + '/files',
}
