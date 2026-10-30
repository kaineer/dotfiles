local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

local telegram_bin = ctx.home + '/bin/telegram';
local tmp_archive = ctx.home + '/tmp/telegram.tar.xz';

[
  {
    name: 'Check for telegram installed',
    stat: { path: telegram_bin },
    register: 'telegram_link',
  },
  {
    name: 'Install Telegram Desktop',
    when: 'not telegram_link.stat.exists',
    block: [
      F.Dir(
        ctx.home + '/tmp',
        name='Create HOME/tmp directory',
        mode='0755',
      ),
      {
        name: 'Download Telegram Desktop binary',
        get_url: {
          url: 'https://telegram.org/dl/desktop/linux',
          dest: tmp_archive,
        },
      },
      F.Dir(
        ctx.home + '/bin/releases',
        name='Create HOME/bin/releases directory',
        mode='0755',
      ),
      {
        name: 'Unpack telegram binary',
        unarchive: {
          src: tmp_archive,
          dest: ctx.home + '/bin/releases',
          remote_src: true,
          owner: ctx.user.name,
          group: ctx.user.name,
          mode: '0755',
        },
      },
      F.Link(
        ctx.home + '/bin/releases/Telegram/Telegram',
        telegram_bin,
        name='Create symbolic link for telegram',
        mode='0755',
      ),
    ],
  },
]
