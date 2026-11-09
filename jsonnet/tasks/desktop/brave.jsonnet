[
  {
    name: 'Check if brave in installed',
    stat: { path: '/usr/bin/brave-browser' },
    register: 'brave_binary',
  },
  {
    name: 'Install brave browser',
    when: 'not brave_binary.stat.exists',
    block: [
      {
        name: 'Install curl',
        package: {
          name: 'curl',
          state: 'present',
        },
      },
      {
        name: 'Install apt key for brave browser',
        apt_key: {
          url: 'https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg',
          keyring: '/usr/share/keyrings/brave-browser-archive-keyring.gpg',
        },
      },
      {
        name: 'Add apt repository for brave browser',
        apt_repository: {
          repo: 'deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main',
          state: 'present',
        },
      },
      {
        name: 'Install brave browser package',
        apt: {
          name: 'brave-browser',
          update_cache: true,
        },
      },
    ],
  },
]
